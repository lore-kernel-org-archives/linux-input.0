Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A83E8665;
	Mon,  1 Jun 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337785; cv=none; b=DEyfvzEqQA1RxNeYX2Z1MVbw5qtHgFv3Ckrv3pf9tW+3FWZl7Sdqu5D9/KfO7XTv5pUXBuBk6R4JVkA761oeUxWEEXsQxULT9D2H/tHUq+1Pv7J+vdiLhvw/f/0GNSPHhdDQWuVGI5GFt8NqgJeO+zAA7EI50TGsk6ywexTuHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337785; c=relaxed/simple;
	bh=9lYxdgHHYUAWEBZnZAzHiyNft8nZdcFIAq9IKYhCAi8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMTS2cMZNW+5q+oeQ0qzrhKG+RkfF2O9iiFw5Fe/RdZxiTPFaZtoCfZHSl6il/a2GH8eY3s1I/d4Ez4mR3T0tdv5wZPgl4T4/8h5HQG/78JyIN6y23eMBnMGKsc0Hs031fHucfU8WhRWkSd1+mb5fVh4nKXbMCIp6YsCAdeWJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BNndy6DU; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BNndy6DU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780337777; bh=G+eU8ciq9yNuWWO0Ws2VeIzIZOPRsWPA2tzuiHtxjBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNndy6DU+0E4pfbp+1omOhguUZZBHnCH5pakUmCKBLUfbA2bdL5hbAY4CshVLUcvt
	 6KX5HTklbK0Ly7Th1E5JG/lC5zUBoa+VZjN+xVdxV+/wRKhBJMiIEd4uyhrFOs9BmW
	 rO7ZOb7ootk9+O4Tpa+fkqZh6peN5dAFbG3bN78I=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3D41C48B; Tue, 02 Jun 2026 02:15:20 +0800
X-QQ-mid: xmsmtpt1780337763tjw23uw2p
Message-ID: <tencent_0EE402E968E17B8EACEDFF0E9EBDDBF17E09@qq.com>
X-QQ-XMAILINFO: MILSKRzDrLPb9qhAh6DzRbvOF6SC3rlu/hz7/3lPnmZX+sGYIDK5dTFDEr3ofj
	 zmZMMQOrRJB9puZgXhNjU+Bh10E9/A1rblEZp/xAih+Qm1yu7c26FhO2sSW+jzruP2drMSNpWeDZ
	 6ZTpTAl4BBR51R+937GPpOYkeDNJfv3o1ui7vshdaejfY70o/CYZA98/HzUBA79g/8RB2l7r+Dkj
	 iyb5UN9iJyCsiUZLGvc0gH+SFZbwoPHn4yWBOj2Xw5wQmR+QCkhckyvE8PBUdFDz7WxXblRp3wLL
	 POcWNegftrII16Eekr8PKHC6cZAjKG3tVOLRCEi64ubst03TLSR831G3IhjMdUmd7yyn7HXX/u2D
	 6xLsQ2BWPYCVMWpE4tBwGdNiDduDkO+LNqw0UhqQ2KZmiQRi7USa1vjkp203kw8BXi5wBqgZwQ8q
	 XCV2rTqaivPsIURP5OonDaJoIxHhalfOzLh1A/Oem7SzuHkCRVZYK2MIC3a4dNRw2mhL/HgY7tKx
	 zgWwdymlbrUmXOez1h+mIdPJtfsJgjlN0WPlXsVwQ3BhVk0tB9pQtVdY0TqDxZV5dj8623/tjot6
	 dlqeBTbAs7FOLJsDvmr8pv7hsJcDdhbps4pChvWtb1Dtolb3ZXhhmqa9UzHAfyvv19hhA7+3X14P
	 Mwj8y793ra93c252BC3QjGVnwopeiUaY1+SFFWCHtgNMFXluRbDdckbxSw6N6aNF+8gIYYRs1yqY
	 KjcX+DpHTkum6zwdUao2RNDzw866Bcje/D+et2Bmo+ABzJqfYhgZlin+aIUPIQ3uL+YAcO99Lsmy
	 3adJHcTtR1feUUfQKvrIlfpzFYrq5nFM0ZCvYKXlzWX4lfaTPECBxzGzwRFoP1XLR5i/i4hp9ZwW
	 auxfxVLhkW9DiV/mmaPCyVa5R/nhXFO0TFgFQGA/PZgh7YWZcl4ifGogqPuNLRmqTMomq+uvuEtC
	 QzvQ1vVIhBr5/fvvQ9SZ22Uqi+6qL3fW8165mwyK8kBILbmvEYucby1CMQ5/btLJjd+ywMt1slCI
	 zxpMTXX6yWh3cPJA5ecFjN2ia6lSE1ak8nbsfGwT/1yyhev5Wp/PYkE8Uc05W9AUkpHawDYoChz0
	 782fiJl24Sr6lRLakLB9oO19jRBYvou0r6MRqtI71Ia3IYprHPHorgG4QTLfCsyc2RHkXt
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 3/3] HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing
Date: Mon,  1 Jun 2026 18:15:10 +0000
X-OQ-MSGID: <20260601181510.38705-4-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601181510.38705-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
devices and hid-over-i2c OF devices. After the split, devices with _HID
"PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
descriptor address only through the _DSM method. Call the common
i2c_hid_core_acpi_get_descriptor() helper as a fallback, and set safe
post-power-on and post-reset-deassert delays.

Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 57379b77e977..e925e2d2cfe0 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -92,6 +92,36 @@ static int i2c_hid_of_probe(struct i2c_client *client)
 	ihid_of->ops.power_down = i2c_hid_of_power_down;
 
 	ret = device_property_read_u32(dev, "hid-descr-addr", &val);
+	if (ret) {
+		/*
+		 * Some devices, for example the Lenovo KaiTian N60d and Inspur
+		 * CP300L3, declare their I2C HID touchpad with _HID "PRP0001"
+		 * and _DSD compatible "hid-over-i2c" but lack the
+		 * "hid-descr-addr" property. Fall back to _DSM to obtain the
+		 * HID descriptor address.
+		 */
+		int dsm_ret = i2c_hid_core_acpi_get_descriptor(dev);
+
+		if (dsm_ret >= 0) {
+			dev_warn(dev,
+				 "hid-descr-addr NOT found, using _DSM fallback. Contact vendor for firmware update!\n");
+			val = dsm_ret;
+
+			/*
+			 * Firmware providing the descriptor address only
+			 * through _DSM may also lack "post-power-on-delay-ms"
+			 * or "post-reset-deassert-delay-ms", leaving the
+			 * driver without enough delay before the first HID
+			 * descriptor read. Set safe defaults to avoid reading
+			 * the descriptor before the device has finished its
+			 * internal power-on reset.
+			 */
+			ihid_of->post_power_delay_ms = 250;
+			ihid_of->post_reset_delay_ms = 250;
+
+			ret = 0;
+		}
+	}
 	if (ret) {
 		dev_err(dev, "HID register address not provided\n");
 		return -ENODEV;
-- 
2.54.0

