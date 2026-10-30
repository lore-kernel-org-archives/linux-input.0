Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399844;
	b=TXOoaqL5J+qh8laafuUFNX7xbLSPt0NFLCDuvOKIDqJxENS9mDUDdUnY8pU23qDBNXT1
	 gbLjRThzbuUqzyFMuXwqX81ixjzpOYFBJtlkN+i0yOYdS5SuTdMTSRp6X2NofumggqBdo
	 bXV5qG0N1jBTtQ23LtsixkTdArGguBcuyV2GT10xmP6xNiQFT8axWKttadKoQRvYZgWbT
	 Zq70DOI4sWf2ZOZgjF6Wb9QEEiF2b1V2Re2Gp/aaGMDqb+KLzgOjrn6aWpBUzIc1Rztb9
	 i/BuEw6sbzYgukHeAIgpmDIeDT/emzDgO8PPbKRhygDS16Fu3HnOapri3965F5hYijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
	b=QwyuqIuNWGL0YZAWoklikxq0IBGBbfKGdx6sS8KkLMBsn9f1GI8MloFEG3vnfiY+TNn8
	 cDqSMB5MgdpKG+t7EP0IIJa9pXJsaInMnFq6rl/yDWPXDBtywjvsLW/5qSno6a496mLgi
	 PmAay7J/+1saWs6rcKUR3sdR6Y99JwOYn6FjTAeOeW1zTB//PLea8LMkRyKMn5ZNn0Trs
	 E2R/ls5TufXXSHljSENQecKOE9DAbp9uuBDAhJTcffhDowLRrmv5cUidHwSYXwuw5Lmfq
	 zUT6mQcyxGFAcQDOzdA2uqoWYluAdxideZPInV2j8Zi9z7h8+fQNBQWFBGisWNBLodw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B1606A326
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8598805e9.1
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399832; x=1794004632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=OYiSZd5e/v9Qof0ZiLjCYYymHax/1QU48N2uX9dn4m1M4qccuhF1G7wPnKY4H9k4q5
         PtpzB3sAcrowhyCGu5SnRwnulcJ7mN5TYRubKPzHnWxekRYqBKKcn6vcPvG58wvpXJFT
         /5Dy7btFOddSdWxm31iuemYh/f+k0YgEHMlL9VebsDp0vzJl0OgB7BPRP+6RfiNU6nBI
         yjiLDMgcpLVx3nD6nstKc/BKRdRWRjaTXUJjTgQVhyQm01+g6C9edPm9evr2s2YlQpWr
         HUk0Y7meX1O0+a7b+k7Y2aSF/JhI48htx6On+lmTbAlfeFl1JuUNy7WdfgUMCJQneyHe
         cvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399832; x=1794004632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=TUt814NW6jdHd5nXJGU5PMCdtZdfS8x+5/mLq2411JY7M5CNuun1Mf+viaE6719jGm
         Q5OKOhpOlVs8YbxVTC5xfQi/ZkYSmz/DDYeLL5AAzlfKjdlf+RQZwYiJXcl2VrzRgVNX
         42lIuhJvmAYfbNSHBEZXUQKMEn1MTv7voQ5qzui3oRVC+lzCZm6kj901Zp9GRvyC3MWO
         m+dTYwwC4zmzsAZ7Muc5HPPiNPp3YUy0+JxYSO3mhxvp597RaW9J18DiFL6+3ZLiHkKK
         Gx1BpyxWzy5a2GK2mMFjLrvF2RuF4zj4X7lU1b1XZoqKjXQzovWxZw5baqNA8+Rz4bsE
         C+Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwqjj46KwUjEvy/ucbG9PYZUU3ZvhqjSCuLDw9TfEgCtUpKEblqdnM8ZPrEUS6kMhIuP6mgXivohg2GZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIE9ev++H2va5miHfDbTewfifNBJ18zmiu9DO7M92Bz4cDBYNJ5
	ECzfTHjyfl2A0War4WHtsc9NMKlM8vNAhfepdl0fytdl7S1eJXsc3JrA
X-Gm-Gg: AYBFou0C1/dakeIEteOPujeV12S09YRUIYPdJngHC1mUd3dWpQQqrLJLvQmEG4iCU+p
	QzRw9u4yIlljk5eei6n5OsfI+opIgYBmuD5NSR0hgX05wIf8UeCQh7bsk3QGvkcX+dgT5T4ohi+
	iJsqKs2Hb4FLX4geLompwd110g24Gg9kjMrHgx81T1fmGtlWbOtLvid+Tivrudf9wKpgVRfAiVy
	R4ms/Nqmf21Ir4g773F+/RvE9Q/QrPVWH7VCBnMK3xyxydiPbJzo7TKQU1okP4AxjbUJedIIbbh
	xieWZD39mmzOEK4iO9NtPui8WsgqWFHAn1ic6cABh7fepRs060EinNA5sCBVqKt+WHrGtu5fY7+
	muipBg7dtEwFj1q/0jaSTUAsze2YXhpCIBqQk29LOAh7fBzkKHp5s+SycinYftlYNzZ/6lhDQOh
	QYXSdTk9Ve+oBsktzEeSqP2ncH5w6Eyuw6OwVRIWcVFD261TXJYFWVl9EwbV/9AKUwRFzMumd2/
	hyCSF4q1Vlr2FfnkCg82sykiLbZBfB+CQsgp99hYlcieXS5YgQOdtj+2QwYW1FK59ABfV8L9dbE
	AfMArvVLUJaVAEF7lXtCq1ps/31B
X-Received: by 2002:a05:600c:3554:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4ac18c7461emr88275265e9.35.1793399832545;
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
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
Subject: [PATCH v2 07/15] HID: ft260: uart: enable flow control
Date: Sat, 31 Oct 2026 00:36:29 +0200
Message-ID: <20261030223637.86907-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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
index 6f8d72938702..4b0b55c98f90 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1897,8 +1897,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1906,9 +1910,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

