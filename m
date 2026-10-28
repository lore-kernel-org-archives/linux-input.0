Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218126;
	b=PPSd2xBO7yEsxOMp4Cw1FEjKOhzaHJJRnWClvSN527pC1eywMDQOenm1Ox6cJ03AnAbh
	 DjZEaffVFs5gBemOPSD4PFzXG1mezKhKEOzI4iG4HZEqI2hdKXRsxjiwM3Bb8LLXVnRz8
	 7rq7tceh57qx4UPdY55Jg3JjAHE0PcX2yj/pta+lgCLXyA/TRETPqrvSeolO1EDLVtJrw
	 L2STp3Vw/UP9KZr+MIAAJH2WEi5PxPvTG0e+Y9MrIJSjSfcteUWkrJntsc6NN1Lz0eNgp
	 Dj5oC0r6N5auUZRKLSGRd+e0spBNYie0DVA4rTznvnoMhm+KRznDTgu8Y6P7n0k9bpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ootfTXrKHKwvE1mze1ealqjStl64BOQ9AFDTh8t9yhQ=;
	b=tcwADOhjEux68NmmcC6BmkRKdDVGE0gUe/M45k4iJJzzT7yNeMu1S20sIakyo3aUhi4x
	 bz7Vk/G9PSFHDcpMR5kQUr2Ywiaun0e0JuuIwi0nae0k3VjkZr2Fkg9C3PA/NoW72s/EZ
	 IfRYK8d+3MVQmu2rIvzYfROzu1//dKKljAJPdFIgyR2+Ma1i8YbE9+Wrzx4dcoVzGmV8E
	 8qtKpYZgSxIFw6B/ve7etrlNMPTsR1wK4ojJsCr/0FRomdoQ7+t5FQmHKQGH54Zrm7yo6
	 WXebJ9+CwR4r4pBiUoVfuWhSbmHUJwQps8DkzlaiR+nb6nuflRmj2Ikg/70aHn2Jd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aww8henu;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13911606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 20:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13911606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aww8henu
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso12496345e9.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218124; x=1793822924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ootfTXrKHKwvE1mze1ealqjStl64BOQ9AFDTh8t9yhQ=;
        b=Aww8henule/dr0pYzyWZV/kbCN4VlRv3Bb4rx2MgwPJgsI8SN2p2YmsWAxM36qalAs
         +il1t3sJ/4NSyxiKNL6vVPAaOKBuRJ6W2WmywZM/k/zbEMkPXPF73Dq44IsHAZHcLSa2
         TL691IhDDtBxzBpZhySiOIt0qWfUybzi5wotqNgX/vlB/WzkKPPZEnCzzmAP4cRawfzQ
         s+x6A1bLf+pJJPEO/hdS07ARKQB0IcCk9tEyhQyZKUW1f4AehGoqNeimzwryrof2RsJA
         eRvOIuGKw8hQLdYbwX3svaJpyomAw7PYRw4Bj8l7tCfClx0ZeJ2/ZmwxR+NC39xI6jw5
         EF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218124; x=1793822924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ootfTXrKHKwvE1mze1ealqjStl64BOQ9AFDTh8t9yhQ=;
        b=XHTTVM1HDCnDuY2JtOFC6EbzceYDBTeXCxXayvkBeCCWvJUIwkfDNlB2UUIgIpdD5P
         vw4f8rljQNDCOf7UBkNdoC4nSwOEgAeSiaAoRroICPYeayuWKr4KJuPO7jajqlayn6zE
         VoL3KEh0e5p2E9TrKoFMl+VpmzyrhWBnSD460nvqeLdEkesfLtyYA1y6+Rx9OtAzswFY
         qpgI6lHSwBAtZVI6hh2nQZx235HzUS77lSuV/2EqbcXCtzybBw0+Tw1v2LfxIpQFIg+M
         iyDYOyLS1nSAkPL5crMDUHFpsoFhGlkl9uuskoZFZh5LimDJQSz8Q+uAM8Uvak+ST2i0
         juVg==
X-Forwarded-Encrypted: i=1; AKwUvBzA/n6GUqbdOlN0joRV2Z+BPK6pg4okpoSHvew+Ul7G3xhc2JBNt0sF2U2x2egGpGHDmamVzHJ3Qnt8Yw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJk5BAdbCg3VPTa7vxKZwmTtbds3Vivax+A4tEturwqrtLv6wiV
	7N4Ktw0zavv/nf2875GFMZPcMKEGHVdOa1mf2pu5HTXY/ThHhZ2cY3Un
X-Gm-Gg: AYBFou3FytXfRFNkEYQvMzA2LA6a6gcTgtNDZ0KFuBTjw48nJobAB0VbNN/Mze9doEw
	oNecJBBdwlwbEynTXw/vV+OGcpAnVw+gIUaRThr8bsx9un9Q8apF0gm6x+I6usYVC62Jy/dMdGF
	4HGTLlkCGDJbhfFwbGbJFtWj9ZWNkWwhs+ri3IsRjd8O3CQflO+gaUCvsXvlKxForReQNjpDghz
	4zHkVNtlumDi2T0KP42SsmVtYYH7or2Ss7MX0KyyBeoQbiZB57OQSTbt+t4PKaf9jHwiyRtvBko
	Uo3xB/qWcxCzpJ1Ks4OZPnTHB6h9dQE7Hpt88a3mL+I4bpRlC+x6TDjAMQk5YmgmwjKRbqhRpMl
	6jAsMXKyukmXHu2QwTsVmw2YZgK3CBytRcnejfr8kap3xM5QgiWrJFhEdUg38b96l/gjbRNPHDA
	QMA3rbEDGTzuc4XGwCuOWkybpJxWbBDkFoC/q5/S1XRLwfEleemDA45yzS0PLxLfVn9ujfzSp/t
	B+ZZxIjpXtmLyOSCQgYAXj2QWQVVEG2RpSfECXU+7rolzjhCr2MRMH0NUhTHIzHdvFwtakLHZld
	SVdaEvt/9SWW1vmZtA==
X-Received: by 2002:a05:600c:37c3:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4a96701830cmr76128215e9.25.1793218124439;
        Wed, 28 Oct 2026 13:08:44 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm30134320f8f.4.2026.10.28.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:08:44 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH v2 1/3] HID: haptic: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 22:08:37 +0200
Message-ID: <20261028200839.202670-2-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028200839.202670-1-mail@taterr.org>
References: <20261028200839.202670-1-mail@taterr.org>
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the haptic workqueue.

Pass the format string directly to alloc_ordered_workqueue() to avoid

a format string vulnerability where hdev->name could contain % specifiers.

This also eliminates the need for the intermediate kmalloc/sprintf.

Use flags=0 as this workqueue only transmits output reports and is

not part of the memory reclaim path.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-haptic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08b2c..c3aa7db44766 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -418,7 +418,6 @@ int hid_haptic_init(struct hid_device *hdev,
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
 	const char *prefix = "hid-haptic";
-	char *name;
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
@@ -457,12 +456,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
 	mutex_init(&haptic->manual_trigger_mutex);
-	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
-	if (name) {
-		sprintf(name, "%s %s", prefix, hdev->name);
-		haptic->wq = create_singlethread_workqueue(name);
-		kfree(name);
-	}
+	haptic->wq = alloc_ordered_workqueue("%s %s", 0, prefix, hdev->name);
 	if (!haptic->wq) {
 		ret = -ENOMEM;
 		goto duration_map;
-- 
2.56.0

