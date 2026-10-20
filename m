Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.90.84.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489995;
	b=WkjX7bEVJWxp6PdpxkJmqCNTHs/fDDe3VsmcR5CE2rbKVkc+/slhZsdrV6wXUdtXPQO9
	 PrkOSErAwBwntmZAyHy25owh4KU+H+1Gj/l7Px26lVwQSsHQhA/WgAvh6LcCbUWZzBrl4
	 XffIiA0Lz9W5Zrbu/PV9mLmVzEAnS/eKGiv1RHX/rP5AFeMLDGINX4NJk2ev+UdmkhS/D
	 IUjqCHNHY2vJj89tbdpw5Qbf0XIuq0r2pPmWfna1esY5I69otoOKo5j86dvzrgJXnqJIr
	 CAT6Dh4Wuu5383Xg5gMmpr+pfkTpK645lTQRFSujHhHWCNvTOhpgDVlZWlw8oWd3mpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489995;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=hjiDGPYB2K+D7Y1vJcaKbb6AEjbcs6XdQq2usn0rk9w=;
	b=mWyuelkkvc4l9dwYTs6lsyce6/cSt4BS8BaXpj6sClwyIN9fc00vxL2I6kQz3NTNP5hK
	 KZOXlLcrNLjsA5EHsqUDWtWcZbQ+KCWQFihnvEpllMzLzpkS4Tm1881HwD19XIuGbUEQJ
	 jOmf0ozLxLGkzD1S8ANWlSUBFhyu2PcSV/7gUkQdPpTrIOM4fJAsHL/njKY9gt/oSlecy
	 fWSNu5BMHRc0XBgz3evhAd9KOi7SLK4jODbfxcxaaCGWiMUESMJ4whwBbD8F4HSZNkhAQ
	 zEL9nQEgZ3X4F+RlxZXNVta/2JCH65mt8KDIBlODuxhEHnD+m6jI1bz9xJVefGUwJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuxedocomputers.com;
	spf=pass smtp.mailfrom=tuxedocomputers.com;
	dkim=pass header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=VxYlYkF7;
	arc=none smtp.remote-ip=157.90.84.7
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CC606A31A;
	Tue, 20 Oct 2026 09:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.a=rsa-sha256 header.s=default header.b=VxYlYkF7
Received: from [127.0.1.1] (business-024-134-105-141.24.134.pools.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 600812FC0065;
	Tue, 20 Oct 2026 11:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1792489986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjiDGPYB2K+D7Y1vJcaKbb6AEjbcs6XdQq2usn0rk9w=;
	b=VxYlYkF7LjAmxOJb9c3rmdg0kgNg52FYHlsIai9zEbdvFEFZ3W71/xhl2HOqM9aA1omlBa
	5zAsbxtBg7+1GUyOzF+YnmzsuyWd7ckPb/WIu7oPk5yW7oD7DbGZ4gaKKHzklA/k4CAyuL
	3fmL6NvCbLKuqpJ9+S/u8UCAIf85gMk=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
Date: Tue, 20 Oct 2026 11:51:48 +0200
Subject: [PATCH v7 2/3] HID: generic: add LampArray support via
 hid-lamparray helper
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-hid-lamparray-v7-2-47418b667b47@tuxedocomputers.com>
References: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
In-Reply-To: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Cristian Mazzotta <cmmazzo@icloud.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, Armin Wolf <W_Armin@gmx.de>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Tim Guttzeit <tgu@tuxedocomputers.com>, 
 Aaron Erhardt <aer@tuxedocomputers.com>
X-Mailer: b4 0.15.2

The hid-generic driver now checks for LampArray support after
hid_parse() and optionally registers a lamparray instance. Failures in
the helper do not abort device probe to keep the device unchanged.

LampArray resources are released on driver remove.

This patch was successfully tested on the Microsoft MacroPad reference
implementation (https://github.com/microsoft/RP2040MacropadHidSample
1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit only
functional with a recent fix posted to the LKML.

Link:
https://lore.kernel.org/all/20260728115918.125349-2-aer@tuxedocomputers.com

Co-developed-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
---
 drivers/hid/Kconfig       |  1 +
 drivers/hid/hid-generic.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 934e502ba5058..919d495090d97 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -82,6 +82,7 @@ config UHID
 
 config HID_GENERIC
 	tristate "Generic HID driver"
+	depends on HID_LAMPARRAY if HID_LAMPARRAY
 	default HID
 	help
 	Support for generic devices on the HID bus. This includes most
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c2de916747dec..fde772c5014bb 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -20,6 +20,7 @@
 #include <asm/byteorder.h>
 
 #include <linux/hid.h>
+#include <linux/hid-lamparray.h>
 
 static struct hid_driver hid_generic;
 
@@ -60,6 +61,7 @@ static int hid_generic_probe(struct hid_device *hdev,
 			     const struct hid_device_id *id)
 {
 	int ret;
+	struct lamparray *la;
 
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
@@ -67,6 +69,34 @@ static int hid_generic_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
+	/*
+	 * Optional: attach LampArray support if present.
+	 * Never fail probe on LampArray errors; keep device functional.
+	 */
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && lamparray_is_supported_device(hdev)) {
+		/*
+		 * Use HID_CONNECT_DRIVER to make sure requests are
+		 * processed in hid_report_raw_event. Without this,
+		 * hid-core will skip parsing for devices that are only
+		 * claimed by hidraw, thus making it impossible to query
+		 * the required information.
+		 * See 7704ac937345 for more information about this flag
+		 * and why it is necessary.
+		 */
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER);
+		if (ret)
+			return ret;
+
+		la = lamparray_register(hdev, NULL);
+		if (IS_ERR(la)) {
+			hid_hw_stop(hdev);
+			hid_warn(hdev, "LampArray init failed: %ld\n", PTR_ERR(la));
+		} else {
+			hid_set_drvdata(hdev, la);
+			return 0;
+		}
+	}
+
 	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 }
 
@@ -78,6 +108,16 @@ static int hid_generic_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static void hid_generic_remove(struct hid_device *hdev)
+{
+	struct lamparray *la = hid_get_drvdata(hdev);
+
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
+		lamparray_unregister(la);
+
+	hid_hw_stop(hdev);
+}
+
 static const struct hid_device_id hid_table[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
 	{ }
@@ -90,6 +130,7 @@ static struct hid_driver hid_generic = {
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
 	.reset_resume = hid_generic_reset_resume,
+	.remove = hid_generic_remove,
 };
 module_hid_driver(hid_generic);
 

-- 
2.43.0

