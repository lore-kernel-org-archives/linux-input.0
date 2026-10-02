Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BAA2DCF67
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900986; cv=none; b=m8hOqhDghWvr8/WpPQyTzL9hR4D5A/oKg2e08QS95YPgLu9qJID1b30viMImjMa51EKTO6iG5p3r2wNaKsF5eyDp0N+TIlxACB95+7/DXOn8lU4D2XHLdnNNphXGfgLHzbV3pzo9Xl9N1qBkw+lMbKxpL35QK5WIXly7H5vNGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900986; c=relaxed/simple;
	bh=s/uJ/CZy0wj0+F0nnviskPVpB0kRf+2sMuERBR1TehM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laOHn0nAkSoS6I/T/+X3tbrdArvd/IfT4u0kl8rvwP5lUrGmQcQpULBiufSyjd3kmA/7spjA6+06S2SjwOEIWIbjz5UJXoroGeO3iZYwrKWPOGfi3UZ1P+lP481v4UgGUZBlsTelsZiR/ZaxfTyUuwTMrw16deB6dj5OUlQ2txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=tqNx5lI3; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="tqNx5lI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1790900979; bh=s/uJ/CZy0wj0+F0nnviskPVpB0kRf+2sMuERBR1TehM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqNx5lI3fFJy7wf2ZvrT2sYx9J96D1fHZWv/9K04cU7+npa2jD+Yx+co6/qC6s9CY
	 9mKbOncTcnHMJykPhqfCCAey5FFc4CiF+gg/TBf0w7iRbzmMWSlXxBkkPcIQTFufta
	 GLEEiMN88jO9KLdnE03ZJnaEKx0YBH/f6zc5Zd7cb8O8ARUZB9JsETKZPOEX5CMrZB
	 mGDgAybVuUNVKPSoFJj29+Eu3nky7y0wiST5TkMKCA/u7tyDYCtCZC5xlnvExZbIJb
	 QYxSrRnr38SnkiCy36SK//aCpdoKBywXuKEqyZ1Af7mfUvR+BLIluQge7PJL+ScSvS
	 duV6owafhrBJw==
Received: from microtis.vulpes.eutheria.net (71-212-64-84.tukw.qwest.net [71.212.64.84])
	by endrift.com (Postfix) with ESMTPSA id C8119132034;
	Thu, 01 Oct 2026 17:29:38 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v15 4/4] HID: nintendo: Patch NYXI Hyperion 3 descriptor
Date: Thu,  1 Oct 2026 17:29:26 -0700
Message-ID: <20261002002929.1578115-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002002929.1578115-1-vi@endrift.com>
References: <20261002002929.1578115-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HID report descriptor for the third-party NYXI Hyperion 3's right
Joy-Con erroneously reports it as using the report ID for the left Joy-Con.
Since it does actually send the report ID for the right Joy-Con, the HID
subsystem rejects it as unknown. Here we patch it to properly report as the
right Joy-Con report ID to ensure the HID subsystem passes it through
properly.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 533a2560bfb9..d114cc389aac 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -4500,6 +4500,21 @@ static int nintendo_hid_event(struct hid_device *hdev,
 		return joycon_event(hdev, report, raw_data, size);
 }
 
+static const __u8 *nintendo_hid_report_fixup(struct hid_device *hdev,
+			    __u8 *rdesc, unsigned int *rsize)
+{
+	if (hdev->vendor == USB_VENDOR_ID_NINTENDO &&
+		hdev->product == USB_DEVICE_ID_NINTENDO_NS2_JOYCONR &&
+		*rsize == 100 && rdesc[24] == NS2_REPORT_JCL)
+		/*
+		 * The NYXI Hyperion 3 right Joy-Con accidentally reports as the
+		 * left one. Since the HID subsystem rejects report IDs that
+		 * aren't listed in the descriptor, we need to patch it.
+		 */
+		rdesc[24] = NS2_REPORT_JCR;
+	return rdesc;
+}
+
 static int nintendo_hid_probe(struct hid_device *hdev,
 			    const struct hid_device_id *id)
 {
@@ -4528,6 +4543,7 @@ static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t message)
 static struct hid_driver nintendo_hid_driver = {
 	.name		= "nintendo",
 	.id_table	= nintendo_hid_devices,
+	.report_fixup	= nintendo_hid_report_fixup,
 	.probe		= nintendo_hid_probe,
 	.remove		= nintendo_hid_remove,
 	.raw_event	= nintendo_hid_event,
-- 
2.54.0

