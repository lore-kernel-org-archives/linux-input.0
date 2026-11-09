Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253851;
	b=1K4UMXfjiwntYlScuQ+IUEHxMuqLnTZqVJSdYtfpX1OM1w984/b6iBv45AR6O55DLy5a
	 KNHsVEErKfV8b7aoo4cr6v5GeN0J0jc/mKTPpxKl1A9xXG1vAum5aLFG28dcmyZUFxCAk
	 y5IuK7zMiYPEZmWlFe6xJYzQUiewnAJtYHUHMcsIEAFrVFv/uuuMUy6PZbRS3j7yuCEmr
	 yiHwHvqzQVK45f9x4VqH7fjB5pOfpbI1S9a8YQ6/99W3ycd8SMEGlJEATlRfwjGQa0wtn
	 KG4P7/+FATlLtc/2vgWkSkKbI4Mz6DIoNUYfcWk8UZ2+3Pw7TzPCi8PCqzuDPQPiZEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253851;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=;
	b=UlSu8pK54jE9rYigCiWq37XmLWbbBaKhGYxui9aBqWmcQndE66XkcIYlrDgbyxvWdkqD
	 amFbCGBJiZETjj4Fe25ZIpPFCUe0DeCsIZdWl3BbDj9vgo03E4K4qefBL7hWKwNgG5E+G
	 s/JOeCThq9NaBQf71fzPvd279yshF/0VOQWkGtCTgJLL6Y9oAfJfCrLa9hz5Uzcjwaa/o
	 vdXYW71VTNN4NGYWk4LfW0b9Iu+1BgsQstSoSwVb45I2IGwEPQfJTgwOTSPYkTrdflpxK
	 16bCNJgo3ZGUmqkkg5hOmWdezhkoPg4/LDNTvGkTWIViT3aNcA4CTRjEWQ7twjVMOnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pdIY5V2m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE05606A334;
	Mon,  9 Nov 2026 19:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE05606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pdIY5V2m
ARC-Seal: i=1; a=rsa-sha256; t=1794253812; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bg37ByVoJ/vPLpQL5rfKN1sMx4sA0FRpnRL2uuftUd+NEvW4LghodZksRe++OqDTg8UntT868GW48cQRL27DFp6azXUmBjLAPu81MU/ZGw6BoqLeBOBnn9S94gImaJcG9HvRnpwqED0/8qcKeOOlvdlrPcA+PS/SdoVxQ0xS9dc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253812; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=; 
	b=VAmF56X9zy+b2NyTxPe9mmaagNGAVzczdXZGUEyQ3GnV3wkzc/5yrqBFIyG9dnoWzyDsYhEPCYfcrEcFxr4XhQJDK3hwbFH6k9VOKBCX08Cv5tRnqGjKYsWjOaDVkHAnuXIxxmYeyVhzo9RrUs2DF5BuVAaiEv9NgQPHqx45J7E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=pdIY5V2mioxWUNwkyf4M30AhtxzZBk55y6MG4ukH8FUsAluSEYnc8/NdqWOcB9f5+A3qthiw0nako3/N3wyu3qzNwOiloelCdFzJnqIBF6ExKQZViluuPUMSkOT9jg9klXmEziwj6lu+TP6DlJQJey8WR7yLkS+xsitNBogWiEP7Za33xQLumbQ95M1mT9QJEFSVmLL/dyOrOyjhlR/S+1pfNNzpsp7Vx1qe5rj4mdeG8G3oezmRb0kYVJbUUHqIcDV3aFnV92/M0syvl92a/Q4pex+dRbXgp26GEBKYCIf1qLpBsUUBrWrEdLxmtRx4fd4FIEF2cSrGD244cfVkZg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17942538102661006.4620156655059;
	Mon, 9 Nov 2026 11:50:10 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:42 +0800
Subject: [PATCH v2 5/9] HID: haptic: Postpone GET_REPORT to init
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
Message-Id: <20261110-hid-haptic-kmod-v2-5-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Currently, the driver calls GET_REPORT within the feature_mapping
callback. This is not optimal, as the driver works only if manual
trigger is also available and the if the device is a touchpad. It makes
no sense to initiate device IO if the device is not supported by the
driver.

Hence, postpone GET_REPORT to hid_haptic_init(), and parse default
trigger in parse_auto_trigger_field() where many fields are already
parsed there.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 84985ad61d45..9f2af082d2ea 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -22,13 +22,6 @@ void hid_haptic_feature_mapping(struct hid_device *hdev,
 				"HID_HP_AUTOTRIGGER out of range\n");
 			return;
 		}
-
-		hid_device_io_start(hdev);
-		hid_hw_request(hdev, field->report, HID_REQ_GET_REPORT);
-		hid_hw_wait(hdev);
-		hid_device_io_stop(hdev);
-		haptic->default_auto_trigger =
-			field->value[usage->usage_index];
 		haptic->auto_trigger_report = field->report;
 	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ORDINAL) {
 		usage_hid = usage->hid & HID_USAGE;
@@ -146,6 +139,9 @@ static void parse_auto_trigger_field(struct hid_haptic_device *haptic,
 			break;
 		case HID_UP_HAPTIC:
 			switch (field->usage[n].hid) {
+			case HID_HP_AUTOTRIGGER:
+				haptic->default_auto_trigger = field->value[n];
+				break;
 			case HID_HP_WAVEFORMVENDORID:
 				haptic->vendor_id = field->value[n];
 				break;
@@ -465,6 +461,12 @@ int hid_haptic_init(struct hid_device *hdev,
 		HID_HP_WAVEFORMSTOP & HID_USAGE;
 
 	mutex_init(&haptic->auto_trigger_mutex);
+
+	hid_device_io_start(hdev);
+	hid_hw_request(hdev, haptic->auto_trigger_report, HID_REQ_GET_REPORT);
+	hid_hw_wait(hdev);
+	hid_device_io_stop(hdev);
+
 	for (r = 0; r < haptic->auto_trigger_report->maxfield; r++)
 		parse_auto_trigger_field(haptic, haptic->auto_trigger_report->field[r]);
 

-- 
2.55.0

