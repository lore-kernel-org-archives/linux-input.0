From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 10:21:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409031021230.12309@pobox.suse.cz>
References: <20140902174659.GA1811@datura.dylex.net> <54062150.2010800@gmail.com> <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz> <20140903023531.GA1128@datura.dylex.net> <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
 <20140903081723.GA1153@datura.dylex.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57642 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbaICIV5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 04:21:57 -0400
In-Reply-To: <20140903081723.GA1153@datura.dylex.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dylan Alex Simon <dylan-kernel@dylex.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Wed, 3 Sep 2014, Dylan Alex Simon wrote:

> > Alright, this supports my original hunch. I think I see the race. Could 
> > you please try the patch below? Thanks.
> > 
> > 
> > 
> > 
> > diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> > index 134be89..743a517 100644
> > --- a/drivers/hid/hid-thingm.c
> > +++ b/drivers/hid/hid-thingm.c
> > @@ -208,7 +208,7 @@ unregister_red:
> >  
> >  static void thingm_remove_rgb(struct thingm_rgb *rgb)
> >  {
> > -	flush_work(&rgb->work);
> > +	cancel_work_sync(&rgb->work);
> >  	led_classdev_unregister(&rgb->red.ldev);
> >  	led_classdev_unregister(&rgb->green.ldev);
> >  	led_classdev_unregister(&rgb->blue.ldev);
> 
> Same problem (only rmmod this time, no write error, but still
> doesn't happen every time):

I sent you wrong version of the patch, sorry for that. Could you please 
try the one below instead?


diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 134be89..dffc50d 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -208,7 +208,7 @@ unregister_red:
 
 static void thingm_remove_rgb(struct thingm_rgb *rgb)
 {
-	flush_work(&rgb->work);
+	cancel_work_sync(&rgb->work);
 	led_classdev_unregister(&rgb->red.ldev);
 	led_classdev_unregister(&rgb->green.ldev);
 	led_classdev_unregister(&rgb->blue.ldev);
@@ -286,10 +286,10 @@ static void thingm_remove(struct hid_device *hdev)
 	struct thingm_device *tdev = hid_get_drvdata(hdev);
 	int i;
 
+	hid_hw_stop(hdev);
+
 	for (i = 0; i < tdev->fwinfo->numrgb; ++i)
 		thingm_remove_rgb(tdev->rgb + i);
-
-	hid_hw_stop(hdev);
 }
 
 static const struct hid_device_id thingm_table[] = {

> 
-- 
Jiri Kosina
SUSE Labs
