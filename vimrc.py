import vim

# C++用に名前空間を出力する
def write_cpp_namespace(ns_list):
    text = ""
    for ns in ns_list:
        text += 'namespace {0}{{\n'.format(ns)

    ns_list.reverse()

    for ns in ns_list:
        text += '}} // namespace {0}\n'.format(ns)

    vim.options['paste'] = True
    vim.command("normal i" + text)
    vim.options['paste'] = False
