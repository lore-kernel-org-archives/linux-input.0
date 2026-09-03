Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02E417BE9;
	Thu,  3 Sep 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420977; cv=none; b=AtfTxtGb0GbmXnPRoVILehiL7M2Rxq8YBJTf8CheGToaKd78f+P8LHCPY4R39sJLuIRRCl2fsdE/Gh5ZeQWCuO7BucjSXTHp0aOoV46HpY/ZAbClYGDghuElkwUuKqW/YV0dtXk9GpOSy0hLZ+zfEl6cKaGcESV+oHQi5Ys9J88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420977; c=relaxed/simple;
	bh=k9eJRVPSwolXIR5iw0zAP6Wg4C9aeomjOKXLy0hOhDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPKjL+pbhAZL+tsfxw0Ta3SGXNKUDdptwO6TuFF3FQIv3eMc3l9Sb/Byhl2/jyFYl3YYaN5inOsjnkvTZuRQNzeoR4S+g8F75ipeck0NaijwNAXx5Ly5vHYzHF8h8UJkEWo+0Mu2yjurSlq60Bp8uUcQqPl0OAHWpVbSLbw4Hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=VT/SkiOY; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="VT/SkiOY"
Received: from aerhardt-tuxedo.. (dynamic-176-002-009-249.176.2.pool.telefonica.de [176.2.9.249])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 57C1C2FC007A;
	Thu,  3 Sep 2026 09:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1788420966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQsmG4IdoGEF5hVGsKw5SdIW9hTdZUoVxnynnHirTwM=;
	b=VT/SkiOYAUgoSdpdiCzOy1vb2m0kqZ2vMF2vgmQiygXy5ccHsLTGBWYR/7YURJ97SdPf3S
	R7ufumMgsKB0oPFjfEL+NWEJ1g4Po30gWdeNio1gEPNJvKxW0fSZAZJjaKDSJikIp3wT9J
	UpAHpdpi2U9TXC4bj3E6vXZvjhZlh9s=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	wse@tuxedocomputers.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] HID: generic: add LampArray support via hid-lamparray helper
Date: Thu,  3 Sep 2026 09:35:46 +0200
Message-ID: <20260903073602.3815258-3-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903073602.3815258-1-aer@tuxedocomputers.com>
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hid-generic driver now checks for LampArray support after
hid_parse() and optionally registers a lamparray instance. Failures in
the helper do not abort device probe to keep the device unchanged.

LampArray resources are released on driver remove.

This patch was successfully tested on the Microsoft MacroPad reference
implementation (https://github.com/microsoft/RP2040MacropadHidSample
1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit only
functional with a recent fix posted to the LKML
(https://lore.kernel.org/all/20260728115918.125349-2-aer@tuxedocomputers.com).

Co-developed-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
---
 drivers/hid/Kconfig       |  1 +
 drivers/hid/hid-generic.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4afd80a67b39..a0fcd89c2bb0 100644
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
index c2de916747de..c3d2283198e8 100644
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
 
@@ -67,6 +69,31 @@ static int hid_generic_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
+	/*
+	 * Optional: attach LampArray support if present.
+	 * Never fail probe on LampArray errors; keep device functional.
+	 */
+	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && lamparray_is_supported_device(hdev)) {
+		/*
+		 * Use HID_CONNECT_DRIVER to claim driver to make sure
+		 * requests are processed. Needed for performing
+		 * hid_hw_request()/hid_hw_wait() to communicate with the
+		 * LampArray device.
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
 
@@ -78,6 +105,16 @@ static int hid_generic_reset_resume(struct hid_device *hdev)
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
@@ -90,6 +127,7 @@ static struct hid_driver hid_generic = {
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
 	.reset_resume = hid_generic_reset_resume,
+	.remove = hid_generic_remove,
 };
 module_hid_driver(hid_generic);
 
-- 
2.43.0

