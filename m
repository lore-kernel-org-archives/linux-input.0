From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 2/5] Fix is_vbus_present to return 1 or 0
Date: Tue,  4 Nov 2008 08:55:10 +0800
Message-ID: <12257601293369-git-send-email-jayakumar.lkml@gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbYKDAzf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:55:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:55:35 -0800 (PST)
In-Reply-To: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

the use of is_blah() suggests a 1 or 0 return. This assumption is made in
pxa25x_udc code such as:
	dev->vbus = is_vbus_present();
where dev->vbus is a bitfield. This fix allows pxa25x_udc_probe to correctly
detect vbus. Other changes were to make its use consistent in the rest of
the code.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/usb/gadget/pxa25x_udc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index da6e93c..2dbc0db 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -141,7 +141,11 @@ static int is_vbus_present(void)
 
 	if (mach->gpio_vbus) {
 		int value = gpio_get_value(mach->gpio_vbus);
-		return mach->gpio_vbus_inverted ? !value : value;
+
+		if (mach->gpio_vbus_inverted)
+			return !value;
+		else
+			return !!value;
 	}
 	if (mach->udc_is_connected)
 		return mach->udc_is_connected();
@@ -982,7 +986,7 @@ static int pxa25x_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 	struct pxa25x_udc	*udc;
 
 	udc = container_of(_gadget, struct pxa25x_udc, gadget);
-	udc->vbus = (is_active != 0);
+	udc->vbus = is_active;
 	DMSG("vbus %s\n", is_active ? "supplied" : "inactive");
 	pullup(udc);
 	return 0;
@@ -1399,12 +1403,8 @@ lubbock_vbus_irq(int irq, void *_dev)
 static irqreturn_t udc_vbus_irq(int irq, void *_dev)
 {
 	struct pxa25x_udc	*dev = _dev;
-	int			vbus = gpio_get_value(dev->mach->gpio_vbus);
 
-	if (dev->mach->gpio_vbus_inverted)
-		vbus = !vbus;
-
-	pxa25x_udc_vbus_session(&dev->gadget, vbus);
+	pxa25x_udc_vbus_session(&dev->gadget, is_vbus_present());
 	return IRQ_HANDLED;
 }
 
-- 
1.5.2.3

