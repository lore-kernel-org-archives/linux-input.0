Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B124A07C;
	Wed, 27 May 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895124; cv=none; b=b1ilT0syrKhcJM3kMjpXmp+giiidCsqACOFKCAB3K0hAG+kBhNujAzZkrVnXApt3KWl989aV2lhd68eFuAxxAEkd8iPgPTRsIxDPyusYgDvf94theZbDqEpSwIm5uqwsWCYDwwddsNIJI4p0F1SJdHJMBWzznoom5EBgcMVoGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895124; c=relaxed/simple;
	bh=0gMeyq16HwF8FRhD78z27RVjCpDGXZOMe+sPGmAgy2Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=D366mbqR/yHWNE9pM37otYa8S8S9g4GswnhYLUEPQgo7Tc2lrlObQIkzJgkv7lI6ejDyEiCUSqs6wHcP3o8ANQXa+rc2gw+EGEjRIFRakbomjIUW4qfG4+9Q86oRnuQKCUMYwFsNVrO1JtO2rAlHr4za+3Os1n0t2ai1pdk4CME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i5Q2WOyZ; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i5Q2WOyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779895116; bh=3u3Wl8DmnvTAT8WfHyDql8odyNFCbee8gGdr/0UN3O8=;
	h=From:To:Cc:Subject:Date;
	b=i5Q2WOyZ7mur3ga+xQKJiUEP/PCg7iqyy2ZQq9/eXP3gVud/oQTnCOPaEy6x591Aw
	 B+fmlT183eNHB5s6aSO+/rNTRprBDP3ExYMA1Eg4UoIcDdKkvn+RaytnsYzfKbDlKL
	 QgDuq65BwAFPsQNReK569rC+APrHNG5x7LpxBA4w=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 48F9C6B0; Wed, 27 May 2026 23:18:15 +0800
X-QQ-mid: xmsmtpt1779895095tk6b8bskg
Message-ID: <tencent_61698D7A14AC9BFE6C9F3FDB797FCA02E309@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkh2GGPzAVer4yocpPxO9bqd5fAi/6bdWYc8jCHh3DMNGZg4YyYx
	 kXOSyB1iIR3esMIkfWL2Watx1kDdchWaxW/D1MdiJO4y3AgTCJHk0ETV153DwW6HpeSwH9yHS1TB
	 46kxJLVvp9PQ5Mp3Dy/x47pFDvDvelQyk/v9P6LjNZo9UbqYnYht85mb+RAni+YqGrZAk9HK3v+E
	 nWACtbFGi8GRBDn6iSQFTIkMQ5yG+WN02XkKeelmIKOhFQm4dlOLaWv0sVPpk9FlsTN2TT0plKYG
	 UYn9cegeabRX875uV64CNH27UmaDhL+4EwI4+Zomh5/jaZGhc123R5oWMTUM2eeAzoivolJlMPIP
	 M1ekje9HdEuNKo56kvvfp28PSanP7sZfMg289V74JATuBkyS14DX/oCz/2OuE79Q4w03iptbkoiI
	 H8wrhv6FENT8FJ0ctztGvhxJmQTh8nQpXefyy8z60bJKdvFlqSJ/nGOu5VHQ/3i3tqhQiSIfEu4I
	 Lzza+KL0ZJDJYzdPwfoTrH/L+UnFppaikPm4gVCdKQdgnKsJacbok43/dErGIt8oVdLT5i4pYMfQ
	 MWjjDVgxT9bZVHXpBcmHC/cJL4AMZtpxSleu8CjQ8wl9Y+4NuvqJc8JiotbR3KjQiCFNl7ZZiGkN
	 aWfN8ShdUeg6ZnLhjzrYT2RRmHMi2BF9nixS+6Fx3+Jx1XpYHWca5TLQ+/57mdRahBWmGSpfbyto
	 jYftXNFX++mFaP661NSRr4Se6ZoKuMlr5HwCq8SaxmsALj64fECvDEfoeBl3CUiGJoL02rpnsTpP
	 vXebn2hsyMTCfJPRdtOauPNh2gi38aJfojpuSWpsfR65wwQHl+ispgt9dudlifhzp/29FNyQSQZu
	 ihDaXisEw+kY8DZbYMUN+GRTvjTb34q766lkIkdqCfUWp4e5OSHolmSaRFE96zElA/U6VZ4UIeDg
	 aqH7FwaDsd2Ye6860pY4latOWmCjnmmi2vwxd2zm2SKypz3Bu8CoqzxoQSvkF6vLpygFqu++hPz/
	 MzDTKdOMUjRoYaLwtHwyT3rS+wDSkrhwwfGQSTLaEkJVvsQSjKdpz9mspzbFYUO4SrmHOBFgs6dE
	 lSemywC1iqyHo7bIYtzcFVnyoCWyXa8qxtFNvj
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid-acpi: Add PRP0001 to match table and OF alias
Date: Wed, 27 May 2026 15:17:55 +0000
X-OQ-MSGID: <20260527151755.173751-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
declare their I2C HID ACPI touchpad in the DSDT as _HID "PRP0001" with
_DSD compatible "hid-over-i2c" instead of the standard "PNP0C50". This
worked before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and
OF are separate modules"), but after the split, PRP0001 devices on the
ACPI bus are no longer probed by either driver.

Fix this by adding PRP0001 to i2c_hid_acpi_match so the driver probes
these devices. The existing _DSM HID descriptor call in probe()
naturally rejects any PRP0001 device that does not implement the
protocol.

A MODULE_ALIAS is also needed for autoloading: when an ACPI device has a
_DSD "compatible" property, the uevent modalias uses the OF format
(of:N<name>T<compatible>) instead of the ACPI format (acpi:<HID>), so
udev would otherwise load only i2c-hid-of, which fails to probe because
these devices lack the "hid-descr-addr" property.

Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index abd700a101f4..515ced22c978 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -119,10 +119,30 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
 	{ "ACPI0C50" },
 	{ "PNP0C50" },
+	/*
+	 * Some devices, for example the Lenovo KaiTian N60d and Inspur CP300L3,
+	 * declare their I2C HID ACPI touchpad in the DSDT as _HID "PRP0001"
+	 * with _DSD compatible "hid-over-i2c" instead of the standard
+	 * "PNP0C50". This worked before i2c-hid was split into i2c-hid-acpi
+	 * and i2c-hid-of, but PRP0001 devices on the ACPI bus are no longer
+	 * probed after the split. The _DSM call in probe() naturally rejects
+	 * PRP0001 devices that are not actually I2C HID, so matching PRP0001
+	 * here is safe.
+	 */
+	{ "PRP0001" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, i2c_hid_acpi_match);
 
+	/*
+	 * When an ACPI device has a _DSD "compatible" property, the uevent
+	 * modalias uses the OF format (of:N<name>T<compatible>) instead of
+	 * the ACPI format (acpi:<HID>). Add an OF alias so udev can autoload
+	 * this module for such devices. probe() will reject pure DT devices
+	 * via the _DSM HID descriptor call.
+	 */
+MODULE_ALIAS("of:N*TChid-over-i2c");
+
 static struct i2c_driver i2c_hid_acpi_driver = {
 	.driver = {
 		.name	= "i2c_hid_acpi",
-- 
2.43.0

