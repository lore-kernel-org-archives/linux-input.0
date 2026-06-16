Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD83CE4B5
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586563; cv=none; b=f51lFiCjpTE0Gy+XzHVVprgM0Kjmquy+iZrb2+5ZaI2Df0meyCk4hie9obzZOoh7nOQzVgUSAOCU/fdyJu06UDmCtOA60YtnQcwPHIxw5KHfPUSXWaOaNkYzuCIUCZUCVEFnOPeSGCAyn8Uo6nte0SjYaXBPNKLbB/4E8pjh8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586563; c=relaxed/simple;
	bh=GK1wI3225NMgDBnEbowYiQwyqWCPx8A8P1f0dLfreGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFd5wbtrZzXTzR5sbm6l0omfnbjWulaR/fkCpqA2w/H3PZ/RVRYmnfMEu24eElgX98B9JTOCp1ni7gqomZyfS3pak8SrasxmVhqZy0aGyl6UcXxGtrPKs1sKkRl+TdjvBkx7k25hbk463dSxDjbs1+7N+jF7sRxzWlI4QURslrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVo3FZbc; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVo3FZbc"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30759632453so6205097eec.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586560; x=1782191360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OxpBqSdgh4p6bWdT2Yy06CYj/kPqc8D4aKFBYfJucc=;
        b=XVo3FZbcpjyZz1ihkqkOg5mFkTZ1LJ1hBgP7H1xm+IKMaSG76/T/Ia1JfykPP21Fbn
         Boz/s6r/0+4rI0YPZ1pEK5TtTQVvYZePkmMG3WQN7WyPWew44XfS56c+w+oBVCBIm3XU
         d3H/TTp1BmqCBsQC6C9qkPh46hCf2G8rrAv3ZT3rD/WfHDvi1riiAcJp+TlaQ1DL7/M+
         4thDlE5xFzc+mBnUJu5ML0htH/zxFnGYhPjUJLElUVgEB6MeJIkULZF4ffzNEaihdVtk
         b20mFbZeD2Vvi1r+AL0K7fjcSKvrKmVyiMBPNiLtLgUSB5IQKroF9s0LizfIHT3wGKHa
         iAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586560; x=1782191360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OxpBqSdgh4p6bWdT2Yy06CYj/kPqc8D4aKFBYfJucc=;
        b=MkIDFGST8ZGkIcwau8LirBOVpTHHKpQLrYR1T976xCFkzbLrqtDEGCJytvyEJWY8Nj
         fuexL6HgqcxwZstlKSCaqcXCyaLWFYZwUugrM0qM+jYZxOWZUwxbH9/3K+VgVtomfehi
         eqUgbSLLhXXV7UI4czy/4GM/V+MRZH3WQBPM8VaHv8kB89ySNQyvab95JAXxh/WuPgW1
         V79Pwb8SLN7X2pQKtEwmJ+GFAcIoa2Sgv2pf279ciGLOpBOIPleH2tEdOM53HSdwz7Pp
         6Gq5GyV4NnzhsjAYjLSllHwwRBE3ljmBOzk9zITX1WzPc2Ssy/ee9a/fGcwGjBA6zFr+
         U8Lw==
X-Gm-Message-State: AOJu0YwB/3s/qZStoObu5tcSV5YLxMUdk1YpTlX699c8Q6SPZwMWjGWb
	H+0YxgbLDLFcwRI7sLt0l84KV9IEwUvQSIX1D1+8nzkhs0m0ApNFAFG3RsdKdg==
X-Gm-Gg: Acq92OG2bl8TDF5vcuMtt0RMx20MBg9O51jHLtbLsEpQSdu/2Gzuuz0wcaw7Fbq/5Xw
	+9/O/+b4nroih0XcCHe3IE7Hcvs5h/Jm2UkcXAmkjRVJpmkC6rX5Ao1EQUwMpKD2JuQ3IxqDRSc
	74sip0XoBJj3YGQ/0o4P+lGRbSXCPLebLlnsGMkjXpor7IOed1/trML40Ijr2Hib33E+sxHP7Lq
	9dLSDkMSR9cabIvuhcBpvTAI3UigIabao9JsdPYjYxeJ8KQH5bo6MwnqpkNZ+vcXuth+Plw9wov
	pS1FxbUBktWtli170+m4LgxpCGcupDr/DJXx24cbgt7fn6pa/ZZ6WnjBR3EoeYK2CzIxfw47y7C
	SJDJHKOpaZ7NdYUiZKQ6IzzQ8ei3G7OHG8n0m6ruj3IZioVGHCHdE7dRRmBjVXrFfa+UQlQR5up
	6vWJi7yC6zsvB1gw8oS8UdWT41A/gzV4xpZB4d48x8ecH0fkZdtR/MXTP3hmPr87QR0mymJcLQH
	Q0zhoUw+g7XxJc=
X-Received: by 2002:a05:7300:2148:b0:2f5:5dd3:1fcf with SMTP id 5a478bee46e88-3081ff97b78mr11427671eec.10.1781586560112;
        Mon, 15 Jun 2026 22:09:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] Input: mms114 - replace udelay with usleep_range
Date: Mon, 15 Jun 2026 22:09:09 -0700
Message-ID: <20260616050912.1531241-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses udelay(MMS114_I2C_DELAY) (50us) to ensure a
mandatory delay between I2C transfers in __mms114_read_reg() and
mms114_write_reg().

Both functions invoke underlying I2C core operations (i2c_transfer,
i2c_master_send) which acquire mutexes and sleep. Furthermore, the
interrupt handler mms114_interrupt() is registered as a threaded IRQ
handler. Since the entire execution path is fully sleepable,
busy-waiting with udelay() for 50us unnecessarily wastes CPU cycles.

Replace udelay() with usleep_range() to allow the CPU to enter low-power
states or execute other tasks during the delay.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index c2e006ac1196..c59aec8f2feb 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -116,7 +116,7 @@ static int __mms114_read_reg(struct mms114_data *data, u8 reg,
 			"%s: i2c transfer failed (%d)\n", __func__, error);
 		return error < 0 ? error : -EIO;
 	}
-	udelay(MMS114_I2C_DELAY);
+	usleep_range(MMS114_I2C_DELAY, MMS114_I2C_DELAY + 50);
 
 	return 0;
 }
@@ -148,7 +148,7 @@ static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
 			"%s: i2c send failed (%d)\n", __func__, error);
 		return error < 0 ? error : -EIO;
 	}
-	udelay(MMS114_I2C_DELAY);
+	usleep_range(MMS114_I2C_DELAY, MMS114_I2C_DELAY + 50);
 
 	if (reg == MMS114_MODE_CONTROL)
 		data->cache_mode_control = val;
-- 
2.54.0.1136.gdb2ca164c4-goog

