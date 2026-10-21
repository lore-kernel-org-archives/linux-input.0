Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611022;
	b=RiBWit4t/wFFawPGRlQiu1+Z2cWLjoGdVI8pa5WXyoBaWgnQONPX2jgjM1/Y3ER1oK/E
	 aK5YVmZHW+3jvRMWleR0fgMGNJ8NQ0pH0kp/8CLfAj4y17zXMSjy+cISg+/nF3GQtMtrM
	 w5XQ5DNrOx76ID49F7Tic/Yx501b1rTpzjq2njUPfJvtw8FATOMHJR8w7H/gt+mKeeQUF
	 kSWjyGIumYNqvxbwSoD0y/lN1sps25WJ73c1lxTqafBL4KzWTOeVoRpJCfE7wMmkX3wao
	 qu6kNVl2VrDXpOWfgDHZ3BKhED327MRKI1j/JnPOZURcPf5OpKoDqERRYIAmHv4MPug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FVem4HDPdj0ylTWviCW9/5t/RL/Ax9AlEndJECBbr54=;
	b=3lgy1LCGBzVsyVfIuqDnwABDMk0PmLepxp3hRXIa8uYhLXJaD57ZuTVoASmJskZb0Lpb
	 sBiyVEl2QCHfNGsCj6sX9uwT6rEu9hrwsUgbsd90OU9ZYcNmXl22+mIegPWzJJbbE6kIw
	 yProLCHE/DkEvImWm0PTYaxSStaQWdIeDgWJ36/w4SiZj3uZGwVSCXZGpbQjf+YdiTzUe
	 wf3vLo9d2GrXuOtgp8Hmg5+PRY2Wf03gVYZTiILZ4u/kbloa7TPz9YyatJbcDVsoQrCMc
	 8KPnXevmn52oFgIPex/gAuikDG6cKPluQaMZown5mB1jTxbgPVnvmynWfkDpojl1rqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebe0LduK;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99702606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 19:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99702606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebe0LduK
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99075306daaso589220241.3
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792611020; x=1793215820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVem4HDPdj0ylTWviCW9/5t/RL/Ax9AlEndJECBbr54=;
        b=ebe0LduKx5Zxrv4TLRZSOx7scv/d1CtMFA5nivOaBt7J8XXZcGqpOzT/z7Ix+bMIiR
         aHfYde+pkHxPrPXk3eV5LM1fzf3w8XcfRME5DkrFbB6Q1NeooM5TBdAB0GQNFv5cacoe
         jTT7PIxjsYi7Ox++xCQpoaX8z8M30QvVxkIje8yPwBnxdFl7gLkfUgUNSc578ceEtgUs
         17mfRuf0sz5o5q+kbZl9eidhP4HKLZFtEHLU8yb+3Y378mbxUE4PoZ/K40jj4PP8i9gh
         STxKDvHh/DZMZ005TX0g+wiTGX+MuL2K3XMC8UFwcTsUDqrLM9R26ar+IFHB5t9NNh0H
         RCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611020; x=1793215820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVem4HDPdj0ylTWviCW9/5t/RL/Ax9AlEndJECBbr54=;
        b=2oshiQUn8/TGoAkpDhT5p4ItD+ZH++ouHA2u+qtGi85DbYK+xlrHhZfLfYXK5VZF20
         t2QAitJB3PR1uiyLPPDbAuWOt9YYIeCBOqtbLgz64Ey0Ho5K/0mxl/4nBeRoPxbbt2JT
         TsVGT5nRgonxRax8GWHUJ9+lBpzqx72lXkkM6wqSdffqJGpHJ59WikxIp/CwNkz9so3i
         q7kkWnyv11/E+GP3YbTrQZ5QMIXrfHzUVpXu4dflhXayKX4sFcZDFcp45PmjnqrN96g/
         oowJs1egON/cCFfI+LHkXVNPPwhBy1kemqXzn44TySK3WNQjg3Mg1+qiFO7h+fP51mAT
         s4Bg==
X-Gm-Message-State: AFq9FYIXQ/+irVZ05u7YYMzV8zCfSadq9/Ivi3KWVdaz03XTMMzoyWTM
	dh2GHFxeEIdACg7qIIsZaxREXB9RjLW7hIEN/WfSK+6FT9No4+MUifaQ
X-Gm-Gg: AYBFou0zLi+xs4SAHsNBDc/5BQlu/O31Z26v7pzktJ1jpT2XckenxoUCiZq4k4noARY
	xGrXLIAaLJ9oT+BfY0xeaJ3TP4+s44vR7yPpOGbc/sdtvATCYNUN1n1uS9f2Xy2dVBuhO+zeMS/
	i8FVoA9mE6graDSimyVwBNLt2/tndQYv8KtfidCgrlxraEJlqtWeOkQ1uefRESOgVGMRllqQko9
	LILQw5QcUp87vPx5g6qlIQFOd+X2XO+KMSDbOvHEuRdJPdAs3zJcVGaV6XJWUzj4q58NQxHQOJZ
	Yu2VjYxuSpBPPzHYgJNPZVOmTMsSDlG0DgPrGGqnmpiA2QxvQsrHs1eIxLVJb2N7P/j/03T/sAL
	gmfNVXEaCgpWKBxoKhKTA/DOfDglmdyjv9OC1P7vGldNqZsugV928uGWDo14JmTTx0wrlhrBvFh
	hShnBfCaI+4Gb78Z0zfkZreKyn90iebL71nv7VUrkBDm0EL/oo7R8bwFtzJh2lbD4HF3Phgzp/m
	+GOjVII4WRPbZARpfYIjLMqD7+Abe1LQDn0lL2SDPbF5ocHQJCoxGUw4EiHkcexkTeU6hfLot7I
	frfyucOsz6sUUsCZUJyc+G1Uunx5O5rCNxM/YL2x4bHJ6DL1093qOiPsX6Vet0MnxB1ZLhk6kzq
	lKSaKsZREZEeZXtVq/ZlhGQD7bg+boGOUldgbgWJdMR5uRBWq9oTPMGQxRBs=
X-Received: by 2002:a05:6102:f81:b0:7cc:80ba:5e5c with SMTP id ada2fe7eead31-7cc926283abmr1384658137.6.1792611020525;
        Wed, 21 Oct 2026 12:30:20 -0700 (PDT)
Received: from bruno.localdomain ([168.194.106.37])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d11db523sm4136093241.11.2026.10.21.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 12:30:20 -0700 (PDT)
From: Edson Bruno <cloudflare.ddos21@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eballetbo@kernel.org,
	sebastian.reichel@collabora.com,
	Edson Bruno <cloudflare.ddos21@gmail.com>
Subject: [PATCH] Input: exc3000 - zero-initialize vendor response buffers
Date: Wed, 21 Oct 2026 16:28:02 -0300
Message-ID: <20261021192803.776-1-cloudflare.ddos21@gmail.com>
X-Mailer: git-send-email 2.53.0
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

exc3000_vendor_data_request() copies up to EXC3000_LEN_FRAME - 1 bytes
of device-supplied data into the caller's buffer and returns the length
reported by the device. The callers (the fw_version, model and type
sysfs attributes, and probe) pass uninitialized stack buffers and do
not check that length.

If the device returns a short reply, fw_version_show() tests and prints
response[2] and response[3] uninitialized. If the reply is not NUL
terminated, the "%s" conversions read past the copied data into
uninitialized stack, which is then exposed via the world-readable
sysfs attributes.

Zero-initialize the buffers. At most EXC3000_LEN_FRAME - 1 bytes are
ever copied, so the last byte stays zero and the strings are always
terminated.

The problem was found while reviewing the driver with an LLM assistant,
which also helped draft this changelog.

Fixes: d862a3068ea5 ("Input: exc3000 - add support to query model and fw_version")
Assisted-by: Claude:claude-sonnet-5-5
Signed-off-by: Edson Bruno <cloudflare.ddos21@gmail.com>
---
 drivers/input/touchscreen/exc3000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 037bb35238a3..40d74f6deeb8 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -262,7 +262,7 @@ static ssize_t fw_version_show(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct exc3000_data *data = i2c_get_clientdata(client);
-	u8 response[EXC3000_LEN_FRAME];
+	u8 response[EXC3000_LEN_FRAME] = {};
 	int ret;
 
 	/* query bootloader info */
@@ -292,7 +292,7 @@ static ssize_t model_show(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct exc3000_data *data = i2c_get_clientdata(client);
-	u8 response[EXC3000_LEN_FRAME];
+	u8 response[EXC3000_LEN_FRAME] = {};
 	int ret;
 
 	ret = exc3000_vendor_data_request(data, (u8[]){'E'}, 1, response, 1);
@@ -308,7 +308,7 @@ static ssize_t type_show(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct exc3000_data *data = i2c_get_clientdata(client);
-	u8 response[EXC3000_LEN_FRAME];
+	u8 response[EXC3000_LEN_FRAME] = {};
 	int ret;
 
 	ret = exc3000_vendor_data_request(data, (u8[]){'F'}, 1, response, 1);
@@ -410,7 +410,7 @@ static int exc3000_probe(struct i2c_client *client)
 	 * or two touch events anyways).
 	 */
 	for (retry = 0; retry < 3; retry++) {
-		u8 response[EXC3000_LEN_FRAME];
+		u8 response[EXC3000_LEN_FRAME] = {};
 
 		error = exc3000_vendor_data_request(data, (u8[]){'E'}, 1,
 						    response, 1);
-- 
2.53.0

