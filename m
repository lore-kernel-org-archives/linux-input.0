Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3863224B05
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178376; cv=none; b=gHTGfbSEjCPoCrht34RGpzSzQXGtHn4QAkuywpxKk8P+jCKdyV+SuZq2UqoKdcQuqb2O6im+WvtVb+YfbzLej9B6ptOtqK3XUv0lqevE8/gVJcOdwhCsNTOq8O/J35M0lW4HyzU1iRXjBmWu8IFZHfoViQup0ImVfKBvXCNdEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178376; c=relaxed/simple;
	bh=s70WjWUOYhj/JuHH6aUF78zObHqSFRFlD2Dv57grYF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6jorhwNgmJr6dquQeqdyTf976M0KWwrLj6mmK42HgGHAjy5XlHl0o2AsQ1vzMxMvLlmla6sgjxTDdjmvzW5/sBnCkhJL6O0rhTvteyx2cjeWMrvm9dJsnK0Yy+cMZicx0hdWuJjbbR5JmWbwGoSy0rN22Zzw1UUW/iF/Zdv8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TXHJSuBx; arc=none smtp.client-ip=91.218.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TXHJSuBx"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s70WjWUOYhj/JuHH6aUF78zObHqSFRFlD2Dv57grYF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789178371; v=1; x=1789783171;
 b=TXHJSuBxnSHQYgD3k9BKzc9tpczyc3lZmBRCz/uPbMbcRXg+Py42SnpTNTKbeWv83BTFoDvc
 2zywOTqOPwH1CltyI/CBNYOjn1ielPVGRT2XsY3J/IZ/hWBI4PhbHiqCM+W6beDuHOoX4RCwAoo
 Zcfd4CLBHuRn9cFtvprqwhZU=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87fb88622ac49665;
	Sat, 12 Sep 2026 01:59:31 +0000
X-Mizu-Trace-ID: 87fb88622ac49665
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v4 2/2] Input: xpad - introduce a static table to ignore devices
Date: Sat, 12 Sep 2026 01:59:26 +0000
Message-ID: <20260912015926.230874-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912015926.230874-1-denis.benato@linux.dev>
References: <20260912015926.230874-1-denis.benato@linux.dev>
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

