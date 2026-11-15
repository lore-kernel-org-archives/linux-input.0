Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712033;
	b=wd68r3nn9md9yFDts8lqgoEaB2qJmV/tauADWAmUIcoiel9zaMhXqSADdDbipAp6OUgU
	 5vaJclbRyueOWTz6nvo6Ur41qsXvI+quP42XQys1D29B3YlkV+GCxH/7B/Vqb5NF/rEm+
	 421ydGWhihQDIkZfw5hu93Z7Cx10IVj++NNf1ShG4PlpNQeQpn2ApQ75yShXzwsaHyuUv
	 j5ds+5nxbEcCUY13HIEaO67wwLfkBQlOZNUgJqXMqvz839Jnc+jrp9m3BwMvm3S5j2b2F
	 RVByDsELfCnbbugpY7ZVNnFzmiOnOqnu1LS3gBN4DAj+jYqs93UUXP5T6/BtoT+AOog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QlfIoOulKqR//jecUTZfJjjp8+vB6/pWGpBLndALDCY=;
	b=lJe+mpgquz96ULl+BKITo2t9kIPnPv/tl5EsUm8BTFnTMrm3D3dUYkcO+EuNWs72LwXM
	 ny/QTJIOCVt3VBbOhGALtCJ0YlDGRIxz53cB+yjmnyL5LQL8R5k8wjZzwuf3fsvrUfX7s
	 b8k+ckTeKNPTWslYv8YFZkxJymmYklVWS6d9u4flfRzxhgomNu8K6NVONnPR0DwQT2VtL
	 +76B8LsLizgZL8NU8Q71X1gBxbwvc8s2X/xCI052FwJ6y4Rcf2eM/YgVU4Rm+gkBDR1Ys
	 ycbyvf8t85F+5tSoJLW5q4VgJAQNp62ASAkYboymamgzaJ4WKOgOLqq9xIl3UBvtCdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yySj/SJX";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC606A329
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 03:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494EC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yySj/SJX
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so3315246c88.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 19:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794712032; x=1795316832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QlfIoOulKqR//jecUTZfJjjp8+vB6/pWGpBLndALDCY=;
        b=yySj/SJX2FvEG/OaPjmArin1HcFhZW5/1joPoJKQBvx/MgLiHV40gA+GZOnlaeX+s1
         J5t+R0H2+a5V7I45OVP8fwt6K8Dejo3MAEd09wJ1RS+tKuDyUMwoiihPbSymzazGMeKr
         ZmDRyW12r92TrWC21FhsDIciNEbp4ObcapD36mGeOZ/CnbAuhdpcwwdNr8KrTh7qDNyY
         j+Yl0ire77a5klJI2uqR+I7eNvwZ6+2yeS5ZztxQRsx6RsIZD6IkeFzCB5ABksq1YbjC
         gjrDDTnmew9biFo2sbj59Wfl9XHKlCaBpn11RbYYILnGjD2kTw4yNMZUN2KPeSY5kcLJ
         bDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794712032; x=1795316832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlfIoOulKqR//jecUTZfJjjp8+vB6/pWGpBLndALDCY=;
        b=JNCbwAwQbH9NKnuC//vnv/p7OiMCr1s/uIFf4SCp9Mzb/fHpnXQ33z1kRixsnozlop
         4/ljYlf8QdrOpz+mb6BXzXQG3HQbIqz3braIy72LjtpCR5gaClGYw+Mr9sTL4YPbBwJi
         HvB5h2a+CqIJT3b36E6rKjeRd53xteI0Ux0Hf6AS0cAJLWR3skWyj/tGl7h+hN86Eapa
         oE2N+dckqCKWBVw6c07MhFOg6MGqjUuDmj2ynq8Fzpeuyjcq8YVYmWeF9Wq3gw4GrO3w
         Ee8PKzlEOpAxQaahZnNjokLpaDa4FkzgVn8OknvsjpeOM8MudHQr/2i3Z+ccHVIlx6Pc
         QxAQ==
X-Forwarded-Encrypted: i=1; AL+hErEkV8tUf+BLZygaPFQeDSw3IrwIvTBVTvb4NKi1+pq5m8iezQ6yovAWC6ntoZ7ndGFtYc3m4/zRnyPrrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9VCuL3vR70ebw9NvWVepS+Jf69zIH4lZNDDDxk9paFWM8oqg9
	K67As8wqyqVOptoLU0Rn/L+p5r1CnRUvkPPq8wOWW2PZ4+dYWC3kgnbe
X-Gm-Gg: AYBFou2AwdrCquf4MdlJw2Flu5o6Z0+tEqSFu3bwqPFomAOgiN/apSLdbfrwEpNoKAE
	QY+2ySboQ0FKQ+VEpVc/U6aPTuahB+/d0ieLdlQrcbysrGy3mvqkXh7YSkoOZNoXrVQDJ1FL97u
	5eaEU9cjC4h9+9GNgfRJuFsTEf24X/mPB0GQ2vcGYpCxnec/V5HL2xsUBzXLACwfAHOLm8caIKu
	mH5Ur5RR2EzAO0sJv80KTvJhnAHjDm7XrinmVcvT/fUw3aPKE+Y/JkF1/+aX9ScLBF6OxQb7OVM
	z6Gkf/GdtzxYARwLMDOuoxyghQ7vc1xEfZb6FHM//sbz4jQPoCng78sXJTvJk3492EJxkG+bxnR
	gdOPzk7+wfA9s3VbX2N/aIxNO6vu1LUGKrtu4Pg3/aWPCiXC3fKOaY42N6mWH3GRXr6RiOjpr4j
	JIhmsXZA4zrMO2E0xPnx0OJ3tYP5n1c3WKAyGhp+W+l1gMmTSyKOitwtpTKdeaZmqtmtJqv03nq
	l25KuLzFNWi4Gw6rlfcfOrhc2e/HBMKaQRxmepUPri3COrGUroo78J0GOQmrbdhuUgWnKX3he89
	Qf3PFlE5YF26P3gX7AJS+ZmV9aOPcu50fGx3GEWfnNybj6zoiE/qLaoOV4dQZUoXtduFDpGXnP7
	AL9IQJ5VkTXms1Ky8mErB+uqUhGRX1+L+OS5Gk51W6vE0Xtw68sMDkpMa4jA0bkHzZMYEnNBX89
	0ZXguGPFkxfhg=
X-Received: by 2002:a05:7022:286:20b0:1b3:ae32:7a57 with SMTP id a92af1059eb24-1b5031051bbmr7117595c88.47.1794712032179;
        Sat, 14 Nov 2026 19:07:12 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.24.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm23510960c88.8.2026.11.14.19.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 19:07:11 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Brenton Simpson <appsforartists@google.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH] HID: sony: fix RB3 Pro full report poke timer on 32-bit
Date: Sun, 15 Nov 2026 16:05:06 +1300
Message-ID: <20261115030505.633497-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Rock Band 3 Pro instruments need a feature request before they send full
reports, and rb3_pro_instrument_raw_event() rate limits that request
with time_after(jiffies, sc->rb3_pro_poke_jiffies). sony_probe()
initialises rb3_pro_poke_jiffies to 0 so that the first navigation
report triggers the request.

jiffies starts at INITIAL_JIFFIES, which on 32-bit kernels is
-300 * HZ. time_after(jiffies, 0) is therefore false until jiffies
wraps five minutes after boot, so an instrument connected during that
time stays in navigation-only mode until then. 64-bit kernels are not
affected, as INITIAL_JIFFIES is positive there.

Initialise rb3_pro_poke_jiffies to the current jiffies instead, so the
request is sent as soon as navigation reports arrive after probe,
regardless of the jiffies value.

Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---

Notes:
    Reported by the Sashiko AI review bot as a pre-existing issue while
    reviewing "HID: sony: fix sleeping in atomic context in RB3 Pro raw
    event handler". Built with W=1 on x86_64. The 32-bit early boot case
    was found by reading include/linux/jiffies.h and was not reproduced.
    
    The fix and changelog were written with the help of an AI coding
    assistant (Claude Opus 5.5).

 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 50f5ad6bbeb4..8f19d3cc73b1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2392,7 +2392,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	if (sc->quirks & RB3_PRO_INSTRUMENT)
-		sc->rb3_pro_poke_jiffies = 0;
+		sc->rb3_pro_poke_jiffies = jiffies;
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
 		if (!hid_is_usb(hdev)) {
-- 
2.56.0

