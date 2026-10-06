Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831D37DABD
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267400; cv=none; b=C/z5r1VuMASKCwxs9/B1s+Cmhfjw9fv01lRus9ZXXZBLdxQ+vkRI8ddTNvSABffBgN1b8qU4JWVrMHH0bFWy6RCTHhUCuke9yyAOhAe6P5oGAxzfDiuHKNWUiKIRuDhNimf5e5HBZplGDzuLQlZ3+H/Zd9EBdIkp8M42AkwMy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267400; c=relaxed/simple;
	bh=z1NPBYv7MJh97G11WPdeUQQlciHA8rhTYn5/NbsAPtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZBlE1IEmV2ywM94IvWeYbBOZf1uY4lTMvyGfIi4bkYp1NeXJv9lzeCgdLZ1p1jbILKjDvNRW2Nl5qH01I5FPEpLIlY7YaTMekzg93l0bMRzxrJ3G8GZhr6n5jsg1CkzDgDJCjrpvcvmqs/5azdN3rg0ZAZfzjSm8facsm+/sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=zIrIPp2Q; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="zIrIPp2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1791267393; bh=z1NPBYv7MJh97G11WPdeUQQlciHA8rhTYn5/NbsAPtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zIrIPp2QOw1I/42TCjup4VAtdjr+udM9rlbE62BLeuTyO/5w36vV8JqPZRJ708J8n
	 vtKjKvsZUq4mMIbpYPXiRgFRlnyhUJxSG25YU9FHR/6Cix9Sr8ea/23AIWltY/RC0B
	 anmy2lDzkFqO7vlABDjGFgigv6Lg8QOB1NVW1CwCxBweh3G/Dim0bSAWga/Td9J8Xf
	 JNBY3XkFkHnB+J7muGi7htPUw+cRbtaJVGYDUA5LhV+2vYPdJJXETXbQoCL8J6t4pQ
	 ji8Ec1Pt7UqCULxjbeZBSkAy2pRhIu13EV832Qz5LFSFkQD2S2Emto49PiLmNbEuYO
	 oaYK5caBAwf2Q==
Received: from microtis.vulpes.eutheria.net (71-212-64-84.tukw.qwest.net [71.212.64.84])
	by endrift.com (Postfix) with ESMTPSA id 5A9DF132034;
	Mon, 05 Oct 2026 23:16:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v16 4/4] HID: nintendo: Patch NYXI Hyperion 3 descriptor
Date: Mon,  5 Oct 2026 23:16:10 -0700
Message-ID: <20261006061619.2005967-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006061619.2005967-1-vi@endrift.com>
References: <20261006061619.2005967-1-vi@endrift.com>
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
index dfbb54d04038..4d40f67f3e64 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -4503,6 +4503,21 @@ static int nintendo_hid_event(struct hid_device *hdev,
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
@@ -4531,6 +4546,7 @@ static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t message)
 static struct hid_driver nintendo_hid_driver = {
 	.name		= "nintendo",
 	.id_table	= nintendo_hid_devices,
+	.report_fixup	= nintendo_hid_report_fixup,
 	.probe		= nintendo_hid_probe,
 	.remove		= nintendo_hid_remove,
 	.raw_event	= nintendo_hid_event,
-- 
2.54.0

