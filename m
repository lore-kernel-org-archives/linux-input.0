Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443355;
	b=w7IK1Z+6SVyxqaclIggLsuHODfy/o+7VdVXCo3OIwq7os51ax9hsKhwHI8bNeKXN94xi
	 MzPQL+yvPcLUAWaXPwsAczCODEvh8goIZcm3cgmDdowJX86XDKV1yeXXi7AYlepAJvbzl
	 c9Cp2RsbE0PVAroxADdfoS/OZ1D11GTmQJ0LBI9T255kDRTWzKjdB8B5qfXMC2advxGrp
	 VsGSPoxGYJvpoVKhHZLGTgTH4C4LBffnSZ+9EEBfG0+O8cqUeNkSDlBuDyIWNr6bGzxMn
	 l66Xsc5kny9eNCaqTke5hd6JNjq+wEkov3fzRBVifxoUr2tWs7nHrHwYq/Jc+bvIv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0vGNyzaHVqr7cdz5nWqPjLRfXfGYkfsBDDj61ImzMyg=;
	b=SIXy2zCy+ISnHzMqUmvX/yErW+xusZqjiZqPh2rK0DgqClpPGE8emADcwmbOdJxMqPm0
	 ZzWg3jl5xrb6PARYaI38DYeZrz9xqn0j/E2iLhUEPJ8h6T7zWRjKqrMS2LXurHgKhsj/C
	 FHrn3ca4jmCX9C0tZ6bPgvqjAc/Joy4ijUYfiP5l5qTiC+5dewVN2C2yQG7fbxErGe3KV
	 ESdwtIC31fl5dsdbtoPRN6nH4hn0rkV6oQ1DcB5p+yoSe3ZKdOU5XSFbMMDYRRWwYw/pW
	 /xrAS17ERyiNydhzk8V53fIO13pb2oF/7ZErAoEbcA6PAxuK4ZvDm0R5o1x5qxwxsNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhX+tYfK;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2F606A337
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 14:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD2F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhX+tYfK
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4c685c751so27755327b3.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443354; x=1796048154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0vGNyzaHVqr7cdz5nWqPjLRfXfGYkfsBDDj61ImzMyg=;
        b=RhX+tYfKYsuNzQgEKwj/hHuhak3o1aa3YlSYYgnwTkQCvKTS6+GmMwt7j/swEFvEbE
         t+ipiwmepCeR18bmCqMSVWYwF+ogZu+avjczkfCUqu17wu7c8MiB9clma/8HfYOVlWbr
         jgMYohdxkFiMcDjhm96bSU/U+7whFr99UdIo1eDBchx8vBTwBeb2tLLGYtGN3xjfXPCk
         7Nntzy6t2qPVdWwEpTa4dJtuEwykjQ4VPnwHiwwM88MmkA89xmSRue59wNDUdBG1vcwF
         kK1YJT7vwU4KtBEPtNMXsaLJb2Azzm3j9xPVk6BBsuVh1KIW/sN96YAwm/QyVBlWltrE
         5XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443354; x=1796048154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0vGNyzaHVqr7cdz5nWqPjLRfXfGYkfsBDDj61ImzMyg=;
        b=tJzPGxOirp+Et86MXyHiTjy6ZoBTGEYv/9QrhNykR6aP1GPBSg/9+h6Zm/85ky6KcL
         eR/HvnjQs0ctP/61gzgJZl2VWPYn3ZVrq7RDWnQ5OM2Aieaefgay6QR/M86cmyagOHsR
         uHc32K+v0Vn3no/VT2CEuqwREPnBJWEQH+fmKPrN6YE1gskBvnbmR3LA6v0qCm/1fX0M
         qyNOvsax0uOuWNKujfS9Pe/NSeTLgx2H/CeA9+5Gpj4e/0Y1LDy4Tua91xHjsEwhs+PH
         GlLx9EE7ADnRruxQRnBddzTvmNIU5N4bZH4vkhBV/r6BxjoenIqFLV1xQtAd1XwOCdKi
         F7mg==
X-Forwarded-Encrypted: i=1; AL+hErG5gVwV0d/vAVhR2VeHxEa7fplCt5jwFPlh1b04rL1NNfm58vuA5+3wVW5IwSoMUisZLZ62PcUXzIC0eA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/GKkEISE7uQGc6JejymsXDrbPG97zy0kqb3O01eyF4G2Gz9ZaK
	66LthKEpbIOUeWzIZ7Cfc4nUuYNeLjWV+RKtp3PBu98HD8kByJIQ85GKNZJG5QhZ
X-Gm-Gg: AZFdTZcCOYiRazm6/2AfUBu42uqFXaNY3JinLOzNoNVAJmeFEN1AVA35LyzUVkdaqEl
	0zeOxKMifXm43pBiT47N9gMIUVkbj16t+tQngLPRNgsMcqtkHpZUeeMkVcVcynJjHqPYhBT8YqI
	/KxGRTF8UrsB5opiE7u8FI8mbx0qqaO13ZH/Scp/pDhC6O7RjTdnb+YbnqnwsevR+0iwxcKw3uc
	vRCOOUEfGE4LRiw9KS10nWRz9A/qbHh3yDjvt4N7ExL1AD/yn7tyTSirnVZJrWN429TwonRHxeH
	G/MqdwNUPaerB+SnjF8cvM65+h0+fJwplDoSwCnvw/fxkhl2ceUZ4GS05LM5H6O0+4tEx+kVitB
	9JaP7+/0gSv2t4xrmBH3cTa5Bmq5p7ogB1LA8D0PqXQPzRvWUV+bHKyuWAt74slQTVLq8uX6C3q
	F1+ImzfxNyEFdhcAwF3CbBqkZohoPNvCFMM5LuUnaQ4zOq9JNsopf+zBN9gqmzc/8qMmetMi1QK
	JHiu/KP1vD9DXFUS4bbV7mePJpm1DGsqRU8VSREio0dWAg/0T/JfGIHueMZZtk9/p2CslP+dUcb
	zJM/Dn8MWRzlNb8y
X-Received: by 2002:a05:690c:a202:20b0:8b5:3578:f44a with SMTP id 00721157ae682-8b53578f8cdmr11263107b3.37.1795443353775;
        Mon, 23 Nov 2026 06:15:53 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202c089dsm45681087b3.22.2026.11.23.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:15:53 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/3] HID: pulsar: keep battery online across RF standby
Date: Mon, 23 Nov 2026 22:15:40 +0800
Message-ID: <20261123141542.8128-1-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Wireless mice using this protocol enter RF standby when idle, causing
CMD_STATUS to return 0, and may wake on motion without emitting
EVENT_PWR. Tying STATUS, PRESENT, and ONLINE to battery.available marks
the power supply offline and absent during standby, causing userspace
power managers to treat the device as disconnected, hide the battery,
and stop polling for updates.

Report ONLINE as 1 while the receiver is bound, matching hid-input, and
gate PRESENT and STATUS on battery.last_read so the battery stays absent
until the first valid reading and retains its cached state across RF
standby. Because CMD_STATUS does not distinguish RF standby from
power-off, the last reading remains visible until the receiver is
unplugged.

Fixes: e55cf379e822 ("HID: pulsar: add driver for Pulsar gaming mice")
Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
 drivers/hid/hid-pulsar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index a1f0dcda92df..e726dffb2f33 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -362,7 +362,7 @@ static int battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!drvdata->battery.available)
+		if (!drvdata->battery.last_read)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (drvdata->battery.conn && drvdata->battery.level < 100)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
@@ -378,8 +378,10 @@ static int battery_get_property(struct power_supply *psy,
 		val->intval = drvdata->battery.voltage * 1000;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = drvdata->battery.last_read != 0;
+		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = drvdata->battery.available;
+		val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
-- 
2.55.0

