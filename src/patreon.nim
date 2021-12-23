## Main module of patreon

import std/asyncdispatch
from std/httpclient import newAsyncHttpClient, newHttpHeaders, close,
                           getContent, AsyncHttpClient
from std/json import JsonNode, `{}`, parseJson, hasKey, items,
                     add, getStr, newJArray, `$`
from std/strutils import `%`

from pkg/useragent import mozilla

const firstUrl = "https://www.patreon.com/api/posts?include=campaign%2Caccess_rules%2Cattachments%2Caudio%2Cimages%2Cmedia%2Cpoll.choices%2Cpoll.current_user_responses.user%2Cpoll.current_user_responses.choice%2Cpoll.current_user_responses.poll%2Cuser%2Cuser_defined_tags%2Cti_checks&fields[campaign]=currency%2Cshow_audio_post_download_links%2Cavatar_photo_url%2Cearnings_visibility%2Cis_nsfw%2Cis_monthly%2Cname%2Curl&fields[post]=change_visibility_at%2Ccomment_count%2Ccontent%2Ccurrent_user_can_comment%2Ccurrent_user_can_delete%2Ccurrent_user_can_view%2Ccurrent_user_has_liked%2Cembed%2Cimage%2Cis_paid%2Clike_count%2Cmeta_image_url%2Cmin_cents_pledged_to_view%2Cpost_file%2Cpost_metadata%2Cpublished_at%2Cpatreon_url%2Cpost_type%2Cpledge_url%2Cthumbnail_url%2Cteaser_text%2Ctitle%2Cupgrade_url%2Curl%2Cwas_posted_by_campaign_owner%2Chas_ti_violation&fields[post_tag]=tag_type%2Cvalue&fields[user]=image_url%2Cfull_name%2Curl&fields[access_rule]=access_rule_type%2Camount_cents&fields[media]=id%2Cimage_urls%2Cdownload_url%2Cmetadata%2Cfile_name&filter[campaign_id]=$1&filter[contains_exclusive_posts]=true&filter[is_draft]=false&sort=-published_at&json-api-version=1.0"

proc main(cookies, id, output: string) {.async.} =
  let client = newAsyncHttpClient(headers = newHttpHeaders({
    "Cookie": cookies,
    "User-Agent": mozilla,
  }))
  echo id
  var url = firstUrl % id
  var data = newJArray()
  while true:
    let node = parseJson await client.getContent url
    for x in node{"data"}:
      data.add x
    if not node.hasKey "links":
      break
    url = node{"links"}{"next"}.getStr
  close client
  writeFile(output, $data)
  
when isMainModule:
  import cligen
  proc tmp(cookies, id, output: string) =
    waitFor main(cookies, id, output)
  dispatch tmp
