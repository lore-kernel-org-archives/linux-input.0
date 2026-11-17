Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945934;
	b=VW6t0da1jdZ06ewNbTUp/tGvIU2p/tB2uGV0Ao6lvLLWNO4e/UIIYFCYl/CYcHrSbqvp
	 4oDmG3QbeOSrPzTupbrekDrSpNmAo+zTU6D9DRaVU7TVJtwLs1LTpOMkmEZ9DGGOIngc5
	 KeGO9X7HV2gN4eymJ6MfE968Bf+LX6VzqpwXxtfrW9Ahsgoo3kG622ecIobBTATFZI4wG
	 U5CJWkpJDxj/gVRNMsEeQpGgU+ir2WGVPiaD8BZJ7lsYHMQ04wghvFh0g1sKvEctrDOL0
	 bS1Qk+Ax5DNhUZZ085FA5BKw4eS/xU80e1qINOJrmVo7p+KITm9mpksEumjReUQj4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
	b=ZdNVGuz6ADiX64alB3hC095H0Hx36SXGhMI55t6RvQ39d+QgSPhYHHmUjR0UivNoyHrC
	 9sNdPYZ4eSi5mPFEbBgy4FbUAYTFO280351EzWemto6uYc6eNhj5NKt1BP0b5b1CvWbW/
	 nDrAWkc26Id8r5Lzss6Z2hDrCKAMPqchopmBO51SaXM1bLVDTkM/59dmU9CLIdBaeVVC0
	 W7t5j/3tgQ6hNLkmwVXuIkvQVOujaQDou525wE+Y8Ypwbvq7UY/sJFnVfUOWwo2hxmXjm
	 evvb+//WQHv6jq+beXREwE30++KkiVrC3OG5YLCyOtzvPq/2HI7HGPKS6ED67DU6ilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZwqXXRp;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE45606B456
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE45606B456
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZwqXXRp
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so2781005e9.0
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945933; x=1795550733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
        b=eZwqXXRpXTnuGbr0zWQDv0SFW0VKdXA0Gkv36AC7DWNM3f2JCZwrmuhIMKey7QoecS
         H0OeoWbe+Ew3Y5HryOUemzfAIpmTBe0zbo+3cXFeAfcj5TWywnqqUS8KH6+4CNoe5dC5
         DMx9ohgtietqL6V0MOPcjjGV2mYOgHBvXeRTCkeoWJidXvmfcH93RiAwOYfBvFgnbEcQ
         Yt/I3bBD+ffnMoJdyn7goSVtCb5Yu/rXpQ+yp1E6UFTTqGi+Lk7m1Bitzp4Cc0tayru8
         RTzjWbjmRi3knhnx26b7goby3fUx6dhKt2ceH5LUH49XvpfH8Yidkh3HltTbN6YiPo4x
         8Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945933; x=1795550733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJRW8/pUEx8tBkwSu8ULpNbc2l9+sxqXJHn/uyDjr2E=;
        b=H8WCMv76L2FrdTBFpu+eUAjzvR+lRuTJeRT6LFG6mSW2Zzh7CvLCi6YvFmaOH0jK3O
         ja73mjeVvlo9+d0BHcjm6aD61Jm3Cyc6/zJUyD+yo44Pc1zahmpcwFC/zCJ+yl7i765E
         A8SqSQtkwpUur3uhT0NUwGdFS/FYoxF4ckzy0LnqJaaCocB+QhLuQJ8R0m0Q3u9TvhCu
         Cpg3elNFYFcGl2RA04zXP2GBbDaZoGxBlAXIAOwbRZ+2dj3hnSXKcHyH/rpVXyzOmmrW
         /nY/ps2/vShy97F87pvaGCFp8nzxUinYbShjMpjDEBesVOuMLe+PLMOSK3r3PAoEWG/O
         X9Vg==
X-Forwarded-Encrypted: i=1; AL+hErHIWxbJPEs7P58nRSVcdS8mpe4i+Ab3QOSX/+kb6iiPyvdJkc6ymeUoMpRAYsKV1DPoTsVFo/skyQSy+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z89BJoekts/QqbQY10iww6s3iH1A6G4JzbGXoMdx7UE9ATYdSNP
	tpV1KsrVFa7bqCC62ousGLkjIAu49eI4Y/7RyLRrxtjp8iiozJ31vnYo
X-Gm-Gg: AYBFou2v+0f4osuNFOJok68gCPr+fc+OkA5ZNrC2SS8N7ZKcUqXDahsGSrkdLg+0H8Q
	1eXWWD3RJzmpUrgXEf6OtjlT9MXK05bcHmWzM6SE5TaagFdFhivF99MtmaLK8VyN47u2XgIopwq
	MWS661n2aMI+t8B6g/64UZ+oSDgOIqtfvHW+E4gcxEGV+b5D+9nZqGky8W6wJytTmJPfJNoanSB
	MMdpq3nB7iKMTDVdSuzH51ptbq3aYwRQuDkK1qp6saG2OCBFVZqEn658Ry5DGoqMyeBjIkN+GQ8
	efupiYeQ+sZdhB7baaY0sCkaWS4kYP3rKsSnAFnpK/gwpRQVm4aJhv3t0YFXBIplIfpg7p/1TMs
	lOiPVOeJRPqT6LaahlU3Wx3Lxr12ydZqGR49njAKpqE9jtQDqUvG1gt5rrWMetYT9zut81GQa1J
	YvqR988soeIemaWBwZ9k2ymjAbSeIJJdRYnS5ISl6nKIdr2f2bmjZBtTc+hShTmNQ5T3AHu/Qsh
	MLdsat75AnxAljOcm3jUBx3+ytLKtyrHLCr4ToYVKP/gyJlzX/CiFdfJv+TvG56u278CWOg5D4b
	T6zMeJVQ31Gp3wH5kPC1U+8F6TGh
X-Received: by 2002:a05:600c:348f:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4bb7d9fb07fmr4999995e9.11.1794945932399;
        Tue, 17 Nov 2026 12:05:32 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:31 -0800 (PST)
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
Subject: [PATCH v4 13/16] HID: ft260: i2c: reject an I2C clock outside the supported range
Date: Tue, 17 Nov 2026 22:04:19 +0200
Message-ID: <20261117200423.19561-14-michael.zaidman@gmail.com>
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

The clock sysfs attribute passes any 16-bit value to the chip. The chip
accepts it, reports it back in the I2C status report that clock_show
reads, and runs the bus at the 100 kHz default. A read of 2048 bytes
takes the same 0.298 s after writing 50, 3500 or 65535 as it does after
writing 100, while 60 and 3400 give 0.387 s and 0.058 s. Userspace has
no way to see that the value was not applied.

Refuse a value outside the 60-3400 kHz range named in the datasheet
section 4.4.16. ft260_uart_change_speed() checks the baud rate against
FT260_UART_CFG_BAUD_MIN and FT260_UART_CFG_BAUD_MAX, but termios has no
error return, so it falls back to 9600. A sysfs store can return an
error, so the clock store refuses the value.

FT260_WORD_ATTR_STORE() takes the parse function as a parameter now, so
a word attribute with no range of its own keeps passing kstrtou16.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cf745db8e3f1..d5250bf5da61 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -69,6 +69,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_WR_I2C_DATA_MAX 60
 #define FT260_WR_UART_DATA_MAX 60
+
+/* I2C bus clock range in kHz, see the FT260 datasheet section 4.4.16 */
+#define FT260_I2C_CLOCK_MIN 60
+#define FT260_I2C_CLOCK_MAX 3400
+
 #define FT260_GPIOCHIP "ft260_gpio"
 #define FT260_GPIO_0_5_COUNT 6
 #define FT260_GPIO_A_H_COUNT 8
@@ -1592,6 +1597,25 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 {
 }
 
+/*
+ * The chip takes any 16-bit value and reports it back in the I2C status
+ * report, but runs the bus at the 100 kHz default when the value is
+ * outside the documented range. The report gives no way to tell the two
+ * cases apart, so refuse the value here.
+ */
+static int ft260_i2c_clock_parse(const char *buf, unsigned int base, u16 *clock)
+{
+	int ret = kstrtou16(buf, base, clock);
+
+	if (ret)
+		return ret;
+
+	if (*clock < FT260_I2C_CLOCK_MIN || *clock > FT260_I2C_CLOCK_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -1649,9 +1673,9 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
 				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
-#define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
+#define FT260_WORD_ATTR_STORE(name, reptype, req, strtou, func)		       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u16, kstrtou16, func, cpu_to_le16)
+				 u16, strtou, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
@@ -1704,7 +1728,8 @@ static DEVICE_ATTR_RW(clock_ctl);
 
 FT260_I2CST_ATTR_SHOW(clock);
 FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
-		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
+		      FT260_SET_I2C_CLOCK_SPEED, ft260_i2c_clock_parse,
+		      ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock);
 
 static ssize_t i2c_reset_store(struct device *kdev,
-- 
2.43.0

