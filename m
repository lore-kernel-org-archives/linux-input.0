Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945919;
	b=YSXCq380aK+PYXnAeDrDZA/kutu6FFrigUXoubzL88Ai5vDr+n/HXx81ae/3o04V2BDZ
	 hXHB2fST/5jobgTs83d8+dkdxh71ZQMwt6s0PmIRImL+cxMDN+ksMlMu8dEZ6J+Ds3/C5
	 lqm8Ujjauc9aAh2bardl0S/OjJP68qcGFKZC8NclcHYpf50gi8Q9w+kK+NiHrew4o12vk
	 6hH3h3H7yipEYEKr6SmFVmvidMHPd0j4vFOcOJ1RVFibCCY5aHdlPHG7sixhJRlDilofH
	 vb/LJWuSaHf7VWOhp/hzNB6D03UevXHPbpGbd9pMLfTX6mSPU1RNMOf6MjELkCcAgiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
	b=J6i9QUvXzBPMWz5vSB6h0y/yMlfnp4Y+oDvtb9S130VJ61mTdhUPwmMjtccngTYVqs+4
	 aUhj/OYg9X2ManSOxkcBv4jSqni0z3oSG0NiDkK4MpD2MxKfm4x/6WG3g4LGXyTQkfwql
	 ziSZdYgRPsQbvhhNDaJU/oztbytJ28WwHeGg6743YSZYmS0LzQi0r2mpgTU6idUVBtubP
	 yI1KmzCfjVZgtnTNWlBDj7ByWg3DFUHzxz2Kc4rmGmOPUzdiMB/DLGco0MznJhpruEmuz
	 52Hd3eftVnydoufdXioeFDfeJv9gqbhfHSgFWjhjrglU+5YzGfqKtNYzgS/GrhFQasg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC89606BDD1
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC89606BDD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-497614c95f0so90827f8f.1
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945917; x=1795550717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=MhjW25tIfRYDFt6msKWXKEZvsJV6FE5BXzi3zLiQABXwwGUAb5mjJJggmlAam4lj3b
         vhPPsArgE4/SYAa+JMmZDpvUr0om/K7XKG8DCsfpZyelmr+S485w1DRAzID/YEqZb3EY
         X7wb4bvJ2dFOfgMqvjavHoFFFYpW0wmrtm02fCdi8AOWM98wqAdRKgVgQLdTzJDL9H/O
         z/H3LFCPflALGVzOGNyE1TDhtcN0oOX/qVni+8nM3ne1xcUh3JxY1QDDMoWLAH6eHpIy
         mDCS2tIKmDeeGidOh7Nb10Y3iVTXYhq2Yg5yb1m4ZCuxEWn22XO8ELQS1Undomc/aKEh
         DOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945917; x=1795550717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=t2zNf4pGlNPbWyttZznKiyVTBH8r4y+gVNJA74eikX1sZvVzt63utaC0JKfDnIhJ34
         nrv3ERGOBiFsvLLz/I3EZLwwVsPf7wTJvNmsX7hG90PXQ4FwzsuFX8sZNpfEWTnUVKWQ
         XitE0GDpf35F9pJNt657qqaetiUUuGY9pJxEopyvYeNEYEXbJpkOQ/hd7zGIHSry4go2
         wjerf3eWzY8Xgf4RAKmHzGBubfE9r2SxDhPm5khj/InjARQkJ9BPg0qNw+vlfIIowwHZ
         fkr02gdrFS9Zr/JmMLSqfGS7cBSzW3IMQpX8nssmGV+3TG2+SX3mrDRyMfD/7K88o94D
         fisg==
X-Forwarded-Encrypted: i=1; AL+hErE8uvLI9vfdplY909tGkd8fCbEj73pdoR2RS00nwja/yieT6wSiU7GM6x3UOjtR0LEd8BZ3Ek1XfiJAqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/buQtKGzs7pvmOlznanG9qz/zFctCVJBI4ch2vJCvNGw+78ydW
	bUAvvTp63dtAzWNV9zYMJoa+U9fdSrAVTQSexVGAujCCobDuOCvAj89/
X-Gm-Gg: AZFdTZcUm2PEkqltMG0J2n0iphGfZtVSTK25fofnIvSWZ2OajFi5QQZV/rmZxvvi6ar
	sqznYTJRG5Z8eyo1/HIsqI39ZNkAzSAFsfVFMPq47qOlr+v8osyD3x+uNz01anzTebWrTVYU5qq
	YmyTh1/99JnRu3ntBlA8GBHIROo5K/vQylBOvRktSIKojrrKrcyiuP/f7sJX885YCyDEioecjj7
	gg5oLwkAKcWwRsdiYE4MTZzkaMiZ7DpR5nfoF/tl6aWjdS4wE+KiuGY6YyWv7qfaVUeV2c+rmWu
	hZgPYR5POKTdvXgz2yj+2jViGe/XSECXExIdyerIcGXPbpJSt5UlBY4AksnOrUIRcEsx4i8aYOV
	w40EBFxPU/tZBj21JW4ARIY6Do9PGut2HIOeXhDSvU0vS03SCNQxVeFbChFlMcswLHjsshOMhFw
	6jXYLqY8ewhFmk0zIXUkGnU8qRzEi+tfDyQT8HFTjgkD1npAfLB9Oz8ss0leSZh8fuGc0fd7w7E
	ST5ZHc24sfedErvWbeCUAiqVf4mxajBNV1zyL2b8BKu75Ng055E0x3e/pEuCKSJTfukcCeiPD6+
	qGgS1ABOkEbAGDN7yZX65oUKNYxo
X-Received: by 2002:adf:e002:0:20b0:4a1:a2ed:bc1d with SMTP id ffacd0b85a97d-4a63b6fbe61mr885459f8f.43.1794945917177;
        Tue, 17 Nov 2026 12:05:17 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:16 -0800 (PST)
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
Subject: [PATCH v4 07/16] HID: ft260: uart: enable flow control
Date: Tue, 17 Nov 2026 22:04:13 +0200
Message-ID: <20261117200423.19561-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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
index f722ef0ddf06..21789e97fd18 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1945,8 +1945,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1954,9 +1958,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
 		hid_err(hdev, "failed to change termios: %d\n", ret);
-- 
2.43.0

