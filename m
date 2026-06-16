Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A813CF024
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586561; cv=none; b=t2Xm+L08YvKdd3561IKYoJ/2USb7gNll7A1yaESuIG/9eeD/QHrqXge73okJHL3dpKFC96tGLa/RPDJDBRtafzQWqOUwMMqZ3vn7Ykn/E+pv5Kd1HPJa29B7osm1tbxwgG0837HBaJrHcos/mvhYJ4D4C3wekiHT366uuHTwObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586561; c=relaxed/simple;
	bh=ns1eON/qPmN0pdVpitkgHUodlKuIFIzj3MLFEh75my4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwJV5w9c5T9xm8dQiZ2r5clsGZlkjvPVo0AZvSR9/dXSAvoNYJ9Vj4FZTa880m48WUPCyi/070C8bjy7gtPC+aCTMcNtkXecG6cx07Ka+05nWVNvZc/cIR3NkydohctXStH3GxOzK04jg8hYAwS2ecxp5FzVQon9GSyRvMylhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6YJjSkb; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6YJjSkb"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-306f36df4feso2845938eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586559; x=1782191359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQF6bGDQ/AYk6Ljcqp3PBzufLn3Y8Dsg3u8yX0a83cg=;
        b=Y6YJjSkbyhPDUTpQJ/qviNLfWCZkFcajDwdJIKX2NASW119uhO9HeeQ5GxAYX46A7U
         fL0s2rDfpuPCUvqLlKWe54rfKTQtcFbsaCA4ToEYWCNrCmnrqZj73i+t5LeiurgfWbI/
         7QnVlYZj/zPLetHR4LF8bSRbuLEjry2gwq4hTJMequRiNpw7QqB8jg4Wyu+KEVd9Jge+
         LuQFSq3ERTcMlmWbcKJ/N7Z6Gsib3DzjDrGoxW9Np0aXJK3IeNcKtkyaj3SKy4jn9k3y
         rFrHZhOigTvlxn7MS1DZgeS7DPbX9uXzBzARQjsQaQfAVQzjST3c8VW6sS8cCX6RSDWq
         H23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586559; x=1782191359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQF6bGDQ/AYk6Ljcqp3PBzufLn3Y8Dsg3u8yX0a83cg=;
        b=Y8iYiUPzQRPy7Z2yPdddvpyoCTfk9iSK8jbnZmHf+eSGdV/vs08v7/AMU9AMUeLnVE
         pvc45R9pdsjt7B3USUQBnKkQB5za9uPj0syETQpgyOtenaAhsjAs0a1CnTlwXsoYFLVX
         vEUIKrFUOt9xX2km2XnpJ3T9hUzm2Ff9lSwuaYCBpups/WVYPiYJOsxmKD6NVvYnSxa2
         qWqN88DoQ7RX3SMaeZHyL7L7+bXgRDx+r4Up5cESBGT3oO1FMzwsFUBwuwflnZBkjB71
         PcsAdGPcbEAPp+wYWVvth7xeepRh3ZcqI1Krx4Ljic0kQ3fxnQy0mBc74EvbeGF98KU0
         uUaA==
X-Gm-Message-State: AOJu0YyD5a3eMkm9IZCpIq9G1B4lEUYKh8L1k6oLY1FEqPoJjWgRQHB0
	xjvFLRVcdvDT6Vp0PCY4nusNFTo4FiiR8UX3sXXYiNdN6XPae0WPp4YQrceAQQ==
X-Gm-Gg: Acq92OHU4vsE9veXKznlQTAL0dPO5SWc7WwhafiGwBKTmjoUgcZKyuUUYwrsB4uACmJ
	TW/QXl8Uxu2h4f2Ncff8j76Nn0oPLwqMW9WkTqVG8UHsp3IuxtYBzRkFsb3gJl51XwQCTiYGjtA
	b9dN3Vyt5QhvA0VbV7XdgHpsOwT5Gv0voePAf2v2fVUEJ+5CZ6Yvwhe/CsAsMDtICJwPphWnINg
	x3v4xXZvo+yfr3MSzfa/KcHRomEgjPevtC/AbKx7UmswWC6DHNfexqdvT9H+V9G4Hy4vqkO1OgM
	JHSZBkysTM2dJZvsN2TyRwD1EQPs9tSQN4y7tJld8k394kDEAp97sto/ENBq+DYtr9+Oa9ul/h1
	K4l8YWhr86prYPNgWtOWmkYzMe54ZEa1SCIWIT57ZgiUn7uSu8MoGRexFYVGLIo26PTkbndeToc
	hgaIqJA+IFDxBoHBzcVlRI/+SNdiu5t6Z/sF1W/bQ51R5FZthdh9aN7mp+LJ4aTC31sPnCCauTj
	H+g8IeGMQFRZkw=
X-Received: by 2002:a05:7301:60c:b0:304:6822:2cb2 with SMTP id 5a478bee46e88-30ba33b8637mr1258435eec.11.1781586558807;
        Mon, 15 Jun 2026 22:09:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:18 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] Input: mms114 - use appropriate register argument types
Date: Mon, 15 Jun 2026 22:09:08 -0700
Message-ID: <20260616050912.1531241-3-dmitry.torokhov@gmail.com>
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

The MMS114 I2C touch controller uses 8-bit register addresses (0x01 to
0xF2) and 8-bit single-register data values. The helper functions
previously declared reg and val as 32-bit unsigned int, requiring
explicit bitwise masking (& 0xff) to narrow the values down to u8 before
populating the I2C transfer buffers.

Update reg and val parameters to u8 across mms114_read_reg(),
mms114_write_reg(), and __mms114_read_reg() to accurately reflect the
hardware specification and eliminate the redundant & 0xff masking.

Additionally, update the val buffer pointer in __mms114_read_reg() from
u8 * to void * to allow callers to pass data structures directly without
requiring explicit casting.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index db23b51f4630..c2e006ac1196 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -87,12 +87,12 @@ struct mms114_touch {
 	u8 reserved[2];
 } __packed;
 
-static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
-			     unsigned int len, u8 *val)
+static int __mms114_read_reg(struct mms114_data *data, u8 reg,
+			     unsigned int len, void *val)
 {
 	struct i2c_client *client = data->client;
 	struct i2c_msg xfer[2];
-	u8 buf = reg & 0xff;
+	u8 buf = reg;
 	int error;
 
 	if (reg <= MMS114_MODE_CONTROL && reg + len > MMS114_MODE_CONTROL)
@@ -121,7 +121,7 @@ static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
 	return 0;
 }
 
-static int mms114_read_reg(struct mms114_data *data, unsigned int reg)
+static int mms114_read_reg(struct mms114_data *data, u8 reg)
 {
 	u8 val;
 	int error;
@@ -133,15 +133,14 @@ static int mms114_read_reg(struct mms114_data *data, unsigned int reg)
 	return error < 0 ? error : val;
 }
 
-static int mms114_write_reg(struct mms114_data *data, unsigned int reg,
-			    unsigned int val)
+static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
 {
 	struct i2c_client *client = data->client;
 	u8 buf[2];
 	int error;
 
-	buf[0] = reg & 0xff;
-	buf[1] = val & 0xff;
+	buf[0] = reg;
+	buf[1] = val;
 
 	error = i2c_master_send(client, buf, 2);
 	if (error != 2) {
@@ -242,9 +241,8 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 
 	touch_size = packet_size / event_size;
 
-	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
-			(u8 *)touch);
-	if (error < 0)
+	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size, touch);
+	if (error)
 		goto out;
 
 	for (index = 0; index < touch_size; index++) {
-- 
2.54.0.1136.gdb2ca164c4-goog

