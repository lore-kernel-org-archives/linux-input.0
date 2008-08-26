From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch]full runtime power management for usbhid
Date: Tue, 26 Aug 2008 12:49:15 +0300
Message-ID: <20080826094915.GQ20450@gandalf.research.nokia.com>
References: <200808261139.14410.oliver@neukum.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25384 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYHZJuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2008 05:50:22 -0400
Content-Disposition: inline
In-Reply-To: <200808261139.14410.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Oliver Neukum <oliver@neukum.org>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Tue, Aug 26, 2008 at 11:39:13AM +0200, ext Oliver Neukum wrote:
> --- a/drivers/hid/usbhid/usbhid.h	2008-05-06 13:49:51.000000000 +0200
> +++ b/drivers/hid/usbhid/usbhid.h	2008-05-06 14:58:49.000000000 +0200
> @@ -37,7 +37,10 @@ int usbhid_wait_io(struct hid_device* hi
>  void usbhid_close(struct hid_device *hid);
>  int usbhid_open(struct hid_device *hid);
>  void usbhid_init_reports(struct hid_device *hid);
> -void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir);
> +void usbhid_submit_report
> +(struct hid_device *hid, struct hid_report *report, unsigned char dir);

void usbhid_submit_report(struct hid_device *hid,
	struct hid_report *report, unsigned char dir);

would look better. Matter of taste. ditto below.

>  	switch (urb->status) {
>  		case 0:			/* success */
> +			usbhid_mark_busy(usbhid);	
						 ^^^^^^^
			you added whitespaces there

-- 
balbi
