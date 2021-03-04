module RedmineCommitLinks
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(_context = {})
      stylesheet_link_tag('redmine_commit_links.css',
                          plugin: 'redmine_commit_links')
    end

    render_on(:view_issues_sidebar_queries_bottom,
              partial: 'commit_links/box')
  end
end
