From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 1/3] ati_remote2: Complete suspend support
Date: Tue, 20 Jan 2009 21:00:33 +0200
Message-ID: <1232478035-20172-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.welho.com ([213.243.153.38]:51945 "EHLO smtp4.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593AbZATTTx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2009 14:19:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Ville Syrjala <syrjala@sci.fi>

Add the missing reset_resume, pre_reset and post_reset hooks.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/input/misc/ati_remote2.c |   78 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 3c9988d..351eb90 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -139,6 +139,9 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 static void ati_remote2_disconnect(struct usb_interface *interface);
 static int ati_remote2_suspend(struct usb_interface *interface, pm_message_t message);
 static int ati_remote2_resume(struct usb_interface *interface);
+static int ati_remote2_reset_resume(struct usb_interface *interface);
+static int ati_remote2_pre_reset(struct usb_interface *interface);
+static int ati_remote2_post_reset(struct usb_interface *interface);
 
 static struct usb_driver ati_remote2_driver = {
 	.name       = "ati_remote2",
@@ -147,6 +150,9 @@ static struct usb_driver ati_remote2_driver = {
 	.id_table   = ati_remote2_id_table,
 	.suspend    = ati_remote2_suspend,
 	.resume     = ati_remote2_resume,
+	.reset_resume = ati_remote2_reset_resume,
+	.pre_reset  = ati_remote2_pre_reset,
+	.post_reset = ati_remote2_post_reset,
 	.supports_autosuspend = 1,
 };
 
@@ -715,6 +721,78 @@ static int ati_remote2_resume(struct usb_interface *interface)
 	return r;
 }
 
+static int ati_remote2_reset_resume(struct usb_interface *interface)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt = interface->cur_altsetting;
+	int r = 0;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 = usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __func__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	r = ati_remote2_setup(ar2);
+	if (r)
+		goto out;
+
+	if (ar2->flags & ATI_REMOTE2_OPENED)
+		r = ati_remote2_submit_urbs(ar2);
+
+	if (!r)
+		ar2->flags &= ~ATI_REMOTE2_SUSPENDED;
+
+ out:
+	mutex_unlock(&ati_remote2_mutex);
+
+	return r;
+}
+
+static int ati_remote2_pre_reset(struct usb_interface *interface)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt = interface->cur_altsetting;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 = usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __func__);
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (ar2->flags == ATI_REMOTE2_OPENED)
+		ati_remote2_kill_urbs(ar2);
+
+	return 0;
+}
+
+static int ati_remote2_post_reset(struct usb_interface *interface)
+{
+	struct ati_remote2 *ar2;
+	struct usb_host_interface *alt = interface->cur_altsetting;
+	int r = 0;
+
+	if (alt->desc.bInterfaceNumber)
+		return 0;
+
+	ar2 = usb_get_intfdata(interface);
+
+	dev_dbg(&ar2->intf[0]->dev, "%s()\n", __func__);
+
+	if (ar2->flags == ATI_REMOTE2_OPENED)
+		r = ati_remote2_submit_urbs(ar2);
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	return r;
+}
+
 static int __init ati_remote2_init(void)
 {
 	int r;
-- 
1.6.0.6

