Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554942;
	b=kznF6nBhZmKOXHdFTdhYlhXf9LYSgWMwr+EOvpwfBs/KZkW61pW3E2Cbr2ZxjYInpTg1
	 IWTQwfa/BP9EdAN5v6GvVDnDVtPj0rlDehyL+JF77hX2d486qMnTT6h/gS/dn0PL5ckj2
	 5Fjpt7qRGF12+l1xs1YzuVekiiz6qYajN9Xz0DL/kIGCnR2yAchNTUKa1JfvL58Z+s/OH
	 b+GM1mtRgnOioncjoZJin10zUklC8rx2L+u2k3eL9Cw0jvfegZMsrYjS1nzTVlvO5Xr+e
	 JWxY7LIgJU68myrnQ6h80IJ4S8YIS0tIer601cc1Z9BQnvhzdNMW4mI/9HXahc/INAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554942;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=7xt/gD5TCwtTFXCA+edachZME4xE9SJWWBJ8TXXqWYs=;
	b=bL3WC7FOynY8fqnPWEzo2yWKIFCCLjZ2Sek4UuNWxO6kZ7cS6p2ow6dr1RsZ8dfb8JJ0
	 AhfdyWUnYzJgGRkJ3CPfdFx3jAGu2T5IWLzgDJNOr9BbFAPbY68J3dGsiMu3YUA+sTcJ1
	 4IxfBnrirVslGFrqBiG8GBTZxnn7VyzKCazZg9VjmSXQ0pIKfViWJVb3Qem5hitR7MDyw
	 AtV2qi0vHyyR3LW3dT8UI2TViQRXUIJ+GJGQA0MnxSS2WjWKs7gPRTDgFcuekB2lfV9DY
	 7TPJzDiQ2wIp1fX5axfanmrHLzfgCqbpAJAfnadAaNkpR354HaGyI56BLniV91biunQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nPzSdx4B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FA606A325;
	Sun,  1 Nov 2026 17:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526FA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nPzSdx4B
ARC-Seal: i=1; a=rsa-sha256; t=1793554903; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fPJON0GRPh+l5uUYlxdlEwpsaFVvVZzIxnkR8bmw1IixQKw+dg07Za9SXJJf7E0ME8/AbZjUNQclMobm8ea6il2ERIrEALrMntucok9GZYm5sx/H6ibo+ZbTERp0swn0erjIz5F7CoDwfe7rKFRvBEJNApm6vD7E9hzICn/Ve0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554903; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7xt/gD5TCwtTFXCA+edachZME4xE9SJWWBJ8TXXqWYs=; 
	b=GlStIJfYkkYeOV/kM7KO+OSywSETC4NgfFXAxXIQ77dkv/kjnDppgRs32OlucjGbQDE8m4D86+GUJv7OjBiuPaXiSHYANM6lykpz/0pMhSjAVvs7n1LKFFHWg7HLJ5fw1V6Rc9Yr8sDCR4FctZOmU0YFmRZ7uRFTJ4DaTBbxs1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=nPzSdx4B7gzzX0vGxkVNM4R1R+FY+IOZvjXzxBnELD3rcMY1+bD/GijV6VmSUdVhUEYgT6Bsz3PqviEhHbiQwlJjtrBPbEblwNVDmE9Jk4T1SCfQMX7ratscGSVG2aWO44ESUMNotdRXvuMdFqTKxwtpZPdCw2/F36OseKtpaZ4KT5IR0pl5u18MSx/cG9sQMkV5ccLXEjSug4cgRRIh4pxM1Z5h5j7dTNdArdS0cdA6Q6R0RIdg6k8LTDjJ9BHcDE+PNwSukVk/QfksgFxdilNRV1VR/3iCKfIaBH0jN3kSvlbgAz5aexr4j72XY3bZfcn0hH9G9AOPe095P0D94g==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=7xt/gD5TCwtTFXCA+edachZME4xE9SJWWBJ8TXXqWYs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179355490083891.606617446614;
	Sun, 1 Nov 2026 09:41:40 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:22 +0800
Subject: [PATCH 5/9] HID: haptic: Postpone GET_REPORT to init
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
Message-Id: <20261102-hid-haptic-kmod-v1-5-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
In-Reply-To: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
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
index 27cc8a2d9b59..37b3eaf110ea 100644
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
@@ -467,6 +463,12 @@ int hid_haptic_init(struct hid_device *hdev,
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

