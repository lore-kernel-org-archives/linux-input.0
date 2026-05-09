Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C53A1C9
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319973; cv=none; b=kM3S0Abb/tYEI2+KFbCcYa4Vzqa1w+lWET2bZesGqKfN/69HIT+08z5Kn2mOUQycoc92Ilgo7rUlA8w55/mAibIgW+bpyk2/i6zFgRU8ygYY+KVQlBwiEumsmLq1PtayOSHB4h8iliD/jgd6oS80ocw8D7Zqe/bBl8rVwYYrtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319973; c=relaxed/simple;
	bh=6hSvrC6JqtJ3Ll+ikYPnEBdS7T/Rm4O1cnmAAUY5IGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipWCFmnw2wNTsZ10GVnDITnJFeMVJ6eWe9lrymEJKYBcfsUQl5TVuJyFu9fEP7eLcDMDkmr9J8SSG4cA1jXL0Wo4edOVfb6QE3YPfIB+fYGEopjVH244YmssKBaloB/A2Gonl16hsXU2CkZhCgmX9JeF6tSwtSIc4duvXpnT6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+FuX61f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+FuX61f"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so27907495e9.0
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778319970; x=1778924770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7U/T5gN+6tbPfvjxQ18soHxdaMsEpG40WbKeR8e5d4=;
        b=h+FuX61fPQHt0vJlFlHoj9721+CKDqKOPvCSDgwm5GhtigYjQ/tphPAeIQbM0tCcj7
         rYPD1unMBX82/TPlEzKrxb9IjjGaSXejSEIk175fA3Hi+38CEVK+LIqLMFLFBlEIWXiB
         xtlp3veZ+rbjJg0UsLspwnLoalvxb1PToxAFFaqshdwFBz9JGaRHS3TNEpRBpd2WZ+Zi
         GMcFRrdZq/Gw7F2+xTMX/1A1xv7HP89y6cefCy4kEumi8blGgLtuSa6sTQ1Cv1HKyE6y
         WnY/1IYj9g2z9tWcGsYuuVS//wio47fYeFowdup4crSSntNLikrB2gwNo+8MY4u3eRw2
         4Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778319970; x=1778924770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7U/T5gN+6tbPfvjxQ18soHxdaMsEpG40WbKeR8e5d4=;
        b=IG9FPT7t9HBRbegk+uxWiFpLY64qAxq7yn/vR+Exfl+cwFR5JWT0VUEjyTWrp0W7L4
         XwIFH2Un2IJRoLBQYeI/lDQK3ZarLGPzhR8uh6nISDaSrOjISj0ff0MNOKdGHaqqU0Ce
         GCwZ1SWls9z2nklv1f8O1iab7eRz3ME7maM+ZILtto4eYENQ4JWP7wr43kCHB9oK4BrR
         LY/Z3RlcMxElxWwxNKTtMDMnQrRmUihCuoaPvecwehO69urHRVVBtqoZkkR/xPFkErp/
         SFU6FHWX27k6roAQM3hU9XLGdamWzHoHWqNYgexFGPp+uW+ULZmX7+L7qEbuE/NpsDVy
         Gp9g==
X-Forwarded-Encrypted: i=1; AFNElJ93m9/cAfjslY7pXDrT5Dw5hgVF9mw5b2xvb3Q5b4nCRTTiiITb4FNPKKyoreQn3T9QSPXKd2bDNu0Vvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8abQIRbLMEUWEkRd+fcjZgQ3hdHUdtoRs89qBcC1RJwuMZZR0
	tHFxmH0SPCyUESqzCSouSOCuP3+uVIPce93QUfsuiMBPH7sHyTj5euSc
X-Gm-Gg: Acq92OEndNexZDJgtYyz/dBDbiy6DLXHCUxpX0ym0dmRoH/KnkIUdo2uP8Y4+CdK6az
	cerl0wvo4rA8nFQgn3MFdwCkmbRt+zI8kH9ED+qUtRfapmlCxRXHfF12AXKVSdmI5z2UryqLuXW
	+F0HuLBif4buuG1GAVfwUtGoqRRBdGZgWZ3MgbOhVVhxZlTRYmHDlZl1uCOb8yY/lXyXawI2iAJ
	8cn7knFsqGYusAu1lKefgiFdqurt/8PY3SquvpAxTwY+ECGVNwZ2ITFpUGoaYlDyeItFIsUD7wH
	IRn7sZDJrS1mOI3b157n7tYFwa0jV9k9FgIibO8xTSq2TrEVCzFEgcBF0gGFksBko78eLGOW9bA
	ByGMDxyutR4Tn8/gUDEOe+agkTvjNe9VxAL3zLLvIz7g98EYJsHH1B+iB569JDzIVW6JUFFcoWI
	KiJsIf9z61AA==
X-Received: by 2002:a05:600c:2219:b0:48a:5ee0:7781 with SMTP id 5b1f17b1804b1-48e5e007218mr123817685e9.16.1778319969794;
        Sat, 09 May 2026 02:46:09 -0700 (PDT)
Received: from ns3242901.. ([2001:41d0:a04:2e00::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm11224669f8f.30.2026.05.09.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:46:09 -0700 (PDT)
From: Florian Pradines <florian.pradines@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Florian Pradines <florian.pradines@gmail.com>
Subject: [PATCH] HID: mcp2221: fix OOB write in mcp2221_raw_event()
Date: Sat,  9 May 2026 09:45:17 +0000
Message-ID: <20260509094517.2691246-1-florian.pradines@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_raw_event() copies device-supplied data into mcp->rxbuf at
offset rxbuf_idx without checking that the copy fits within the
destination buffer. A device responding with up to 60 bytes to a
small I2C/SMBus read can overflow the buffer.

Add a rxbuf_size field to struct mcp2221, set it alongside rxbuf in
mcp_i2c_smbus_read(), and check rxbuf_idx + data[3] <= rxbuf_size
before the memcpy.

Signed-off-by: Florian Pradines <florian.pradines@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index be80970ab48e..e4ddd8e9293b 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -128,6 +128,7 @@ struct mcp2221 {
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
+	int rxbuf_size;
 	int status;
 	u8 cur_i2c_clk_div;
 	struct gpio_chip *gc;
@@ -330,12 +331,14 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		mcp->txbuf[3] = (u8)(msg->addr << 1);
 		total_len = msg->len;
 		mcp->rxbuf = msg->buf;
+		mcp->rxbuf_size = msg->len;
 	} else {
 		mcp->txbuf[1] = smbus_len;
 		mcp->txbuf[2] = 0;
 		mcp->txbuf[3] = (u8)(smbus_addr << 1);
 		total_len = smbus_len;
 		mcp->rxbuf = smbus_buf;
+		mcp->rxbuf_size = smbus_len;
 	}
 
 	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 4);
@@ -919,6 +922,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 					mcp->status = -EINVAL;
 					break;
 				}
+				if (mcp->rxbuf_idx + data[3] > mcp->rxbuf_size) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-- 
2.47.3

