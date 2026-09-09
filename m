Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FA29AAEA
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916568; cv=none; b=B6bUE3h38u+M8+yzgJ3d7tTyltPzD99GW9Mls6uY5O3AlKdd+WsysnV4UTH6pk706a5hGhFmMGBwfV+oN2RyhKAIAkwZfpVM1cXO2LdVuHXp1xh5gOzAEeB3blRWxp/nVF6gMuOalbs9haQyaEf3JlxFMxKjQ2YSgnHvkmd8IHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916568; c=relaxed/simple;
	bh=hpzfr5kjTGPkHegncW20yvavAdx/YxzgfTqNOkbXlWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8uAtRvPLwac1QvxGGlCf4et2MOmBjnnr/Gs95AqCqpdJYclrP10j1tb1/DeHw0VzOkS6DLMuI93HzkQ+agfTPf7Oil7QXD8hf4OOnwpS9bVF2/L4/JgcaQW5UcuUIVEHOwABV7gTz3T658M98qaAx1mrlOXUxHF2WXbZOf+gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9MsjPY5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9MsjPY5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d58efc7356so67299055ad.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788916566; x=1789521366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1djv0lADg3+5bfdctytbSYxJnlVTWuvq8HJ74XYnhSs=;
        b=S9MsjPY5nAHASK0B6ysG+0H4AL0hflZeIFXIgWJWOX1ErbBB1/AGYR/827G9YUKeH3
         3w697WYbBz90hDiwx/OenJkBNnBVHilNwPQaPOT5np4lMC0aUbJPwN7gdJ3l84KJelGw
         vSKVAsXS/7WkaWP1g0hgkZdWwQNCkjX5okWQT+jr6vrEZthri2PxttzaEOKbau9oO3TQ
         cLjaG5mDp6rmpnWSOZ8ZhzhebuQo9GDiwXSw62t30VZoEiEoooNmfjx90TfVejweIEUp
         AVtWmt4RbXbP2wbDyJ6CXm8G/tPtDbjEZGr3vB5KHe4TsEwhFHDqzn3GckHCuqoUvR3h
         GGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788916566; x=1789521366;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1djv0lADg3+5bfdctytbSYxJnlVTWuvq8HJ74XYnhSs=;
        b=P9e47Jatvvlrw+3GwsK5QDkSga+NB04a7/qeEC+IHE2qlCFB+mJhmHILsVnSacwkkG
         zkpkqMJKTb9UxMhPe192vGSkV9q2DSN1/IOfLF01m9vUGxHbRRbdehyb/fy8XIQDQEWM
         UZ02WexF04B3/IH0is6/M0CyC0SRe6L+gLgxwdjnr5pfgPpkA2jzW8MRfPN9a6JJHptd
         Pw/OOQfbQyvmhvo6cdDY3TgYGHAT5gLmzB9b5CT5gNG01BXphwFGg2X2LiNMfmMLFFB0
         DD+prCSfuBqwyBgXxQ1B92xqTZSMA4MR8HuFvltQYRksjPBHYMG3SRNkv8b5kinCihKI
         SD8w==
X-Gm-Message-State: AFuF++nOT6o2HtkviUGxj1bgExV3sTrpZqkDIsT4MaIXkyfjhoBm6ys9
	4+a6/q7geUCvNaTD/UPrCOLApuGR44VK40S63VMcto2D3+QVQecCEKcUWwBKaWknDuJVeg==
X-Gm-Gg: AYBFou0CW0EBHP/RR0vqfcLq3bT9qiJNafDj9ooljeXD8QVT5zGg0FQZJ26BBgFuI6A
	Aywq+I5U6czJL/BTFkaUFXPoCumgIyOQl59yu5YV/fhEujCo2w0GbtuFqdItmBCaJQrEBG0toU7
	Sv5AWYzJ5cX7wVNo3Z6vU3mwqNP02S/2Rfuk18ncE3IjB2s9mTLg7swkAYLJucJbhf+4TifEZAG
	a3McNJx9FM5CdQmLpbwpSY6gImhkNzAtIJOe3qdVsoHWjKDQPzuh7Ju9Deh+fnoFbN9O3TATUtD
	r2llis7HJzFlV8OhBzHX15HGQ7Id6SF4vAns/l3feL6NQ3G3Zx0QG+Z0V2f+7PB7SgCMiibeQBE
	qgN938+ooKr5vakYMzzbEB9zVwvhYgr+8bnDtFMUe/L33MwCvmiuWFWS+yYqS0wJOtfgcOhykVa
	fFCeT0KUdfzHj5qb51RVQHS+cYF6xwdi4MIagYjMCSvhwrwUVZe3Yk4OYA+EsuXhOpi1xr9BVJM
	ifWu8WWOsfSU3nVsCS33reIwiDmDnCRWIbRdvl4Kz8wjt4R6q7CVg9wkUCDjZAnJNfe3RsH5ATR
	HG+qKv5ikLdvRbMoj/k=
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-39b2620a2ecmr45550285a91.17.1788916566226;
        Tue, 08 Sep 2026 18:16:06 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cfa2eaa92sm279074a91.3.2026.09.08.18.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:16:05 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jason Gerecke <killertofu@gmail.com>,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH v4] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Wed,  9 Sep 2026 09:15:13 +0800
Message-ID: <20260909011515.2314-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
References: <20260828033323.82958-1-98lawweijie@gmail.com> <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'wacom_wac_pen_serial_enforce()' function may calculate and pass an
invalid offset to hid_field_extract(), resulting in memory reads at
incorrect addresses -- possibly beyond the end of the report.  If a
field in the HID descriptor lists more usages than its Report Count
actually reserves space for, the function's inner 'j' will walk past
the end of the field:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

A descriptor listing 12288 usages against Report Count 1 has the loop
extract the usage at index 12287 from bit offset 98296 -- about 12 KB
past a 2-byte received report.  The value is stored in
wacom_wac->serial[0] and can reach userspace as an MSC_SERIAL event,
making this an information disclosure.

Clamp the loop to field->report_count, the number of value slots the
report holds.  Value slots past the last declared usage are still
scanned; they reuse that usage (HID 1.11, 6.2.2.8).

Verified on v6.12.105 with a UHID reproducer: a 2-byte report from
such a descriptor trips KASAN before the patch and not after it.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Suggested-by: Jason Gerecke <killertofu@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---

Changes in v4, per Jason Gerecke's review of v3:

 - reworded the opening paragraph using Jason's suggested text; 

 - picked up Jason's Reviewed-by

 - no functional change: the diff is byte-for-byte the v3 diff

Compile-tested on 6ba2c27cb9aa (x86_64, wacom_sys.o); the runtime
verification used the identical wacom_sys.c built as a module for
v6.12.105.

v3: https://lore.kernel.org/linux-input/20260828033323.82958-1-98lawweijie@gmail.com/
v2: https://lore.kernel.org/linux-input/20260825103104.12090-1-98lawweijie@gmail.com/
v1: https://lore.kernel.org/linux-input/20260822120926.153849-1-98lawweijie@gmail.com/

 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..40770affdbde 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -113,8 +113,9 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+
+		for (j = 0; j < field->report_count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;
-- 
2.43.0

