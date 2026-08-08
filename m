Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9A2BE63F
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191898; cv=none; b=rTtRD8SlXshQ3BOjH1gK7WgIqq0f9riASq4CZCISk1jWptJCyCvvDORSoaKLbqWkZ7cByZbOf9Jb71m+H/Up6yO71OxQQbG9H5coUcZgyQQPlg28cbRQrhf+vnzd+v1id06TIbFISVKfbVGPOjjqPCxLrRLLSCzil5GLbLvBkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191898; c=relaxed/simple;
	bh=gMaTIh3EH2kAXVPee6nL4yyJ6hYe0FeuwOiO9iGbVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0cOaeuxfPPC3VbkomHXn1N9s9ZSiXDfOBIu6/JVzGRe06Q0nqztRfSmhKwz/neojLONDs+sGfjrgfj48YBQZ0rZ8Fhp0RYJ03D28wxhGfMi9QX9NTH7OARFBK333GErv+AE0pPALFEPXZW5+JhbQPM8NM4vB/TC6nrihviiEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gfJzVF0l; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gfJzVF0l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786191886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcItOIrUgSEw4zXU2iIvOMP8wXXTsk0zzFvmSvrnETE=;
	b=gfJzVF0lUYSE44Ay6VQTL5aUZ4ibxuCFxx3iMtn5s5oY4LFUCVkNHduY/N/5S9ZESsUfcR
	HdGzsQhN1jJnSyxzUvUmm3K7L94TFBMuLxXJL54Q7pNXvcSVBmHu3LJtn1ZLkUsHhxt8jT
	lwjJGCeGLi8+IUYMlhV2Z3Lt56urHa8=
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokho v' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 2/2] Input: xpad - introduce a static table to ignore devices
Date: Sat,  8 Aug 2026 12:24:39 +0000
Message-ID: <20260808122439.69159-3-denis.benato@linux.dev>
In-Reply-To: <20260808122439.69159-1-denis.benato@linux.dev>
References: <20260808122439.69159-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Certain devices can work both as HID and as an xpad device: binding both
would duplicate inputs causing userspace to receive double inputs; at the
same time if a HID device is available it is to be preferred as it can
support additional features such as integrated IMU and additional buttons
and more, depending on the specific driver, therefore allow only the
best driver available to bind the device.

Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..545119a4fb36 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -406,6 +406,18 @@ static const struct xpad_device {
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
 };
 
+#define XPAD_SUBSTITUTE(_vid, _pid, _enabled) \
+	{ .vid = (_vid), .pid = (_pid), .enabled = (_enabled) }
+
+static const struct xpad_excluded_device {
+	u16 vid;
+	u16 pid;
+	bool enabled;
+} xpad_excluded_devices[] = {
+	XPAD_SUBSTITUTE(0x37d7, 0x2401, IS_ENABLED(CONFIG_HID_FLYDIGI)),
+	{ }
+};
+
 /* buttons shared with xbox and xbox360 */
 static const signed short xpad_common_btn[] = {
 	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
@@ -2044,11 +2056,23 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
+	const struct xpad_excluded_device *excluded;
 	int i, error;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
 		return -ENODEV;
 
+	for (excluded = xpad_excluded_devices;
+	     excluded->vid || excluded->pid;
+	     excluded++) {
+		if (!excluded->enabled)
+			continue;
+
+		if (le16_to_cpu(udev->descriptor.idVendor) == excluded->vid &&
+		    le16_to_cpu(udev->descriptor.idProduct) == excluded->pid)
+			return -ENODEV;
+	}
+
 	for (i = 0; xpad_device[i].idVendor; i++) {
 		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
 		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
-- 
2.47.3

