Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697722;
	b=l6V0ScDTTGhvbepA6k+OzvQWZFemHjsgdJDuvjMQtARmuZVi6Xe3PWmAUacEmbJpRXld
	 krthgyPgRkA+klXH7gIjh0F7p+WFCEYTKV0CaH2KXy/xjjs6jMns5xxg+yF4UbgllXFa+
	 Fsu1eq7hAowC06ROdkSKkTETe28NennQ7J0JXDfkWfRCTKfzSUiXyDEbxhRbpTBKmj9EH
	 Hkl1Jd6ygUCmwM9DDrPm9u9nbYxCa4orqTKK9KaPLjPPlv9AOnnOPt8z4JlQBLlW6zWoV
	 a3CozTqR8n6XPSQUIWR5e97NyZk2TxWfep9IR+cyyamG/DJ6SYwKxTEJL5h2gPROd4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
	b=KG3fhEQVitIrKqlYcpMoCUM6RtsFQd3UTmq9jmZK3V0XzJG//dLfKeev09AedIZVYDUt
	 4brfJMBtF0jfmmedpeU7E1EEXwsD4lEcY30Q/AOqLJIwxaPlHdSET+aOudO0baPLTtgef
	 eaK9exZo1nPABiq2mTfMtA1/VkOVfy2uXFpV6eZajNXKGZdihro/uGCcUZr2qA7CHHAmE
	 J94BXpeMHw+4HfrC4dg+UvAOhVyhdc7im+J1qr8D+0f87em7DfTrvd6huBOUo+QdoHylk
	 0jBonVQh7fVGeP9euEzySozp6Ax4/xiExPzbbiH/SaqsFNwAuk0HfM+ZqDqXBohyeHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71360A380E
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E71360A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1702704f8f.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697721; x=1795302521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=j2x4AYJG6n6Db9GW977oMzXHN7UsiOwbhnKGYzeeISR1q9eapPvmbYFZYhSzsWSPuW
         p1CKAdFyMmXR+i3GSjxLKah+pfHWNHAS9AVTE4YwlG6Micg5x5ZVyN4gbg6Kp3PAKKZv
         RzkhOdlAZm/ViIGOuyuRIBKJtuqDkTeiNG3UOPwme14HPlkPi8XkATuf/Jg+Vp/9lui8
         As6cgonNIYPmg7jk291hVSLs53wjow5UAgAsiCtE0R3w9ZrzBQOfV2D3ODiru6nL92AI
         9+bfz8dH04ZlrE6UNSmasbmJTfoPeWfRVD89xFcz/X9xZc5CAtzZQIX+mGVLKmCGu6uJ
         qXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697721; x=1795302521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=oQZ3rW+kTle2UTti3iBrkqYO8VwDJLcS7cbH393O0Nr910h052wUNvmeSpfut1AdxS
         GRzK7kipTUEj6uz56M7By7GUYRYV0rra3qUHgKOFzqTqJKPwHLXSM8KiGRmn4yF/VtqI
         J7qm/xy8eYnGDQNm0SSLYFsV9YZcJQNnRCe6b7RWUCwGjpdKnjl3XDHEftDDK3CKsCOy
         gAS5XOWyJz4nbN16AF4S8rH5PHcnbwmZXMYtDRr7U9FvC99ERLaDvG40Gd3dkgurB1mM
         99mVST98Ee2kJ4OhahWnZslg5omSH7hKqaZ3RIYcoLy/vYqiFU/CMGZw+JDGbhSWOB2z
         NYOQ==
X-Forwarded-Encrypted: i=1; AL+hErEd3oGHxb8lLE2vicS0G0hqMuZ26VPcMVrhmq8ynYdsKFt18gTa2Jt0uGmktbbPGYkIcag33hgBMvJh2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HfexAOjbe72pm+bBoI9z2/Lkn5AGbWDcNJ5MkS6FuQJ51LwRk
	ErDS39zB+9PP2APcYoxM/nBKo4NolPWPSiuhysYKlAZGggqfaR/ZkQFb
X-Gm-Gg: AYBFou0P1Fjblz+m4Yo3ZgAf8/FdfHC6oZfDGr0CvZEW3mdw+8v+/gWRVpOSdiYcPd4
	HJYf3eNhsjZf2wFQngSZhHot4/zjNZgnMb9tyADxJ1lVCgix5N8N94yD/BWlAWDnnzgDimD06gD
	iMho5RYylLd/jm12wYd70/yd7wymXq82Jl46A1Ka2vt5s2c2vV58bHHjOyrfSh9tx0TOqL04RTZ
	dZ+6V+ojCfp61sbx9Mf/Fzz2erNcqKSrlLmAVPGjna0+IYmhuj1hqLuUhP+OzEboWJwZRGZYSWA
	XnGaub9DdIbINpbFg/q9HN5yVjVayD6vF6IbWO0YEHtxbuCTprEUrmXSJcTEJqKJYTYH1Sl7Ykf
	hEw3csH3V+hS6NsEK1EgepneJjrrfR9Y9GKvZ36tpmwHCei7v1ldEED/X7l95Fme6wz9+XcLw4+
	3MM2pXkUGQJdDPvnivsdDpyJThF/gh4zuO6BUDkiVoDdf91hU4JzOsl/j6QG3mWUOjCPEtGJBfe
	GOJ7M2CfEOwB+GfOCDKOuX026YT/HXz712NOoYd4wSFN85BkHvrvboB7BMQvwofxuf/kfrPjZhu
	DaIsmtQuUiu4gQVCDuOBD7uGVHAs
X-Received: by 2002:a05:6000:2586:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-49c72c9c8b4mr15192826f8f.50.1794697720582;
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v3 07/16] HID: ft260: uart: enable flow control
Date: Sun, 15 Nov 2026 01:07:51 +0200
Message-ID: <20261114230800.1344401-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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

The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
with a 64-byte max packet size, so the theoretical UART payload ceiling
is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
above 1M and small transfers can work there, but large transfers are not
reliable above 460800 baud without flow control.

Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.

Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
and with RTS/CTS (~2.9 MB transfers, no data corruption).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 270481766e2c..75ba68e2e8fc 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1903,8 +1903,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	if (termios->c_cflag & CRTSCTS)
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
+	else if (termios->c_iflag & (IXON | IXOFF))
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_XON_XOFF;
 	else
-		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
 
 	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
@@ -1912,9 +1916,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

