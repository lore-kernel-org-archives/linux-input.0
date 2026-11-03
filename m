Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711506;
	b=BWWxEm3nDEOgtvKIwfxt8Ovg8+a2vEKaNiNCR4agauCpXOom0pUeOHuD8cxqyv8kb8WI
	 4JNVWnJ4Ewh8QwRm+B241RchsaIYZFeIdwrfxUHlvseHKoFawD8+alS4+paNddGfNiN/r
	 MxBC8B49fHDvZKbuUDnWGa8U1ngS4duFnq9WrbSwORgR+RMwpbSPmkE+Ujk4p2II38Kdq
	 veYOuiQdGmUcHCkhd7O89bxWC07R704CS2tgW2Y3lWdQ0xJWY5pDVaMMsj/gqanBr4Tfj
	 BJbfZ1DHFizWk9/OKxrF02TiZQd+A3A3mImRYshHvgBiQ0zylgPwu9cllLWsjQE82lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
	b=mN65x17Hai7E8obi4vmR+PXEhUzRETT3cGlr59ViPj22SGHwZXz+kkPcibeArD7vRubI
	 Q/wDMIQ0bF3GJsGV7CJDhAwgeRWTj86KD1jXrOQxwJhSkIsM/zOLMYAOfms4o/eLKu+FT
	 QjtSJXhVSwHP3yepc1Qg9f9AUgjTUW9TdKPXa4xVj0MV/jvStYthkiDHFtKVLi2M/A7rt
	 pQijJGC7bGFMRXGIYCbAvHV3JjYSlc+mEFA/ihofq5WCmjZf/fmZFPoV+UzXjrK9LMjac
	 2/0AGqOwoIMQlcfHggpKPqF9Tq6ul4i0mw+ENo3kdhbCKicVb+83xrb2T2TTWFjsUig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPYydE0g;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD3606D82B
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 13:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DD3606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vPYydE0g
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33c10faf6easo529120eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711505; x=1794316305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
        b=vPYydE0gV5NsEeeaDogS7BgzpRCbgHgU0WSCZQwQCoMqDHDyzf9LteAAtIvHoISRg8
         Sqkjjfggu9hKf0eYo+kC4RiuFq4oVduhirfqu+Z4r6LgEKLI2urun+FTuH+tfSqYyH5L
         AIq97Na5n86Sycc7/8E9ZamnJLgSUBJtKAF3WMWHqvWv9QzyhBvGhPu7hPQBbGCWEneP
         PcAm6BUxU7nhKj7WiD0SPouHh7pvAbi6Mn/f/a7UhVNesrdrt6Pq/IeTSzJnHUxCA9Mb
         uGg5O91x4Spk+K8/yecj2KeA/oJ6zCSGCZqLSi1TljS5COGXbQHGXSeK3An1wZccqGC/
         hi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711505; x=1794316305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOOA2bwtAvUt2OjvGKWdyfSoQby6p78bYhX3pVQdB6M=;
        b=zOEoTdeZVgSlG3wsmULAkSV70DHBjtgZWvkvKzjJFEttQDfkwWLTGFd3o03MPyZ8tA
         p71gvx5Xa95t2cC/rMMEHI/UcdK8hrn83GCBKw6YvroG5GtE3/YpSAKnoIMZiXRyD276
         gVptK+au8++xuJ4Uut4wzx8Bh2eCCYtbNlAr9q/uZ8IZLEaexPkBLMbi3OvwEMV8l6w1
         Kkx/bONaM60bY7nyE+sW8NXN4e+1bi/4kbJMTkc669xw/nPic9COa/uqDYT0lCzS5MeQ
         1HJLMCGPT+wpqbUV6UjCNJZQm/1nS/RhgnlKj844IpMF7fBhBmNxIHjs1Oru+XREs9QU
         vdDg==
X-Gm-Message-State: APuU4Z8uuKj7BJKAP4Vw1Y62WxiKhI2AYOf4Qn4ZGCPJly/08ZXeImI6
	64IfYt2X+0cKS8ELLAvOofVFQm6ENu5Y1WYQ6vGnwsg0pf4m5xLT+B2f
X-Gm-Gg: AYBFou1WRlDrAkQyxUWt6C250KAREoJ4HAc27EJOUNpDDCBC6V5+VwytFmgOKSstx+O
	ZTlKVw76Z6efq7GSx9xlWyxdUwoheKPi3G49FF2QYETfddhJ8qT1zH0VwfuhrlFTrUEEMBkV/nY
	h8fGKoTsVuU5ajotBEWj5hVWTkYppbHG9lLynPHJnJ5B1ZzHPhMP1w0TNt72QD5HsTC9t4qj3CR
	WtY7kQ/F5NOUgdInA/H7i2Y6j4KXbfhVgdpkTLdfmkOrSMn1Uy9RmiKOzoDGKE4nf7xMFq2WslM
	g16a9l/voAPrg/gZEitvEpE+Ta0erg5qRHP3newUkHQ8SB8EpoFDclKQa1lVezNU3YksycGv/ip
	+m1OeyADtJ4tHiXnfpuoPRs2KvX6qNICrswQrPm8nbjqXNZ0p3+YluvEsuYHZsMm2hmOD2DYLWu
	MXkT2GmTQuH7yi92dVMfoRUUQZtvro+y1TkqDi2T8HRzfSwyGuF0kjh66X+bgIlcV3soyV2FOB5
	6PPOPbimiE3qU8w96dHKWlGYaUuhY5yxtDmJB6K/yNxEqCeBP2qoP9/nEEopxtRbeuf32pBu2Dp
	efVTHxzDbHfxJm7rq8735NOpBAzIFiGXibKc/zgTOmg=
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id 5a478bee46e88-36a4231f8e3mr30427204eec.1.1793711504980;
        Tue, 03 Nov 2026 05:11:44 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm40133125eec.4.2026.11.03.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:11:44 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: cyapa - clamp SMBus block reads to the caller's buffer
Date: Tue,  3 Nov 2026 21:11:27 +0800
Message-Id: <20261103131127.1585884-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103131127.1585884-1-lui2012qwq@gmail.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
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

cyapa_smbus_read_block() hands the caller's buffer straight to
i2c_smbus_read_block_data() without passing the buffer size; the i2c
core then copies the device-provided count, and any count <= 32 passes
the adapters' range checks.  Both the group-read branch and the indexed
loop (on its final partial chunk) can therefore write past the caller's
buffer.

The affected callers use 27-byte stack objects:
cyapa_gen3_irq_handler() (struct cyapa_reg_data, on every touch
interrupt) and cyapa_gen3_get_query_data() (at probe).  A device
reporting a count of 32 overruns them by 5 bytes, with contents
controlled by the device, in interrupt context.

Bounce through a full-size I2C_SMBUS_BLOCK_MAX buffer and clamp the
copy to the requested length in both branches.

Found by static analysis.

Fixes: 9f1cd857518f ("Input: cyapa - re-design driver to support multi-trackpad in one driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb95452..cd80ae51f4 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -254,20 +254,30 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		return -EINVAL;
 
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
+		if (ret > 0)
+			/* never trust the device-provided count */
+			memcpy(values, tmp, min_t(size_t, ret, len));
 		goto out;
 	}
 
 	ret = 0;
 	for (index = 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
+		u8 tmp[I2C_SMBUS_BLOCK_MAX];
+		size_t chunk = min_t(size_t, len - index * I2C_SMBUS_BLOCK_MAX,
+				     I2C_SMBUS_BLOCK_MAX);
+
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, tmp);
 		if (ret < 0)
 			goto out;
+		memcpy(buf, tmp, min_t(size_t, ret, chunk));
 	}
 
 out:
-- 
2.25.1

