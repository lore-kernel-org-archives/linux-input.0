Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1283451AB
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482259; cv=none; b=sVSkJQxz7MwYaxhx/ZuUZlzM4PXTx/sV0JHcAUoj0pdyFGJ0yvgyQjosu5W2kyZUlobH5ijIvUbWj1+K1lgnJGCOa6eA5fR/ZETGtZu025SfkeX1MPptAcAsJOhIKXcyNE8dvmAM9eDmX4eoR61uVuvJoPYZAt3aqd9sWjBaUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482259; c=relaxed/simple;
	bh=Li0J/iN34k4L7GQX3WlW6+Z2otBK8rnu2iY21ICjq54=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pND72KN1rIP7cQKJ9WFk4KLjNpwhpxayz66htcRLk0RF8Uq1kRBOYbREJuUbHv5DaucVmYsClS7piiYgTrFFfxgHTeQPJ6pBvQcml2l67gK+8WCKWM9G1PFmrntM7VblUv2Z6aJLfZc8omJKLVXnhfNuoIzxL7eyYCI1cdd3EZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i3lOgHEw; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i3lOgHEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780482252; bh=3IFsmtdeBASfMNfGCUrLgL+sFWEJNMLgx27+MbZSchk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3lOgHEwfw1PJecLRfh1un2yu71wN4HIXvCml0kzeTPSGU5qxpQigAh+c2ARRmt7h
	 ZHW6MlRD8bnPSpHkKM3bXGgHr/PxxsvQPIIDgfhUoQEzee0wbjZUccc/DcNkF3hjfa
	 wcd0IaK5lq3V27ghXrMqOTnjfw5xu2tSf1LWL0v4=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5C23E0A6; Wed, 03 Jun 2026 18:23:02 +0800
X-QQ-mid: xmsmtpt1780482236tuhrq1h36
Message-ID: <tencent_74D6957F20CFC7ED9D3F528134B4543D5C08@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2pET5Hy/aShkdKu50ck//5bdMDBIt3fNoZGX6OXCncJjM/P2+ny
	 JIZt3RfSvPtdCkx3WLb3vqHrtx25fjD+0i/qdO5Px3E3a7EqK3hE5G1hKaSzk4pVnvuK7ftisIq8
	 PcJu3HESryLr/YgHVe+2bwpMXfNj7qowT64Z650x69GyyErjh4VikwKkAGZK1fGbVHQpsNzxoQcC
	 ubT0nu6YZXAIFTMtuK0gJOTTZu2jzsLi4n6l1LxmaCA+L75v6WsAhwmnwO5pv1I608QgNy4Em220
	 Nu3nZnKkVSAzTWpf4Tch/zop+KJF7kpHgd1fFBa3/I2kOQXTPJbLEGqcEIbmNOfBMdivshzjrGUm
	 FbOy/12rPIv1APbjfdBWVzGzC5+xoEqy4X4sKTEIzTC7Fv95WG+AWdDL1ByfSfyRhyWm26zmQbjW
	 gDcfQlRrLTc5ooPxO8tujfknmBvl5vHENJERITY2BLlPI+MUdlXU93++GBrRYtHcZ+zI24VamMFz
	 qUu9j6Sf+36/FQyUoQ2tYdvQbUaQfu/jYjhMqyykzeagfHKc1vVCwCtvdR03jdbB5mwutXNoOAHf
	 frBQMu5nR9VkzAYrtXOM18Bp/VsfHOrJyLy0JZkyqY/u19IZtN2/usn/Utuyv2a63ancMdkuf/Fs
	 /QqtFo5Jea5lxgUOsA2zm0M1N/Jl9dxjUmcP/UlwavcPsuYFiM4jfRmuHRYEyPpPb7csF7lb9W8m
	 WVtuzy7Kfy8T/mTbfUq0rJE5p2Ak1E/CqI3TQwHwsR4jH82fcNLZHDs/FJZV8d2njTbkz7JjoEyt
	 t+nikKHxrJ/E+S2ngoUfdxBWQRinvfS/SPvUZ8zUU6LVmEbE/n1frlPZKGO98bz8Ga3Zv69M1VaH
	 BwxzD1xo+FukF/TA2ZBFIdnM0mjQb2KqGAqf+aZl4/0v0npnDCIbUeK9qw9cttUT3Nbx6KD3D31c
	 C7LOrXdtSwdGxX7VmkcpXTq8CFaUsRm903VjM+QYXhCA7gpbVrZMCV4ywQeeT1WCUI1dbQzSiNgw
	 7wd5Q7nU+hYGvAqNhMvqJhciWeQBSM0KSeOzjimfSGEBQbXZarKytHzegIndSkxNbsCJx/CsEm9K
	 WR7Qi7TzENkKWGb1JCvWv0X8PXKDpLbbZFM3MN
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing
Date: Wed,  3 Jun 2026 10:22:39 +0000
X-OQ-MSGID: <20260603102239.26491-4-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603102239.26491-1-Yeking@Red54.com>
References: <20260601184747.843DB1F00893@smtp.kernel.org>
 <20260603102239.26491-1-Yeking@Red54.com>
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
v3: Add restore_sequence

 drivers/hid/i2c-hid/i2c-hid-of.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..325c64dfe81e 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -74,6 +74,13 @@ static void i2c_hid_of_power_down(struct i2chid_ops *ops)
 			       ihid_of->supplies);
 }
 
+static void i2c_hid_of_restore_sequence(struct i2chid_ops *ops)
+{
+	struct i2c_hid_of *ihid_of = container_of(ops, struct i2c_hid_of, ops);
+
+	i2c_hid_core_acpi_get_descriptor(&ihid_of->client->dev);
+}
+
 static int i2c_hid_of_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -92,6 +99,37 @@ static int i2c_hid_of_probe(struct i2c_client *client)
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
+			ihid_of->ops.restore_sequence = i2c_hid_of_restore_sequence;
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
2.43.0

