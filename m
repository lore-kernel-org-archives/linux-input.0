Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446A3C13F9
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492479; cv=none; b=Njj2yBwisB/Goy0SD5hugS3Ksly4Gr6A7xpK0oXjgldxb8sbakc0S4gF4xowLz9c79zAdUx0l08oKPbJuhzKFuekKknsD15Q+Y4VanHBkWQf+Te9ToZCz6fa2I1iXBqVzXm7R9UDC3/vesgUEiOm91TbZbTveI3chbpmJjIK+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492479; c=relaxed/simple;
	bh=s70WjWUOYhj/JuHH6aUF78zObHqSFRFlD2Dv57grYF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIuZ2XS5Kp3mzcT2uuPdJl8ONov90SXzbPg6cAUNIOZwYgsr5QslEulQkKIR7QN2+NqsjeXfZE/zcmtFaVUllBKkLsQd7GIxmjrKtj54p2MSu6hjbYOayckyTkuA7VnWNu3pxAEhfMcU/JzDnnXmR7lNVXIOiCyHayyxjIQ9Hn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTJ48XIr; arc=none smtp.client-ip=91.218.175.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTJ48XIr"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s70WjWUOYhj/JuHH6aUF78zObHqSFRFlD2Dv57grYF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789492474; v=1; x=1790097274;
 b=uTJ48XIrWnD5PfEPHfx7WTYmbdlIE8e/Qx0fm7fP15ykhFr/nseyKEouD1mei0mVhiKbFOMW
 X1GQ0wPNK/qV8O5zgaGKwA0rwtlFIosQAm0d3Wyv6lEhJoT9VrjsI3f45LogIPLEMp0HPtgi2Vk
 XdXmr0KxEvPON3Tp/0u1gVy4=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7fb5bdb11ea3277;
	Tue, 15 Sep 2026 17:14:33 +0000
X-Mizu-Trace-ID: e7fb5bdb11ea3277
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v5 2/2] Input: xpad - introduce a static table to ignore devices
Date: Tue, 15 Sep 2026 17:14:25 +0000
Message-ID: <20260915171425.11058-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915171425.11058-1-denis.benato@linux.dev>
References: <20260915171425.11058-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 2da0b7f1722a..bd24beacc788 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -407,6 +407,18 @@ static const struct xpad_device {
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
@@ -2046,11 +2058,23 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
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

