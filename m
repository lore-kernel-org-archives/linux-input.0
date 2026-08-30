Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CA320393
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123195; cv=none; b=jQwKP01DDYmcAhne9rQf4nLIkJSMKEYIbHEyoaT3OIIo+tOVz/iTDnMJK5NfyiGXG1UAV6hsjNt5s0dFcAaGlJNrT3IgnytcD/n3qCMiITp90aLqekuGVuSzlCT06WZZaSJeiH7U6ntH5XyyL4bVa+Q763M2v14B/f+At3a/tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123195; c=relaxed/simple;
	bh=23/J+3gDoDVZml6rrky5zUoFra+g0uhnHf6Qlc/3LG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEwYzRcVbjqfau+OSivnMk9DI7/+SgruApNxbEBlPXpwnVSErCvWsAvfnc1BNjxikxYoqc4oeIuZAQUwhtibKozshAOsnnp08PQeFlXNWSFBvfif6u6GhoFizrCK0ioSAG8VKv+cprDfW9GLbkEoJOguoIC7s9UbsjzxEUgQi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLG90q1n; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLG90q1n"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso3162182a12.0
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123184; x=1788727984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDmUbvUq5gus03tv1ZZ+Ru3jkSSxaXW9u1MMK1TfK1M=;
        b=HLG90q1n9NfiZ0jTc3uS8Bu24RQ401hDn1PEKJc4P4I+TZDxDTZsfN08Fm/GdTIYAw
         PFLVcVDkp1XjH16KQRkM9Wh/ke6D6mTWkMAgcSBxHBeJ6vKHL//ogA+gFDRgIjAkup/z
         ex7kPXIa8FMtdU52zuZgERfxD7vMyobTw5sF7jkF/QjYFyQFfl1zYiPhw52w00tl+JyG
         A3AYOFhDBd92cBNENjC+eWDzklw7MEZ4kREpxpw5gOBzc6nao52Z98B0MrmDJ/o6l+QM
         JhmLreb/7UtdxJF8vCPTj1TlRkgs5XMiqSw5vozcbxV5b51Z60fTtKZacb6DTTjv8vwR
         awvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123184; x=1788727984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDmUbvUq5gus03tv1ZZ+Ru3jkSSxaXW9u1MMK1TfK1M=;
        b=oJlbp0JbOSmIi7bPQWiwJAJPG9sLMJrGZ1Uad0LXgdoPeht5GYNZAJJY4jT/MFRbJg
         nrEmjdy9BDavAaRxkeQnNnmj7JSuTiO3EBaQzcA5e3sYWGnMSdQASc1xJa/V+ml8AZUh
         C07ONuPzaGv+inmPbPJbp3hEcYRX/KjVXFn76XEGsqwa1lQZa1diAuTR8t0Wcy3/2sLd
         DgtXdrVkrtE8hQYaTOWqjjewUgHsRxH4Gqqixp6hMi1kRciIaF4fUgyzjrDrVvxM2B1j
         KcciTLOws/LNqWatUpb/PJa70OU2ZQw2YWifdqiINvnbL1eoxROZflDoNUCKMbQsilWX
         HWBw==
X-Forwarded-Encrypted: i=1; AHgh+Rpu4CqOKMOik3TCCk2BOGzwoacRwJ/Wd38OXa4+Q8q7NiLMCq+99T0bOKDBPDD0miJLAJCu6JdaJ8INww==@vger.kernel.org
X-Gm-Message-State: AFuF++mf+8DNtNlkQPzwcKQ7ku9z69CO9Tm/Xvx3Mc4+nHsroVXgkd+r
	pZ0bhwE76IY/pE7R0h+I/TiJgjU6qogyh+qc+iqRGX8iasAMprQivjJb
X-Gm-Gg: AR+sD10RqEF84TZDAEaJ3hAY2aqivI21HlODGq2+5FFI7c31JbuBsf+lFz+BZeSNCxT
	3hV+bRkvSElSoOeF9plWkdB/E91JIuq3SdXY3pT6C5qfiwXch3TT8YPBVvYGtYvmJRetK+7GvGB
	O80EW3KKknnfIXNgoLY+RxQj5oWkmtK9w+2OnjR9ijA9vE3n5AoBmJ1hoCkRhkoO97WwGfKknTV
	Xb2MXcgITVF/scYZkXfPvriK+zIb9tsFLT55URiZDaZC2J2qhZL4F9nXJ42OO3j8vuYsaF2pUmL
	D5n82esfVi0Dro+soGLCH/5/XvaoMxJU5SuzAbV9WsRliGO+nUrlR5u/Rj5E+dzFnn3h/j6ExMz
	EkSn0wHrYxlk8VEao8wAcy5MLVsS3KSaBy3nciGKFb7iP2t+OkmOVtZb8OAH4R8dJw+enI7rxkl
	CHdPTs+ogDeQJnq30JsZ61xzmRegpLbFXDJWPpBP/F7qfsANz2VIH4iUQD3VjSdX8XuVvClwLgo
	0aOiSb2HzHGZGISsGYENYTM/I9TTNKAAU4xm+eJrtY/gNUVR+36nQ615/ladw==
X-Received: by 2002:a05:6a21:7e84:b0:3d3:3dca:f0a3 with SMTP id adf61e73a8af0-3d5d787403dmr2821879637.8.1788123183999;
        Sun, 30 Aug 2026 13:53:03 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c021:485f:75be:3c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm26849437eec.24.2026.08.30.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:53:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 30 Aug 2026 13:52:52 -0700
Subject: [PATCH 7/7] Input: gscps2 - drop busy-wait and manual interrupt
 pump on transmit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gscps2-v1-7-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
In-Reply-To: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sashiko-bot@kernel.org
X-Mailer: b4 0.16-dev-b242f

In gscps2_writeb_output(), after writing data to GSC_XMTDATA, the driver
explicitly executed mdelay(6) and manually called gscps2_interrupt() as a
polling mechanism to accelerate command responses (such as keyboard ACK
or LED updates).

On PA-RISC, the PS/2 controller asserts a level interrupt to the system
ASIC whenever received data arrives in hardware, and the input/serio
subsystem handles command responses asynchronously via completions.
Busy-waiting for 6 ms on every transmitted byte introduces significant
unnecessary latency during multi-byte command sequences and complicates
interrupt handler locking.

Remove mdelay(6) and the manual invocation of gscps2_interrupt() from
gscps2_writeb_output(), relying on normal hardware interrupt delivery.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 2afd53a163ff..985539f1d088 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -356,13 +356,6 @@ static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
 	scoped_guard(spinlock_irqsave, &ps2port->lock)
 		writeb(data, addr + GSC_XMTDATA);
 
-	/* this is ugly, but due to timing of the port it seems to be necessary. */
-	mdelay(6);
-
-	/* make sure any received data is returned as fast as possible */
-	/* this is important e.g. when we set the LEDs on the keyboard */
-	gscps2_interrupt(0, NULL);
-
 	return 1;
 }
 

-- 
2.55.0.897.gb25b4bd76c-goog

