From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 10:16:01 -0400
Message-ID: <20140903141601.GA1866@datura.dylex.net>
References: <20140902174659.GA1811@datura.dylex.net>
 <54062150.2010800@gmail.com>
 <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
 <20140903023531.GA1128@datura.dylex.net>
 <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
 <20140903081723.GA1153@datura.dylex.net>
 <alpine.LNX.2.00.1409031021230.12309@pobox.suse.cz>
 <20140903130348.GA1161@datura.dylex.net>
 <alpine.LNX.2.00.1409031509070.12309@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:36896 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354AbaICOQE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 10:16:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1409031509070.12309@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

> Hrm, what we really want is to first destroy the LED interface, otherwise 
> someone might have re-queued the workqueue through thingm_led_set() after 
> it has been flushed / cancelled already.
> 
> Could you please give it one more shot with the patch below? Thanks for 
> your prompt testing.
> 
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 134be89..3d8cf5e 100644
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
> +	cancel_work_sync(&rgb->work);
>  }
>  
>  static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> @@ -286,10 +286,10 @@ static void thingm_remove(struct hid_device *hdev)
>  	struct thingm_device *tdev = hid_get_drvdata(hdev);
>  	int i;
>  
> +	hid_hw_stop(hdev);
> +
>  	for (i = 0; i < tdev->fwinfo->numrgb; ++i)
>  		thingm_remove_rgb(tdev->rgb + i);
> -
> -	hid_hw_stop(hdev);
>  }
>  
>  static const struct hid_device_id thingm_table[] = {
> 

I think that did the trick.  I've run through the whole cycle about 20 times
in various conditions, and it seems solid so far.  Thanks!
