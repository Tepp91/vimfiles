import vim
from . import util


# ----------------------------------------------------------------------
def open(path1, rev1, path2, rev2):
    with util.P4Connect() as p4:
        __open_impl(p4, path1, rev1, path2, rev2)


# ----------------------------------------------------------------------
def __open_impl(p4, path1, rev1, path2, rev2):
    path1 = util.P4Util.export_to_tmppath(p4, path1, rev1)
    path2 = util.P4Util.export_to_tmppath(p4, path2, rev2)

    vim.command('tabnew ' + path1)
    vim.command('diffthis')
    vim.current.buffer.options['modifiable'] = False
    vim.current.buffer.options['swapfile'] = False

    vim.command('vnew ' + path2)
    vim.command('diffthis')
    vim.current.buffer.options['modifiable'] = False
    vim.current.buffer.options['swapfile'] = False

    vim.command('normal gg')


# ----------------------------------------------------------------------
def open_head(path):
    with util.P4Connect() as p4:
        __open_head_impl(p4, path)


# ----------------------------------------------------------------------
def __open_head_impl(p4, path):
    depot_file_list = p4.run_filelog(path)
    if len(depot_file_list) == 0:
        return

    depot_file = depot_file_list[0]
    head_rev = depot_file.revisions[0].rev

    head_path = util.P4Util.export_to_tmppath(p4, path, head_rev)

    vim.command('tabnew ' + path)
    vim.command('diffthis')

    vim.command('vnew ' + head_path)
    vim.command('diffthis')
    vim.current.buffer.options['modifiable'] = False
    vim.current.buffer.options['swapfile'] = False

    vim.command('normal gg')
