From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: appletouch - driver refactoring
Date: Mon, 27 Oct 2008 23:03:55 -0400
Message-ID: <20081028030355.GA2898@anvil.corenet.prv>
References: <1223542147.6130.14.camel@galileo> <20081011032120.GB22499@anvil.corenet.prv> <1223822468.9733.1.camel@galileo> <1223822674.9733.5.camel@galileo> <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo> <1223827421.11389.5.camel@galileo> <1223891135.24954.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f18.google.com ([209.85.217.18]:41239 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYJ1DLs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2008 23:11:48 -0400
Received: by gxk11 with SMTP id 11so1029449gxk.13
        for <linux-input@vger.kernel.org>; Mon, 27 Oct 2008 20:11:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1223891135.24954.1.camel@johannes.berg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stelian Pop <stelian@popies.net>, linux-input@vger.kernel.org

On Mon, Oct 13, 2008 at 11:45:35AM +0200, Johannes Berg wrote:
> On Sun, 2008-10-12 at 18:03 +0200, Stelian Pop wrote:
> > The appletouch driver has grown up from supporting only a couple of
> > touchpads into supporting many touchpads, which can have different
> > number of sensors, different aspect ratios etc.
> > 
> > This patch cleans up the current driver code and makes it easy to
> > support the features of each different touchpad.
> > 
> > As a side effect, this patch also modifies the 'Y' multiplication factor
> > of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
> > Duo MacBook and MacBook Pro laptops) in order to make the touchpad
> > output match the aspect ratio of the touchpad (Y factor changed from 43
> > to 64).
> 
> Looks good, the only thing I can find to complain about is that you
> modify
> 
> 
> > +static struct atp_info geyser1_info = {
> > +	.xsensors	= 16,		/* will be set to 26 on 17" */
> 
> those static variables ;)
> 
> Considering these devices aren't available outside of apple laptops and
> those always come with exactly one, I don't think it's much of a
> problem.
> 

How about if we do this:

Input: appletouch - small fixup to Stelians patch

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/appletouch.c |   67 ++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 32 deletions(-)


diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index ea36f14..454b961 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -43,6 +43,7 @@
  */
 struct atp_info {
 	int xsensors;				/* number of X sensors */
+	int xsensors_17;			/* 17" models have more sensors */
 	int ysensors;				/* number of Y sensors */
 	int xfact;				/* X multiplication factor */
 	int yfact;				/* Y multiplication factor */
@@ -53,8 +54,9 @@ struct atp_info {
 static void atp_complete_geyser_1_2(struct urb *urb);
 static void atp_complete_geyser_3_4(struct urb *urb);
 
-static struct atp_info fountain_info = {
-	.xsensors	= 16,		/* will be set to 26 on 17" */
+static const struct atp_info fountain_info = {
+	.xsensors	= 16,
+	.xsensors_17	= 26,
 	.ysensors	= 16,
 	.xfact		= 64,
 	.yfact		= 43,
@@ -62,8 +64,9 @@ static struct atp_info fountain_info = {
 	.callback	= atp_complete_geyser_1_2,
 };
 
-static struct atp_info geyser1_info = {
-	.xsensors	= 16,		/* will be set to 26 on 17" */
+static const struct atp_info geyser1_info = {
+	.xsensors	= 16,
+	.xsensors_17	= 26,
 	.ysensors	= 16,
 	.xfact		= 64,
 	.yfact		= 43,
@@ -71,8 +74,9 @@ static struct atp_info geyser1_info = {
 	.callback	= atp_complete_geyser_1_2,
 };
 
-static struct atp_info geyser2_info = {
-	.xsensors	= 15,		/* will be set to 20 on 17" */
+static const struct atp_info geyser2_info = {
+	.xsensors	= 15,
+	.xsensors_17	= 20,
 	.ysensors	= 9,
 	.xfact		= 64,
 	.yfact		= 43,
@@ -80,7 +84,7 @@ static struct atp_info geyser2_info = {
 	.callback	= atp_complete_geyser_1_2,
 };
 
-static struct atp_info geyser3_info = {
+static const struct atp_info geyser3_info = {
 	.xsensors	= 20,
 	.ysensors	= 10,
 	.xfact		= 64,
@@ -89,7 +93,7 @@ static struct atp_info geyser3_info = {
 	.callback	= atp_complete_geyser_3_4,
 };
 
-static struct atp_info geyser4_info = {
+static const struct atp_info geyser4_info = {
 	.xsensors	= 20,
 	.ysensors	= 10,
 	.xfact		= 64,
@@ -194,7 +198,7 @@ struct atp {
 	struct urb		*urb;		/* usb request block */
 	u8			*data;		/* transferred data */
 	struct input_dev	*input;		/* input dev */
-	struct atp_info		*info;		/* touchpad model */
+	const struct atp_info	*info;		/* touchpad model */
 	bool			open;
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
@@ -421,6 +425,25 @@ static int atp_status_check(struct urb *urb)
 	return ATP_URB_STATUS_SUCCESS;
 }
 
+static void atp_detect_size(struct atp *dev)
+{
+	int i;
+
+	/* 17" Powerbooks have extra X sensors */
+	for (i = dev->info->xsensors; i < ATP_XSENSORS; i++) {
+		if (dev->xy_cur[i]) {
+
+			printk(KERN_INFO "appletouch: 17\" model detected.\n");
+
+			input_set_abs_params(dev->input, ABS_X, 0,
+					     (dev->info->xsensors_17 - 1) *
+							dev->info->xfact - 1,
+					     ATP_FUZZ, 0);
+			break;
+		}
+	}
+}
+
 /*
  * USB interrupt callback functions
  */
@@ -487,28 +510,8 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
 		/* Perform size detection, if not done already */
-		if (!dev->size_detect_done) {
-
-			/* 17" Powerbooks have extra X sensors */
-			for (i = dev->info->xsensors; i < ATP_XSENSORS; i++) {
-				if (!dev->xy_cur[i])
-					continue;
-
-				printk(KERN_INFO
-					"appletouch: 17\" model detected.\n");
-
-				if (dev->info == &geyser2_info)
-					dev->info->xsensors = 20;
-				else
-					dev->info->xsensors = 26;
-
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (dev->info->xsensors - 1) *
-						     dev->info->xfact - 1,
-						     ATP_FUZZ, 0);
-				break;
-			}
-
+		if (unlikely(!dev->size_detect_done)) {
+			atp_detect_size(dev);
 			dev->size_detect_done = 1;
 			goto exit;
 		}
@@ -756,7 +759,7 @@ static int atp_probe(struct usb_interface *iface,
 	struct usb_endpoint_descriptor *endpoint;
 	int int_in_endpointAddr = 0;
 	int i, error = -ENOMEM;
-	struct atp_info *info = (struct atp_info *)id->driver_info;
+	const struct atp_info *info = (const struct atp_info *)id->driver_info;
 
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
-- 
Dmitry
