import "android.app.Activity"
import "android.os.Bundle"
import "android.widget.TextView"
import "android.content.Context"
import "Layout", "org.bostonandroid.bostonandroid.R$layout"
import 'org.scribe.builder.ServiceBuilder'
import 'org.scribe.builder.api.TwitterApi'
import 'android.util.Log'
import 'android.content.Intent'
import 'android.net.Uri'
import 'OnClickListener', 'android.view.View$OnClickListener'
import 'android.view.View'

class Rsvp < Activity
  def onCreate(savedInstanceState:Bundle)
    super(savedInstanceState)
    setContentView(Layout.main)
    @service = ServiceBuilder.new.provider(TwitterApi.class).apiKey('MHh93nifUw9Kw7w5oqNaKg').apiSecret('4vzkkbMf6IpLFcdGTF9Y5JGlxu1IS1xlJtjk5FY0').callback('boston-android:///').build
    findViewById(R.id.rsvp_button).setOnClickListener(RsvpClickListener.new(self))
  end

  class RsvpClickListener
    implements OnClickListener

    def initialize(rsvp:Rsvp)
      @rsvp = rsvp
    end

    def onClick(view:View)
      @rsvp.authorizeTwitter
    end
  end

  def onNewIntent(intent:Intent)
    setIntent(intent)
  end

  def onResume
    super()
    data = getIntent.getData
    Log.d("HelloWorld", data.getQueryParameter('oauth_verifier')) unless data.nil?
  end

  def authorizeTwitter
    startActivity(Intent.new(Intent.ACTION_VIEW, Uri.parse("https://twitter.com/oauth/authorize?oauth_token=#{@service.getRequestToken.getToken}")))
  end
end
