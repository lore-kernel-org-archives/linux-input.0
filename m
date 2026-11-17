Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945915;
	b=PzhMweDuajz5enFc/dNjycwylXWDUCLxiO2DHi0y2s1nje5WhS+VDXDYxRGSyoB+w+i4
	 v7rhHZJjidBP0+9EhnNipvT6ZGZHK1w4lpOe7Dj/AmCt58AgYegKjMNuxouVD5px+BNRx
	 teSwdcXaylvz39X96sXyFgTZcsRJ2b0LI1PmbxTBWaALWQyWxldcTv2z+yXqsDK7bmq8n
	 v+S4R51jddX/2L6+qGhn6H52rDPqJei8ux6BGjZzUkFXgkWXNWB+t/QGYV0WV8zosOi6P
	 3lT0zykWCd1uavOH5xc9hu6hvb16V83faW6P+xD3md650nIGOOWctC4uZYKH5d21jaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
	b=U9V302qtCwDbciGpQwtcBIAm0jsmvTTwGPRUXrMaiy4zWNHJ7YbALh0dPqSoQ+hOlN6D
	 QJNEpkA0uNs4Z0immehdJX47qNaBY8lHNbyV2Z0gGrFMJd6UsKFQRU3uimufoynOajuSQ
	 wTwEblhmyodHp2dlZhaYRvbcldzsJHRi6GPYAnAlNwr5Y9W35xrzLEYkQrxNgA0JuGZGS
	 wJ0nuo/fS90VSTwB2ErbtOJhhd8rF6dAtkwyqIg/dCJMawgRypsZPvT8rtDFD0oCm+4GF
	 toksoaATZZ5p2t4t14yiLWc6TOHzSsYvVne38O8I3k+J6rIAf0LC/N4DskfhQL+zStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMpoD2pQ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4760A5BDA
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF4760A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMpoD2pQ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492690dd5daso135707f8f.1
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945913; x=1795550713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
        b=SMpoD2pQjaA/cYwragUAoL2cukgsQqAGoTUGPepWYe3flBwQMPJYr2+y+F+Ut7Kz+E
         OtvViQ4W7x5E7+e5G5fCm0nKIraG+qRrtUI6HMDdyQeh7FKYXzyp/7AaQw9uMl7kFF6S
         mqOpcHdDv35O2pRw8ttbgzFzyxpcUQGPxGB2Ge2naeMbBTSEJOxnvf8liWSxYvtEsIL1
         75McRy04KBF+kNYieEZr07EBSyz00zguoprTeNdA2cJn/deMAz6fQ2eS/bk5G91FkAe0
         hFeXUG9iDIzGHafEklmHwTxURZbJFyTqF5ghJztE9wemZNwf4wZeyNM272S2hPY6rvc+
         GZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945913; x=1795550713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4V/mFDPpkUiPU517GUo/F8CChNGX/URZfOCzHfy5Ek=;
        b=RZvxxoRWYhb+m427eElX1pqUC3UCYiN0dQwyOGh178Qjcqyz9sbhwyogSgrjtyiyAh
         cjQuLmOBTaFGGF0/Dfn9g9KrY4qUGVu5ok6yYf6ZhZ6Hfa/pH74f7Op2pnCaqSQ3C1Xk
         cN9uiPqVGT7J611bMd2Ba7Zk8sfv5O17Xbdh5xC5rpojeQtSMfmz4pjvqxvkf35yA8Qb
         dk5NLRYvtypvMRkoD/2aNcngQ2z25Xjmrx2ts9ovq4Xr9OiD/oghMkJDzWuYjHGLvYOc
         l9aOD/wYu6W8M3i+kTOL/LQSSM6GLaIREwFpkAOkplqtSuPBRn3w0LA21RaJ2/3Z7Q2i
         flHQ==
X-Forwarded-Encrypted: i=1; AL+hErE701znGu7vlZcls5T6Gi0Nt9Ee2RaBfPoaEoN6wVVV1EvHPoGh73k5mH2xGQ9uvUE5RKmgLTeOXDIMpw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ijWVzYPmumLOFMzVD4ZkkOUx4emqgppU1hlspLJjjsDTAwFNv
	Q6i17yClYQ2XnJeb2SiT1pq78aYOHcr6NCL+hFahAoGnUBy+FACWkpdd
X-Gm-Gg: AZFdTZcfI6bvZeIZSfUBcbQvadg7PCx0wjVlQp1Z+jeZ2WuKYOznWTWU+3QWBPq8S64
	3FNo7CyoDR9zY70m7T9xKjDcTONuIGu3MkxY8EMi6ZZFQKHVV1CXQ+AuJfiw1yJ7oJv3hjnCiYh
	Khsy2q1dm4TP9oWbOMd2wAaD/44mHB6ozo+yZVbpOnHm87QQrjDlz5K0cp8xEUYbrsfT6lIyReG
	j4zvkgoU0EZWleYnJTbeFVD0nDG6u2aP7QKJjp9lB8FGaTjBVysHRNbxT1/EAZbqXD4kMNO0Ir2
	OMPLtO8I72qSMY4wYNw8fRr8Hg/TUrRwu7TQBkISmp+UM7VmpsmmrpPvQaqEceatHlTOAed7M5g
	8Bc/6P/8w770UvITeSPOPH+kd48IvzFSjly4nVOnSQ6Nv0DaGH+2R4V4gziWIHn3WpLSv+wQXjJ
	HPFvRaMmtCqhw1YcozyYxJdxfzOWxYkvGWm6q2x4bCP0Y6w3Bim7NOaizgvdBJkkN2I1aEA+6Uf
	Me9lqeVK9guymQfOKLZNqev5vt+/PvB8md7qjenf8ARgrB55ZRJg0JA8s50ZwtNxFZj93f/k7HA
	21i93bqCM93vAZKJEWGWkRj5k92c
X-Received: by 2002:a05:6000:184b:b0:48e:3df8:74cb with SMTP id ffacd0b85a97d-4a6334a76d3mr1304109f8f.6.1794945912888;
        Tue, 17 Nov 2026 12:05:12 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:12 -0800 (PST)
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
Subject: [PATCH v4 05/16] HID: ft260: fix sysfs store failure notice for big numbers
Date: Tue, 17 Nov 2026 22:04:11 +0200
Message-ID: <20261117200423.19561-6-michael.zaidman@gmail.com>
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

FT260_ATTR_STORE returned the feature-report transfer length from
ft260_hid_feature_report_set() instead of the sysfs write size. For
values like 1000, userspace writes more bytes than the HID report
length, so the VFS retries the remainder and reports "Invalid argument"
even though the attribute was applied correctly:

  $ echo 1000 > .../clock
  bash: line 1: echo: write error: Invalid argument
  $ cat .../clock
  1000

Return count when the feature report succeeds, so the full write is
consumed, and the error when it fails.

Parse a 16-bit attribute, such as clock, into a u16 and convert it with
cpu_to_le16(), because the report field is little endian. Before, the
value was parsed straight into the __le16 field, which is wrong on a
big-endian CPU.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- A failed feature report is not reported as success.
- A 16-bit attribute is converted with cpu_to_le16(), so it is correct
  on a big-endian CPU.

v3:
Subject reworded after the original out-of-tree commit, "Get rid of
sysfs store big numbers failure notice". The v2 subject read as if the
patch hid big values. No i2c: prefix, because FT260_ATTR_STORE serves
all store attributes, not only the I2C ones.
---
 drivers/hid/hid-ft260.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 1b31b484a11b..bdd55b35df9a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1486,56 +1486,60 @@ static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
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
 
 FT260_SSTAT_ATTR_SHOW(pwren_status);
 static DEVICE_ATTR_RO(pwren_status);
 
 FT260_SSTAT_ATTR_SHOW(suspend_status);
 static DEVICE_ATTR_RO(suspend_status);
 
-- 
2.43.0

