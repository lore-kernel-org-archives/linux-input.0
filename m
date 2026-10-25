Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972395;
	b=RVoeFPszfHwQ5Ud3+J/wG/pKxpykJ+Vh1ToQ9RpxBpxvrK5xFn5lVl4MJrLTgd3SSB2i
	 AQdvGbbpoA8QsL1v4S6pnAXbyp3YNYrKt/skDoGUtDot4SxkJQZo9QeUb2+gAd0iB8fI7
	 DsKkzYrzFSgoQbGZHxi1299Kl802JBXZ5XKNeag4ZG/yMRUdxpQoTi0B9rkoj0/3uHt7m
	 3C6VbgZb+QEhVGAbPf3PvrPbcjBhCpmnSJA5ZQ35+DIvznhu1FeZRN8QLcf7wCwpFQpjk
	 6JlH2SILmYSjTNJAyfdrzJoEoG28/uHNdWxxV1CHea6khaJadV+rtSRCGvJ3eq9eKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972395;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r3ziTXHFHb4zHhIgsgB0v091oWQB+ztJTIBPrG7LfeU=;
	b=wJDZXHg1dJ0ll/DZoVtwF9ktIEKRYgBI8aHqhJwHmncu1KwP1IRGC3VBNy2pA4aqkBQS
	 5U8yaC4pvE6RvRSKavZOsxNn02X8wCxRJ2waJCFN2RgCXZdzENEz/qCBAjdpU2R6ahdhG
	 NRe3PI3uBrCxyJ8pjVhkYjMY0XTgynJss+taeQ8XXmeDaHUko1SUC7XdLNRplo+S041hd
	 ujdsB3dy3B3SLMgaaEJKSmYh3cqoWfCicWYg2y9gDUTDCittRAnSZ1zJStcNlj+YFrNjo
	 7eBistWSwppCDoaENaSV9YX3xhOAj3rjGDnTgyM7ZpxqzzaDTc8xRSTNfdtPHyxDV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GWzgtTOo;
	arc=none smtp.remote-ip=91.218.175.203
Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796260A3835
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 23:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E796260A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GWzgtTOo
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Wv9AAOSychIFLGZa0J3lTL/8oGDGVJ41VngzrnO5Etg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792972392; v=1; x=1793577192;
 b=GWzgtTOoqX2zq4shTAbVtC2OIbqiBSNePxgLcSZQvomWCJG5Rjs/jSGi+6IEscSpGE1Y3MSJ
 sE8j55xxTKXjTW9xQlHBlmD/ERB0CkDyI281kwxczZUcwGOGqkTa9MRnhanE0Vqgd1CdJpy8qj5
 ui2PfR6L2v9S/wPfCpE5Zy0U=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e2575209869a21e;
	Sun, 25 Oct 2026 23:53:12 +0000
X-Mizu-Trace-ID: 5e2575209869a21e
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v11 17/18] HID: asus: report the XG Mobile GPU vendor to asus-wmi
Date: Sun, 25 Oct 2026 23:52:30 +0000
Message-ID: <20261025235232.129945-18-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025235232.129945-1-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version query answers with the 4-part PCI ID of the GPU installed
in the station. Parse it, report its vendor part to asus-wmi as soon
as the station is identified and clear it when the station goes away,
so that enabling the eGPU through egpu_enable composes the right
activation value for NVIDIA, AMD and Intel stations alike.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index e444cad85b32..244d103fbd4c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -186,6 +186,7 @@ struct asus_xgm_info {
 	char part_number[ASUS_XGM_INFO_LEN];
 	char firmware_version[ASUS_XGM_INFO_LEN];
 	char generation[ASUS_XGM_INFO_LEN];
+	u8 gpu_id[4];
 };
 
 struct asus_touchpad_info {
@@ -6313,6 +6314,12 @@ static int asus_xgm_get_version(struct hid_device *hdev,
 	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
 			 buf, len, "VER");
 
+	/* the 4-part PCI ID of the GPU installed in the station: buf[3..10] */
+	if (len < 11)
+		return -ENODATA;
+
+	memcpy(info->gpu_id, buf + 3, sizeof(info->gpu_id));
+
 	return 0;
 }
 
@@ -6685,6 +6692,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
 			 info->firmware_version, info->generation);
 
+	asus_wmi_egpu_set_vendor(info->gpu_id[0]);
+
 	/*
 	 * The attribute group is not devm-managed: a creation failure is
 	 * fatal and unwound through asus_xgm_init_err, while on the unbind
@@ -6732,6 +6741,7 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
 	return 0;
 asus_xgm_init_err:
+	asus_wmi_egpu_set_vendor(0);
 	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
 	drvdata->xgm_info = NULL;
 	drvdata->xgm_led = NULL;
@@ -6951,8 +6961,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
-	if (drvdata->xgm_info)
+	if (drvdata->xgm_info) {
+		asus_wmi_egpu_set_vendor(0);
 		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	}
 
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
@@ -6972,8 +6984,10 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
-	if (drvdata->xgm_info)
+	if (drvdata->xgm_info) {
+		asus_wmi_egpu_set_vendor(0);
 		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	}
 
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
-- 
2.47.3

