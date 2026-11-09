Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259902;
	b=Ix45QmZYj9BM5kuQobamCPZEFCWmuZm7/IBr3a5eqlVsZ7iwZNHtJA9MzsqG7ZEvy00J
	 caS+S1hmr5VVRaae9PG8cgJUfPtP2/5LJyWMdooF9VasA2kwc4+Qm3cEZKszYz+y3yZGM
	 Gwow8KqpQtPupJmjWVe8z+c544hzzeEVXOX6CNm+unEQOn6dj6RnVEcM7Lnqn4fJrAvKg
	 yYezFbjvkNT3G32DAdTdMeFtuhHeYqGdYbcqPXfuio+oS/w1sany5Rb7lIvQccrmbcJdS
	 V47VKGPXTPKk0n5uq6gGXC97NB10gnFuHD3Q3MIZ+Xf1spiYjGdhBBqwAVrRKJwh29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eNp96MmF7Sq+/14ar7fJvgB8dzv/Z4dEdmg8x79nQFo=;
	b=Sd2/ozEPl1MNMmoVIh3OFbsG2B1+C24sz0R4ASfgzEmTj/hObe5U+FC7WvMh8571SDZW
	 1FsrtE3gs+tmGTlVEmMDLVrIGUNIorXhWeMr+tQyg/HUWmGWSZ++k3YNwIA2KlaBV7icN
	 duwfwy21B65z8vbx/nrsC074AbLbtYl1RhA7surp2Oj06L5KRtr1E4KfQL0yJ1n77mR+g
	 c0r2eZ2iZGE/s5wH7iFM08l2nE4Ed6f7cJNJ0m6z76mTvsHC/W3uDwxSwvt+ZyUTnm0LQ
	 9/umPqddchWUBOT7PLWv8BWZLPrYsqoon87raHi91NlC1rMiDRq6Xx9zOQXFty7zkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojvY7Vad;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF34606A325
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 21:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF34606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojvY7Vad
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so16438655e9.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259901; x=1794864701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eNp96MmF7Sq+/14ar7fJvgB8dzv/Z4dEdmg8x79nQFo=;
        b=ojvY7VadMBzmuWF3zctUCfhEGniSRjwwElTO+Ph9JLqPSH3NLr9L0G5dboFfYyTg5Y
         YLQ+on6SEvbvm9kPvsNporF3/uTwSbqI8CU3vPoHgz9P6Fk0uMTRvtxAooC9ItUt7JWk
         VHZFCsbcm4/VoYywLpQzDjMTGOCw077YaLolhBOLukH3UWIM0NUQUsUjeA9xkKSFDKq7
         qCLZ6UCb9JA6egDUKdnywxPmmoiJsBiiRReQIFSK5N2S8RIn/7b9x3pWOHtvoS/7gJiC
         ARRGO+E9aAI1ItLm5zgpy3/7RhOHR+MD83mluhYerd5fd1joHwv2GzYZXvy84KprXaM2
         QYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259901; x=1794864701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eNp96MmF7Sq+/14ar7fJvgB8dzv/Z4dEdmg8x79nQFo=;
        b=YX9gUY7+iqwk4PwCXvWH+7ZQRZ3GXhs4nZicK83E8SiSi8PDdDd0JmRKqdPzHFez4J
         HXjNIyF/Uo6oVEXmhofYHQwM3WDaNL2QmfSEz4zpJZiSeTNYPc3i3K3bOFrzBN19yNlX
         yBy+dJ+UvawV23+uEjQqRwiPYdBSzQu+ESXmxNqEXwYELsdn9Jpg/9G/Vx5NRNZnnnSr
         wrejbvu6C8TI+CXD2+xIm4qbXu0ZPBLSkRPbrJvifII7zf1vLmkM2KbXffSwZmCbK9FN
         31j31yrdND3cDfMiF5r99acmVo15fgiuQUCrsOYsb/2AxD+7cBww3OrGcuptKace3Z4P
         8A+A==
X-Gm-Message-State: APuU4Z/CouvPrMV/VjZZ7Z5m/3YjfETlYEXPzsSx+sjgQ+WPTFAaRSKu
	0NPF7OriE5TEEIqUNfqMFDVtpIgL9euTW0cXnRSXJ0wNBdBA9ca8hQuX
X-Gm-Gg: AYBFou0qUPSn4lwamvUSwyfZkmFwrh7+R6gSvhe5k/ICj2JTAgPwzSTnh93cz/t3qWH
	WE7M32nCTYIPR1pOP7lHw+63jXvcVRR/w7c7A7pp7UJ/33guNv8gU96jpLGtgi3t6CbQkK9qW0B
	vLErIjKGX+utXRn+g0gwRbr3ryGV4F6MZTPgJQhk27FAUexu7tPisg5kowDNG/dTweojY4N7IQe
	8pb8P1MQBd58J14xuXJYWcye7R9FbWf0Ezy/kPhtjd7KJmEukDWn0G/y+TSLFNgtb3Hn1s547Hi
	bGDeMHmsffwGe+XVU1rueh+CYsfrS9SFvm55roWeTCh3EjHMopDTGG82rj5xdjOAoZ3+DPRPAj/
	SNjSwVOn9QFKEycQ9FlSmAkNTL25OVZ1RmMwbcNO3yxIDP/sIlrpGpsBRX2coJAmVB+fvokYe5K
	eX7PESLjU6lVbSPdtjVylXvekXlIIdZABTCXiNRbC8Sl4YqTOIhUBUdkFYlJHwitfvbLPAPLd5G
	ESX6tre1I1uACZbG1JeFjRFLW2qmvVoUIH/EKsFAI4pR52tgnI+XwTQT9BUl1pqWL1My71Nankx
	fZJIji8cCPeUkakW4ZWLrLxOWpV1fjh5FW7QzBhjHtkjpjauAzcK4K9Iv4bPhsJ2VVTFajPSww=
	=
X-Received: by 2002:a05:600c:8189:b0:4b2:4b5e:8141 with SMTP id 5b1f17b1804b1-4ba02347fe8mr7596085e9.9.1794259900532;
        Mon, 09 Nov 2026 13:31:40 -0800 (PST)
Received: from acer-gaming (121.red-88-28-14.dynamicip.rima-tde.net. [88.28.14.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204e22csm13525565e9.12.2026.11.09.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:31:40 -0800 (PST)
From: Juan Parrado <jparrado.1817@gmail.com>
X-Google-Original-From: Juan Parrado <jparrado1817@gmail.com>
To: jparrado.1817@gmail.com
Cc: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	jikos@kernel.org,
	Juan Parrado <jparrado1817@gmail.com>
Subject: [PATCH] HID: dragonrise - fix button count and report descriptor for PID 0x0011
Date: Mon,  9 Nov 2026 22:30:27 +0100
Message-ID: <20261109213027.25501-1-jparrado1817@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAFkAFXpOOSEiGEMqGjJp2yTf82LSRkUykYg9Uit3Q0fO0R4Tfg@mail.gmail.com>
References: <CAFkAFXpOOSEiGEMqGjJp2yTf82LSRkUykYg9Uit3Q0fO0R4Tfg@mail.gmail.com>
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

Some variants of DragonRise Inc. gamepads (PID 0x0011) report 12 buttons
instead of the restricted 10 defined in the static fixup descriptor,
causing physical buttons mapped to bits 6 and 7 of byte 6 to be ignored
by the kernel.

Expand the button Report Count and Usage Maximum to 0x0C (12) and adjust
the trailing constant padding accordingly so all physical buttons
are correctly reported to input/evtest.

Tested on physical hardware with the Retro-bit Legacy16 (12-button pad)
and the Retro-bit Mega Drive 8-button Arcade USB (10-button pad).

Signed-off-by: Juan Parrado <jparrado.1817@gmail.com>
---
 drivers/hid/hid-dr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index a1e10ee8d..e30b7fd94 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -196,7 +196,13 @@ static inline int dr_input_configured(struct hid_device *hid,
 /* Size of the original descriptor of the PID 0x0011 joystick */
 #define PID0011_RDESC_ORIG_SIZE	101
 
-/* Fixed report descriptor for PID 0x011 joystick */
+/* Fixed report descriptor for PID 0x011 joystick
+ * Addition:
+ * Some DragonRise PID 0x0011 variants (such as the Retro-bit Legacy16
+ * and similar controllers) feature 12 physical buttons instead of the
+ * restricted 10. Expand button report count and maximum usage to 12 (0x0C)
+ * and adjust trailing constant padding accordingly.
+ */
 static const __u8 pid0011_rdesc_fixed[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),           */
 	0x09, 0x04,         /*  Usage (Joystick),               */
@@ -215,12 +221,12 @@ static const __u8 pid0011_rdesc_fixed[] = {
 	0x95, 0x04,         /*          Report Count (4),       */
 	0x81, 0x01,         /*          Input (Constant),       */
 	0x25, 0x01,         /*          Logical Maximum (1),    */
-	0x95, 0x0A,         /*          Report Count (10),      */
+	0x95, 0x0C,         /*          Report Count (12),      */
 	0x05, 0x09,         /*          Usage Page (Button),    */
 	0x19, 0x01,         /*          Usage Minimum (01h),    */
-	0x29, 0x0A,         /*          Usage Maximum (0Ah),    */
+	0x29, 0x0C,         /*          Usage Maximum (0Ch),    */
 	0x81, 0x02,         /*          Input (Variable),       */
-	0x95, 0x0A,         /*          Report Count (10),      */
+	0x95, 0x08,         /*          Report Count (8),       */
 	0x81, 0x01,         /*          Input (Constant),       */
 	0xC0,               /*      End Collection,             */
 	0xC0                /*  End Collection                  */
-- 
2.56.0

