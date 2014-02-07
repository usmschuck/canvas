require [
  'jquery'
  'compiled/models/WikiPage'
  'compiled/views/wiki/WikiPageView'
], ($, WikiPage, WikiPageView) ->

  $('body').addClass('pages show')

  wikiPage = new WikiPage ENV.WIKI_PAGE, contextAssetString: ENV.context_asset_string

  wikiPageView = new WikiPageView
    model: wikiPage
    wiki_pages_path: ENV.WIKI_PAGES_PATH
    wiki_page_edit_path: ENV.WIKI_PAGE_EDIT_PATH
    WIKI_RIGHTS: ENV.WIKI_RIGHTS
    PAGE_RIGHTS: ENV.PAGE_RIGHTS
  $('#content').append(wikiPageView.$el)

  wikiPageView.render()
