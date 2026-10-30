Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399830;
	b=5E9kB08OKMnxw2OhYyvD3rNP6qCcBL/C8lf5F5hB0yANCB2RWCRjNc4GYZQ2Zz50tp6t
	 TR2yR1MVgNfb4juqoss03yh02jXqYTyrVfZ93PPqiKE/xDyrISd9klN0UIVyI24BQOTs+
	 JFfBXjh8IkUDGBsSCJ+IzSPLib0blBm/IPwbsOXqpTWa7IJrPilzMOVOYKfzSqdEixXvR
	 8JNgYjxxBxFFNlXz/bAtyqn0m1qj5M1WtAcGFpGfZi5KtGLPuMg+/6d6mFAljV52xQrh0
	 r28cEaCSHYNBsZx1JnI18z6LQka781s9HGAXAPmis8bscaa8OXXKQgsQYvIRjQGL+/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
	b=RWawz1RlPwjIheqsI2GcHvOuWmmuGIzznPM2S2Wlvk3hLbO3U2+XZLf52M0WHUqyLjOU
	 CbOyoml1syy7UqNXd9crF/Quz15Z5Dbt1sYJIse+D5o0rGK86aVF271cTKiaiPXyFyWt2
	 mO2HY4X3o9xe+nO+IcD5DUG6APgfL/zSvfdkwAge1MBtnS3cQ3qdjueb3JkiexHZrV8Hx
	 YTNwJ13TuHAaWiKeNPlgOsL/P2qH+c4mnb4nvNJICOKF4UTonZtSVIg3xcN3v/N1xaO3b
	 ohlJdU6Kte4sofbKJBFNhIdUVP3iJO1YozyC10X0ZFvLSUS2Gyu5Wd3FedhIzlSLkmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oqx+qjv0;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEED60A2609
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEED60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oqx+qjv0
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so1378789f8f.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399829; x=1794004629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
        b=Oqx+qjv0B9aYmzbqrMp6NkPYsKGGi6CEdI3ZwK5m4ZvQIgJD6evJAB+UldKvLqSTEZ
         BAc6YFrfJTQotqsXG3LNY7s1VE6RFYAvVn5Y+RrW0v4mrNot6K9R0Qn3SRqRmGOZtXLd
         4v4W33vfDbb2KWtX5p013ch1eFE0tQV6yIrlPH6p6zPgsLcDDH3lXQUHPfT5C12peinI
         4tA/lzTaOYjrqJYJQNTwSRjHQ8M34PdIKWhV/Nuw/+oAM3Z0851VMw4i3G75SG92CE79
         s37ATMZ76M/Mp6O8VmDLgE4BdSSP2Ya09b4eJbZB/VdP0BEDz8OjRatycIkRhNKS3MFU
         N3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399829; x=1794004629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ba5bYhgr6cFUpEyFJKX9JHAzh61EDkiu0uHMJZnKIBs=;
        b=UIo551unH+7P+9gDqhvvHmBfO6TYQc5+z7NNyET7TidBgyI34DM/jIRutNk12CEJnK
         x9nNxng2nzWkPU+un5NZrkGhRPMNlAT9RmcyVuSangDTQjczKq8PcXxKqd9Ju1MB1Dwc
         wg9oRvhv0ahxpWDz6G0WKdothTFu68sPyt6LWPghNHY6LvSnUt5+811p1Vkz0NKdIhEQ
         52YHltS5BxiXrwTVQW4Cj8BW8otyKTCjCZ5JHoxDgUrw0VQNb3VrFb7R+jtggcECsDFk
         yeParb0Wm3RRSf2Bl9f7+GZUAEQBLUliVatcZd2SvvvZY+OgIGvOa/JpZaxYakMhVOi2
         tvxw==
X-Forwarded-Encrypted: i=1; AKwUvByo3DXj+bopbycv7DtSejMcUdEFYGHufebpDd4dSvQ4qwqwpfRJnQw3nRZbE0m+m+Yr6dZXw4mDvmAYrw==@vger.kernel.org
X-Gm-Message-State: AFq9FYII2c8IZN2ETBtXe912eqsXHZQAeCKX1CJ57iyzAyeddSkTEQxC
	J321js6YLwcokzgK7uN1jp+BgcXBF822bOJiufIWbCSUD6UZ+6pnYKQ0
X-Gm-Gg: AYBFou2S+Hg99QJQI8DpXUhEw4dIV5DVhl6xL8Gx3BGDcz/XyZ4aN/0EJtPc6R6egzD
	ZOpDlTKWEq19yXxkpVzvglgY4CbT8qgiXEIp25MzUI4XcTNOeevcjvrdVLs11dUgwDuiOR6z8za
	3HcNuDaYCkV7QoCz5ax78mnmfyztmMqGHAsJ3DBt+SCAzdbMkiR2PoRXp6+bzvCUfVIvZDRHB0G
	Ywoz//UOlpLCv76GIIq0KyN3jxM2Ii2Nt4pQJZZach75Nh9xhXfq4F4cerquk1hzq+4SHjyOdJ5
	lkgJArzOM3YfQIDNob0du05u0t240og9vHG8xvLEKiF5oPh5+ibfWDHf6kehntuWVuwJGgcIm8S
	rq7Wag5q2TjvQ8qsifUlHmHcTIiknPrA6Jbf/VlyR+tpvLDsBkPVm6zM/1iQuIYuj2LzTkXQiTk
	u0tNkt97OpQUDbIxLDw1rlU0iB5puKp3jWPmUgXcoH/BLlAUQ7hBMnelMLgw6DE+diYSK6+YJzQ
	SeF0JqAQDTb9R2IVrFAotF/BkEpXjriJ2fsLqpzwlLDrXvnWiwC4CphJhRjjQ0B4ozRImjO4/+f
	mnIDxfcOVFhLlZ3G98HJjxNhy5tC
X-Received: by 2002:a05:6000:4910:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48e6494c24fmr18207678f8f.3.1793399828561;
        Fri, 30 Oct 2026 15:37:08 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:08 -0700 (PDT)
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
Subject: [PATCH v2 05/15] HID: ft260: i2c: silence sysfs store big-numbers
Date: Sat, 31 Oct 2026 00:36:27 +0200
Message-ID: <20261030223637.86907-6-michael.zaidman@gmail.com>
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

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count after a successful parse so the full write is consumed.

Do not report success when the feature report fails. Store 16-bit
attributes in little endian (reported by Sashiko).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2: do not mask a failed feature report; cpu_to_le16 on word store
(reported by Sashiko).
---
 drivers/hid/hid-ft260.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f134fab08285..d2c5c9ed7927 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1471,63 +1471,67 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
 {
 }
 
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
 		type *field = &rep.name;				       \
 		int len = sizeof(rep);					       \
 									       \
 		return func(hdev, id, (u8 *)&rep, len, field, buf);	       \
 	}
 
 #define FT260_SSTAT_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_system_status_report,	       \
 				FT260_SYSTEM_SETTINGS, u8, ft260_byte_show)
 
 #define FT260_I2CST_ATTR_SHOW(name)					       \
 		FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,	       \
 				FT260_I2C_STATUS, __le16, ft260_word_show)
 
-#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, strtou, func)    \
+#define FT260_STORE_NATIVE(v) (v)
+
+#define FT260_ATTR_STORE(name, reptype, id, req, type, strtou, func, conv)     \
 	static ssize_t name##_store(struct device *kdev,		       \
 				    struct device_attribute *attr,	       \
 				    const char *buf, size_t count)	       \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
 		struct ft260_device *dev = hid_get_drvdata(hdev);	       \
 		type name;						       \
 		int ret;						       \
 									       \
-		if (!strtou(buf, 10, (ctype *)&name)) {			       \
-			rep.name = name;				       \
+		if (!strtou(buf, 10, &name)) {				       \
+			rep.name = conv(name);				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
 			mutex_lock(&dev->lock);				       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
 			if (ret < 0)					       \
 				hid_err(hdev, "%s: failed!\n", __func__);      \
-			else						       \
+			else {						       \
 				func(hdev, req, name);			       \
+				ret = count;				       \
+			}						       \
 			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
 		return ret;						       \
 	}
 
 #define FT260_BYTE_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u8, u8, kstrtou8, func)
+				 u8, kstrtou8, func, FT260_STORE_NATIVE)
 
 #define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 __le16, u16, kstrtou16, func)
+				 u16, kstrtou16, func, cpu_to_le16)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
-- 
2.43.0

