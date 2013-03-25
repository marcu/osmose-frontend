%rss="http://"+website+"/byuser/"+username+".rss"
%rebase layout title=(_("Statistics for user %s") % ", ".join(users)), rss=rss
<h1>{{_("User statistics for %s") % ", ".join(users)}}</h1>
<p>{{_("This page shows errors on elements that were last modified by '%s'. This doesn't means that this user is responsible for all these errors.") % "', '".join(users)}}</p>
<p><a href="{{rss}}">{{_("This list is also available via rss.")}}</a></p>
<p>
%if count < 500:
    {{_("Number of found errors: %d") % count}}
%else:
    {{_("Number of found errors: more than %d") % count}}
%end
 - 
<a href='../map/?username={{username}}'>{{_("Show errors on a map")}}</a>
</p>

<table class='sortable'>
  <tr>
    <th></th>
    <th>{{_("item")}}</th>
    <th>{{_("class (abbreviation)")}}<span id="sorttable_sortfwdind">&nbsp;▾</span></th>
    <th>{{_("level (abbreviation)")}}</th>
    <th>{{_("Title")}}</th>
    <th>{{_("Error")}}</th>
    <th title="{{_("information on error")}}">E</th>
    <th>josm</th>
    <th title="{{_("position")}}">{{_("position (abbreviation)")}}</th>
  </tr>

%for res in results:
  <tr>
    <td title="{{res["item"]}}"><img src="../images/markers/marker-l-{{res["item"]}}.png" alt="{{res["item"]}}"></td>
    <td><a href="?username={{username}}&amp;item={{res["item"]}}">{{res["item"]}}</a></td>
    <td>{{res["class"]}}</td>
    <td>{{res["level"]}}</td>
    <td>{{translate.select(res["title"])}}</td>
    <td>
%    if res["subtitle"]:
        {{translate.select(res["subtitle"])}}
%    end
    </td>
    <td title="erreur n°{{res["id"]}}"><a href="../error/{{res["id"]}}">E</a></td>
%    lat = res["lat"] or 0
%    lon = res["lon"] or 0
%    minlat = float(lat) - 0.002
%    maxlat = float(lat) + 0.002
%    minlon = float(lon) - 0.002
%    maxlon = float(lon) + 0.002
    <td><a href="http://localhost:8111/load_and_zoom?left={{minlon}}&amp;bottom={{minlat}}&amp;right={{maxlon}}&amp;top={{maxlat}}" target="hiddenIframe">josm</a></td>
%    cl = res["class"]
%    source = res["source"]
%    item = res["item"]
%    level = res["level"]
%    lat_s = "%.2f" % lat
%    lon_s = "%.2f" % lon
    <td><a href="../map/?zoom=16&amp;lat={{lat}}&amp;lon={{lon}}&amp;item={{item}}&amp;level={{level}}" target="hiddenIframe">{{lon_s}}&nbsp;{{lat_s}}</a></td>
  </tr>
%end
</table>

<iframe id="hiddenIframe" name="hiddenIframe"></iframe>
