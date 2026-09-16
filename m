Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A733C536;
	Wed, 16 Sep 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570147; cv=none; b=H23giY/gsQDDZmbbUoPuVlzGG7xK4aHnoeYhPirAAVu/4E61UoFjPPe53L1EH9iORu5/ofwU/qqBXfjEl+pPfo2NE8ox1bl+PrXZgNW4iRL6nGyGTqhpa2qXZqXJnjlu05L/6q4Z/iy1e8x3iFDFZgBLiL+cDBdaY0EsQTH7014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570147; c=relaxed/simple;
	bh=nvw3/zhGpR3hGQW+vt86gKXA8bXj+407hCTTPeMoRLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFOpBY1E+QU3JFVqKg4k+w86K9R6Zv2zY6UF65lgInwb7yKa8RuY25UTcXPBMa8XTr1qyXd+ENoOTPGpR58LqEWPmnTRc9IS/3JkjjAQ/4vZl/C6Pq7KpNLw5uFIypvqoO1dBSxq1fkYcVk3dzVg2rq0UzDS10XKuCLOdAJgcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YplTZZOl; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YplTZZOl"
Received: from aerhardt-tuxedo.fritz.box (p57b95085.dip0.t-ipconnect.de [87.185.80.133])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id AA6B02FC0063;
	Wed, 16 Sep 2026 16:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789570135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzacM3xzZEWktYNhdpixk9e8bYCwMaW1G2lwVwIhq+w=;
	b=YplTZZOlOIJy1OWcors0WtO07ZsHv/3KZSNoDtDveuKbIR5QmWzH9fi1j9Et4GYyKc7kJX
	edB+1pAhjL2w5EaHPdPYrKNqGRR4x+nwpS5W6UycRhG4ITmVGRmCRQZ4hvRRHdPac7leIQ
	AqZBJZUOvgKXBUE+zl1CtLSIClQjQvs=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] HID: generic: add LampArray support via hid-lamparray helper
Date: Wed, 16 Sep 2026 16:48:32 +0200
Message-ID: <20260916144838.456239-3-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916144838.456239-1-aer@tuxedocomputers.com>
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
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
functional with a recent fix posted to the LKML.

Link:
https://lore.kernel.org/all/20260728115918.125349-2-aer@tuxedocomputers.com

Co-developed-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
---
 drivers/hid/Kconfig       |  1 +
 drivers/hid/hid-generic.c | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ef1bb0037f4a..7f9529fd6011 100644
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
index c2de916747de..fde772c5014b 100644
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

