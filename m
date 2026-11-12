Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506111;
	b=qoTADAFbp3cr0Eegh4XrEllWxZ3UiZgss+OBp0SAt46Fq4l+5chncoA3Dvb8p5GYUrDl
	 /k2+G2eurVqw8tOCOu5CYsPwDhV7AFoQXzQoFJIJJo6w/g/IJIGyrWp5v7CJKHRaGlkM0
	 H/9vYHnCKshsdfYdD2rwi1ookMMPhWYioF3jvcmr/4Crk44XJu97iXKE4UV+eIPm4feoc
	 WBol48ZbqXwon8glzLHSojNzF16jSnhl6e+Lz33E1yrmZoibQ8uCipc/3n7Cfrss1Doin
	 LtE+hKvOdnnBS9NFbvgoYtfaReYeBrkNTBECUnjtkMk2ut0dubCihMjiD+GXZ9dT9tQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506111;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=;
	b=O2Z5ziLwiCBg55rxc3JFd5mD2gOFDVJiQax2owHWNbu32eQmPt5ALetIa7aLVEJ2puS+
	 m8V8/TNaGuvbb+XpK1RFY19tDjosIlPG6qrySMZo0doy5R3k5sdwxPFXHPTCX64S1/m4M
	 W63BonyvAlioIQksxyMmamArpfGiJ5By9rFGg9wIVW3CmZJCgTtgMSl1iBGGePRiiXhWN
	 9tLWEEbXDe6Hq2nhx46E33aX72iD798ZO302Fnsb56JQLcH4Kz0UhdT4e/+6Iw33ylG7L
	 FrgF2ifZ0Y87MlmC6YKv/bETNqlnQaNlDjPmUlS2HWtDO1KPu9IifA8RSJcbCATBqow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=lRmy7MbW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF7606A321;
	Thu, 12 Nov 2026 17:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8FF7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=lRmy7MbW
ARC-Seal: i=1; a=rsa-sha256; t=1794506067; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NSL0V8M4SLC60EjM9i0xpEoz6c46eWq+edLaYVsF3yFB/29BPQn/9vhUqCVT3FgNHLvPuk4CLhvvx8Ff4n6vArCp/oyc081YMCmxgeQ6xtkXMCRiMmYGSCfq/m65Spze2ZBCeZu6vRwGTVkjXsoem01OomKYto8k83km9q8cM78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506067; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=; 
	b=Iakjf2KwBhpEfA9VkUgZU7eAVlDneddbcaS/ergxo6p1A5J0wrL63hHnE8DXENu/gQYMhP2M8kG3iIQen3+0eXkOwQsZb3W4GEt6uQSbFHZDS3bBlXpKm8/B5Lp7u+9lxYczKCTpRoLQPYNSWwFJKwwL/Q3+/xp1ON2bSFa7H74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=lRmy7MbWWlZXvsLfIVfM9B2bKwtAqqI9z7hXZ4hnuLIwjQ4+UBybJ3WLi5xzM5mnptiScgtRtBh39Iji6vQh4vArqZB1KHkP/QKpn/db6D+JymUpFs4QdqcAI8JfZRQWu4YU/dsXxahG/Ofm1j5bLNNSE4+Qibzq7fG5CzTMDxh9fEp9fCrWoFyEZig0lNBnm+OXjgVh+el6YVtAudFWtndQezSt5fbMawjVkIcghujqXT5ntYywijJNIvCr6sFsPwfGkD8jwY69hwLo2AlHHpCX4C7mICgAh5nGiDjjAaHEMaGhJIfALgo1rao9QxZiV+A6cogp5Fx0t4T2AjerbQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=m9as34f0vVxOEWiM1bJ9qgJkaYm42EhPwgrInagCDH4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506065042949.1133142812151;
	Thu, 12 Nov 2026 09:54:25 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:53:58 +0800
Subject: [PATCH v3 5/9] HID: haptic: Postpone GET_REPORT to init
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
Message-Id: <20261113-hid-haptic-kmod-v3-5-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
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

