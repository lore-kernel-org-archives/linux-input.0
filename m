Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7E23393C
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453181; cv=none; b=GYyTs1SBd7xqrYJU6ZUEs0NkdBkjr+FNYMyN0ktNX3FvVz6F0HrJJZMtMxzR7skQy5LliRpLfc5CvAI/Dm3b7caNTsQxvlBDpP1nQ/09oMkadoMwsWN4CYWSGneTFNm/4jYsFoBScVQe9Jt8TjoMwegeDuQaT6EpXVlZCJKaFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453181; c=relaxed/simple;
	bh=gMaTIh3EH2kAXVPee6nL4yyJ6hYe0FeuwOiO9iGbVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfBL20PrCobr9ssUM1l+Fd+q51ObUKjLJw7TAyiGY8IK2PsWP8nzKhcLtmEbHufKwouSUQl5sXmdxqVMIY5HAh/v1VGHJunARB9A5juAxF420a7OR5P7Sd48pg0ZJOMHvncGdSOp3rft061OhUWQH/8mLGLirIpyuF799yiJ/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vcw6zahr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vcw6zahr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786453177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcItOIrUgSEw4zXU2iIvOMP8wXXTsk0zzFvmSvrnETE=;
	b=vcw6zahrMOacvnROZk9n/mDwlr97QNXzDf7XgGleN4nhWOh2wy3r63YQM3a4MfcGGNmq8/
	ZArv/uB7OAXXzHdX659X+av9WkkttMu4fcS5Q/fXerTiyw+Xn1q+95xqKaDHpII4Ze94J+
	jPg+gPw9E9r750zquvImXx4agR2uQBg=
From: Denis Benato <denis.benato@linux.dev>
To: 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
	'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 2/2] Input: xpad - introduce a static table to ignore devices
Date: Tue, 11 Aug 2026 12:58:56 +0000
Message-ID: <20260811125856.1692045-3-denis.benato@linux.dev>
In-Reply-To: <20260811125856.1692045-1-denis.benato@linux.dev>
References: <20260811125856.1692045-1-denis.benato@linux.dev>
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

