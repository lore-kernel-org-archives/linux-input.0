Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B42D781B;
	Mon,  1 Jun 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335596; cv=none; b=Zhwnd5W9E8I9knarRpoxW7U1qRUSeLT4f97mG/h/KT33OogUNp9WD9s3yOfzMXGVBnmHhc9Z/PNLZzvVf8rXRdNfyPDmYdIF6XeWYrDUhQH9YqwO9mdlcGihvBvBM5c8CdEzDwyWRFrrvlvL8hggQCP7KFhWoQYpaOWlrzzZ99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335596; c=relaxed/simple;
	bh=9lYxdgHHYUAWEBZnZAzHiyNft8nZdcFIAq9IKYhCAi8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG4gn9Tt0kvRzwE1cvN6HDElx5Lwf89z8CVlC4xOii3cfVWGnbPetoF12Pz0Cj7Gs/hIT2af8LuxkGV+MQ4mTMo+OmzAGF4UA53bpKPI5EcACcr6TmQAs0oc1t11Dqb4JgmMEhXZOqu6xmpBItJdUaT2NIRd47wEmkb/jNiP9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AsN2Y9xv; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AsN2Y9xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780335586; bh=G+eU8ciq9yNuWWO0Ws2VeIzIZOPRsWPA2tzuiHtxjBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsN2Y9xvAc58NM367gA0lALFoKauNRWaGFfT1X/J/pN+bgl6HE5DaZ0ySZVai03DS
	 7QLOtMDkjl8YSaUCMp7uHNSLCmY4c/LznXHmgw8lHzgoPYNb7VApO68oNhL47L7vic
	 fSJSGpfeUFN0Yi1S8FVQ+xLpzG5YujKDvktQaSrw=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 979A8A6F; Tue, 02 Jun 2026 01:37:57 +0800
X-QQ-mid: xmsmtpt1780335569tozs7zk66
Message-ID: <tencent_589FE3DA1F7ED602D168E57BC2AC41FEEA09@qq.com>
X-QQ-XMAILINFO: NA8WCMn5GQiM90oke9PcjRKVIEG7FngyEhrfELFftvCuLvcqmOxlVlwgM1pbIQ
	 Ap7HmSitu0EXn5bIUWWUnRrGf3mH6dOmBWq6YOA7P2Rlo85HtPZZAYj13DCFyUqf1icHdUhWU4t3
	 7JKfukQKs2Qi64qNL/37CWCKHCmEQHbDYel4ksg5rn2GN6J+VIdkiTkN+UIoxXmz0BnAbIdcx3nG
	 LiUqgU8uBr9QNLxAG1TaBUANItwGXGhh6Ch9xCV6V3HKNnP0jHFQ1JTB9N2ZyDfMY7km/ISmR1dZ
	 CpEEu0usgq5QTQipNIs0Ukph5ANnll+BIIGYGZfym+7AIhBNH0hwZCDefECGLtxfCg+T2vWxZQBB
	 HDiIf09TKI8X/aYex3+MvyNg22zG5jZjuJODkOHtuE3VlzzNEdvd4IrgLhPOGbRBlX6Xjbbg1v0o
	 v8rBZUcsNzJAZitsu7phNImsL6c10Uqh3jO6gLJ7pwgbdHpAgx/uYXckfGFn6hseaXI/ToPTiKcr
	 OYXCA106BPk/w+orisRlrxPeg5UI+K5j0NyCwPg4LwdU++bAp0QSc/Eh/6s+9TcDThrB3Dw5nxIC
	 wiwkNLfWF/s0iTKibBK4bEG1n/GqwkJL6DBXR5FFMCVi/BL7uSjX25aS/U6uZx5HvxAplX6f08Ay
	 T8Xo7cpegySjvzc7pqHc5x7JazUYWvOrR8qTQ6BvfzotGQriMEjJ6ba3GQNn7vAcUS947V5d+qaW
	 hgKYEZZOjSCfSX5/y2IvGJTx9tYtd+MwtK2O0teja5SFWcBY0M6vFzWlxV2Ns7KKRVGQBSCKxZW5
	 AbnCei2GUAJ/5rRNKLuHH1D3ArSc2Gf8px56zYFFGG3YKuuusX2EGme8w4ZkAhc4eAuHQF7zOha6
	 cRie23x/JD/0MTHu/DstZ2r8zb4z0+KBtpKjun85ipRaC0Nhx6iUohfXLKgg2wx0j/Tl7q5Al3n5
	 eUQbjSQrO4kfUdCyIolOJ4fEJqZw2bizVhlLB71GaA3XBt65RC7lDhVC8qXQl59y3XzLnJGtbAWe
	 fiPrux5ezDGL7MiNqZE7knR8oN9uA7oGFppawioWbWfZgLX45oUlRPSyLyznp1oUEgna9reUcWcd
	 wbuqcqSrTekk4Kk0Ecdhr+F5+CEbcb1kJozCZm9sWP/Uv6CesQA/9spao/YF8wiVgAc6DZ6M4RCi
	 5iPIJTl+BKBvTvnQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH 3/3] HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing
Date: Mon,  1 Jun 2026 17:37:22 +0000
X-OQ-MSGID: <20260601173722.38151-4-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601173722.38151-1-Yeking@Red54.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601173722.38151-1-Yeking@Red54.com>
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

