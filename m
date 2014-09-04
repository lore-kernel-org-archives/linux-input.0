From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 21:05:19 -0400
Message-ID: <20140904010519.GA13189@datura.dylex.net>
References: <54062150.2010800@gmail.com>
 <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
 <20140903023531.GA1128@datura.dylex.net>
 <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
 <20140903081723.GA1153@datura.dylex.net>
 <alpine.LNX.2.00.1409031021230.12309@pobox.suse.cz>
 <20140903130348.GA1161@datura.dylex.net>
 <alpine.LNX.2.00.1409031509070.12309@pobox.suse.cz>
 <20140903141601.GA1866@datura.dylex.net>
 <alpine.LNX.2.00.1409031636170.12309@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:36984 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933102AbaIDBFX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 21:05:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1409031636170.12309@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

>From Jiri Kosina <jkosina@suse.cz>, Wed, Sep 03, 2014 at 04:37:05PM +0200:
> On Wed, 3 Sep 2014, Dylan Alex Simon wrote:
> 
> > I think that did the trick.  I've run through the whole cycle about 20 times
> > in various conditions, and it seems solid so far.  Thanks!
> 
> Thanks. I actually think that the minimal necessary fix is below. Could 
> you please do a (hopefully last) round of testing with just this patch 
> applied?
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 134be89..c1d21fa 100644
> --- a/drivers/hid/hid-thingm.c
> +++ b/drivers/hid/hid-thingm.c
> @@ -208,10 +208,10 @@ unregister_red:
>  
>  static void thingm_remove_rgb(struct thingm_rgb *rgb)
>  {
> -	flush_work(&rgb->work);
>  	led_classdev_unregister(&rgb->red.ldev);
>  	led_classdev_unregister(&rgb->green.ldev);
>  	led_classdev_unregister(&rgb->blue.ldev);
> +	flush_work(&rgb->work);
>  }
>  
>  static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> 

(Sorry, didn't get a chance back at the machine until now.)  This seems to be
working fine, as well.  I now do get the "failed to write color" messages
again when unplugging, which didn't show up with the other patch, but no
panics.
