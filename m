From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Eliminate double kfree
Date: Thu, 29 May 2008 11:33:39 -0400
Message-ID: <20080529101012.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0805291504400.26229@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38426 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbYE2Pdr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2008 11:33:47 -0400
Received: by ug-out-1314.google.com with SMTP id h2so119374ugf.16
        for <linux-input@vger.kernel.org>; Thu, 29 May 2008 08:33:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0805291504400.26229@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Julia,

On Thu, May 29, 2008 at 03:05:07PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> The variable report is only non-NULL and non-freed in a small region of
> code, so it should only be freed in error handling code that comes from
> that region.
> 

Thank you for your patch. There isn't a double-kfree though, as far
as I can see. Because we need to free the report in both success and
failure cases the error handling is a bit unwieldy I agree. I don't
want to apply your patch though because I don't like when we bypass
parts of error handling path that weren't bypassed if we aborted
earlier, if you follow me.

What do you think about the patch below?

-- 
Dmitry

Input: gtco - clean up error handling in gtco_probe

Thanks to Julia Lawall for noticing ugliness.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/tablet/gtco.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: linux/drivers/input/tablet/gtco.c
===================================================================
--- linux.orig/drivers/input/tablet/gtco.c
+++ linux/drivers/input/tablet/gtco.c
@@ -830,7 +830,7 @@ static int gtco_probe(struct usb_interfa
 	struct gtco             *gtco;
 	struct input_dev        *input_dev;
 	struct hid_descriptor   *hid_desc;
-	char                    *report = NULL;
+	char                    *report;
 	int                     result = 0, retry;
 	int			error;
 	struct usb_endpoint_descriptor *endpoint;
@@ -916,12 +916,16 @@ static int gtco_probe(struct usb_interfa
 					 le16_to_cpu(hid_desc->wDescriptorLength),
 					 5000); /* 5 secs */
 
-		if (result == le16_to_cpu(hid_desc->wDescriptorLength))
+		dbg("usb_control_msg result: %d", result);
+		if (result == le16_to_cpu(hid_desc->wDescriptorLength)) {
+			parse_hid_report_descriptor(gtco, report, result);
 			break;
+		}
 	}
 
+	kfree(report);
+
 	/* If we didn't get the report, fail */
-	dbg("usb_control_msg result: :%d", result);
 	if (result != le16_to_cpu(hid_desc->wDescriptorLength)) {
 		err("Failed to get HID Report Descriptor of size: %d",
 		    hid_desc->wDescriptorLength);
@@ -929,12 +933,6 @@ static int gtco_probe(struct usb_interfa
 		goto err_free_urb;
 	}
 
-	/* Now we parse the report */
-	parse_hid_report_descriptor(gtco, report, result);
-
-	/* Now we delete it */
-	kfree(report);
-
 	/* Create a device file node */
 	usb_make_path(gtco->usbdev, gtco->usbpath, sizeof(gtco->usbpath));
 	strlcat(gtco->usbpath, "/input0", sizeof(gtco->usbpath));
@@ -988,7 +986,6 @@ static int gtco_probe(struct usb_interfa
 	usb_buffer_free(gtco->usbdev, REPORT_MAX_SIZE,
 			gtco->buffer, gtco->buf_dma);
  err_free_devs:
-	kfree(report);
 	input_free_device(input_dev);
 	kfree(gtco);
 	return error;
