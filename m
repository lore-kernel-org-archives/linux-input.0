From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 12:58:32 +0200
Message-ID: <200804031258.32582.oliver@neukum.org>
References: <dd18b0c30804012331oc548416k113e492d7dc9c189@mail.gmail.com> <200804031029.26635.oliver@neukum.org> <e79639220804030153q46fa82c7jb79bedbe88b30df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42029 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbYDCLAo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 07:00:44 -0400
In-Reply-To: <e79639220804030153q46fa82c7jb79bedbe88b30df7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schweizer <genstef@gentoo.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Donnerstag, 3. April 2008 10:53:53 schrieb Stefan Schweizer:
> >  On second thought, this should be fixed by usb persist if the appletouch
> >  driver supported reset_resume. Would you be willing to test a kernel patch
> >  that implements reset_resume in the appletouch driver?
> 
> Sure, I would love to have this fixed :-)

Hi,

here I have another test request. This patch on top of the earlier patch
implements autosuspend for the appletouch driver. Can you try it? You
also need to activate it as described in Documentation/usb/power-management.txt

	Regards
		Oliver

---

--- linux-2.6.25-rc7-work/drivers/input/mouse/appletouch.c.alt	2008-04-03 12:46:06.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/mouse/appletouch.c	2008-04-03 12:46:24.000000000 +0200
@@ -572,16 +572,26 @@ exit:
 static int atp_open(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
+	int rv;
 
 	mutex_lock(&dev->lock);
-	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
-		mutex_unlock(&dev->lock);
-		return -EIO;
-	}
+
+	rv = usb_autopm_get_interface(dev->intf);
+	if ( rv < 0)
+		goto err_out;
+
+	rv = usb_submit_urb(dev->urb, GFP_KERNEL);
+	if (rv < 0)
+		goto err_put;
 
 	dev->open = 1;
+	dev->intf->needs_remote_wakeup = 1;
+
+err_put:
+	usb_autopm_put_interface(dev->intf);
+err_out:
 	mutex_unlock(&dev->lock);
-	return 0;
+	return rv;
 }
 
 static void atp_close(struct input_dev *input)
@@ -592,6 +602,7 @@ static void atp_close(struct input_dev *
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
 	dev->open = 0;
+	dev->intf->needs_remote_wakeup = 0;
 	mutex_unlock(&dev->lock);
 }
 

