Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126838;
	b=TaNNoSzvLGVi5nD0Gz/Gd9u6fKnoMwXbVIYRvlnHm0bGjM7BwfVjC2e0PecU3xi/Zplm
	 uPrVxWSZF/jQOYvk7d6gZarW9M0O18Fhm72ahGN8n6TCdtwzqgq7VtcKgcmSP3HOpf3N4
	 Omp701z15v9A13qxts+Lir2Mo4UlrTvA2Wou9S4TF3M/AiqP81E6GssxEQeC1T5BldxKb
	 sU6qAcSnXrjw/MVzkUyZIy6RFB/ob8BB3rOroZtNlwWRXYq6vw7CvpIB8QEPP4VsUnKXf
	 SU9Cev9YfodwTtxTj/xr6SQfOHdKpNhJ23o/fK2aOEwE27KB3UiMY674e6nW9NFoJ1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126838;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zZRL0ZXFxeL3crcl6uJIDsWXFxEsT8TAry9BRqXWDvs=;
	b=f1lf8KOUKqrtD9a4HbuLXBohiPsQ1k2/d5n/RzubwumsfrGqJ8Q6GRVADJSS3D1OTi7p
	 VIA5XHLs9EOad+XekR3sqNC1Cgwb3wbnm3M2Y3CCIhy6GBxTZtWTIm9H1PkI8C3LGOvPl
	 UA35+G6lS1xlVLWL03Qj6PJ2tWH+Qdxo5ECohELhlXsOvCDsY5U7J1mUGFuw7A7GIVu4h
	 f5p3wzM43KeJ825XIm/GYr/9CtGDlp7EeulyyKPIo1YMv5hsvqmiID3Ac7lgm1y3laXKp
	 4E7QoT8hWNAD09M5SeKZ7dddszFUc5qVt1/qEr+wYhPKkFjdklTegzpSF9cNmH1nUjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdLa1wdQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D249606A33D;
	Sun,  8 Nov 2026 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdLa1wdQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794126838;
	b=a9rZte0qrq7gVKw4E5RP268k4P5cpVilYB257s9hmiqugcjFySyXRHhsA5attq2MVIAI
	 PJVKdAmKk/lpIt67idrGRVEe1QD+B/yb6gfOReSpJLJyza4KJ4vXYxphPJ3Oyz6jz/Y8z
	 Xqhc655EURK12/hMZprxjqGEd5jfVRmmf/OoeEXktDVkBPK6FMWcRSL+DIidYEd7euG+L
	 Yst1c1gJi1M5gF8TbRTE3dh8ENtVndlBg9VtBWrg3CP2L0pDPRXj7zotFenQTpFaIqTVN
	 J/Q/t+SlJ4rPVvyMuxPfPfEUV4TKS/Hnv2Xi6LKlJnmGmZGwmpERYEoEua4oLB3zFaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794126838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zZRL0ZXFxeL3crcl6uJIDsWXFxEsT8TAry9BRqXWDvs=;
	b=ZxzNB/PRZ0G1ujMtDhWbfKmqtjap4TdYYFu11nKTHBApXgm0bPgtftTENncHxA8Hxd+Q
	 ypjV+AyRJQIlYxSC8AqWaKzV6GhAN4wh8znjceAjpIgUajlTxtbKA2KAB3WWaQj8UTWeG
	 uLfx7YTtRItk+CvhxASyY8EVALUobC1LuLzsZHP3h+7mh7sxS1aqlItObMOYudlDan45b
	 +GjQR1n+QXszwm8KF6R5G+VCY/YNBDzkwrQAqcUuSHQlqGlwzZlVP46b0FA/lkqjz16Bv
	 jS7msQebfQ+qVJeUvlNmXNSiXrCkKtItvXWrsvw7wOFunBzZENKIlJjwDWCAU6kVa3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59A481F008A5;
	Sun,  8 Nov 2026 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126838;
	bh=zZRL0ZXFxeL3crcl6uJIDsWXFxEsT8TAry9BRqXWDvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jdLa1wdQzHSV+YGbSWkrIL3tGDPoNR4dGyM2hr7codyYEDjLySCJpBHxulZJtxEYA
	 9SUsChpQnrJmfngydYVXV6sGGrbJzHoQ9lo8h8FVsHEX8qSHiri/MFkmWnQxFqvenK
	 VkNTOH8YusMnoHLvevITEYk6K7IeJPJl9yrIs44Epnb87tFhacutKkoJ2on5GcJ/qW
	 Gnr7aAdTgCVD0eUUAiqsbFtGFNN6MfL1zsoZ6tQ3Y7qnQVxvkkxTKhiuOmZkMOWgla
	 fQH4ZT0P4zwMLnhfM1xn9Hy8KyjFAvCMbWeMz4a+unhsKwsgQWkF3jAVv32ssSqwDE
	 tpRslnYFr1PKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 111ED47E9C;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 09:33:57 +0100
Subject: [PATCH 5/5] Input: s6sy761 - add support for ST FTS1BA90A
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-s6sy761-fts1ba90a-v1-5-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794126835; l=5087;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=idkfCSyLLk4fP0il7fr5z+f7FWOAv2/wAhoO6YoZUc0=;
 b=h8ZY/CyD4cnxHByK9g2Azz2IW7R28DqdSiamQXF+iHVVqKCftX7yUcAKTTwxN4ViR9uv5fsf2
 MaHyJ0O3lcABDuK1JUFlICuGDCdM7y044ktkrDmnssPaRvJhVCtL0RI
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

Add the ST FTS1BA90A, the touchscreen controller of the Samsung Galaxy
Tab S9 Wi-Fi (SM-X710). Samsung's GPL driver for the tablet shows that
its firmware speaks the S6SY761 protocol, with 16-byte events, touch IDs
from 0 and its own reset, device ID and scan commands. That driver never
sends the firmware integrity or application mode command, so neither is
used here and runtime PM does nothing. Like Samsung's driver, this
enables palm and wet detection and reports palms as fingers. Firmware
update, calibration and gestures are left out.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 drivers/input/touchscreen/Kconfig   |  3 ++-
 drivers/input/touchscreen/s6sy761.c | 50 +++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..c24a8b13a4a4 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -531,7 +531,8 @@ config TOUCHSCREEN_S6SY761
 	tristate "Samsung S6SY761 Touchscreen driver"
 	depends on I2C
 	help
-	  Say Y if you have the Samsung S6SY761 driver
+	  Say Y if you have a Samsung S6SY761 or ST FTS1BA90A touchscreen
+	  controller.
 
 	  If unsure, say N
 
diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index f000ed0d7a9a..5e3838a64588 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -10,6 +10,7 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -27,6 +28,8 @@
 #define S6SY761_READ_ALL_EVENT		0x61
 #define S6SY761_CLEAR_EVENT_STACK	0x62
 #define S6SY761_APPLICATION_MODE	0xe4
+#define FTS1BA90A_DEVICE_ID		0x22
+#define FTS1BA90A_SET_SCAN_MODE		0xa0
 
 /* events */
 #define S6SY761_EVENT_INFO		0x02
@@ -90,6 +93,10 @@
 #define S6SY761_PANEL_ID_SIZE		11
 #define S6SY761_TS_STATUS_SIZE		5
 #define S6SY761_MAX_FINGERS		10
+#define FTS1BA90A_EVENT_SIZE		16
+#define FTS1BA90A_DEVID_SIZE		5
+#define FTS1BA90A_SCAN_MS_SS		BIT(0)
+#define S6SY761_MAX_EVENT_SIZE		FTS1BA90A_EVENT_SIZE
 
 #define S6SY761_DEV_NAME	"s6sy761"
 
@@ -105,7 +112,7 @@ struct s6sy761_data {
 	struct input_dev *input;
 	struct touchscreen_properties prop;
 
-	u8 data[S6SY761_EVENT_SIZE * S6SY761_EVENT_COUNT];
+	u8 data[S6SY761_MAX_EVENT_SIZE * S6SY761_EVENT_COUNT];
 
 	u16 devid;
 	u8 tx_channel;
@@ -278,6 +285,15 @@ static int s6sy761_set_sense(struct s6sy761_data *sdata, bool enable)
 	return i2c_smbus_write_byte(sdata->client, cmd);
 }
 
+static int fts1ba90a_set_sense(struct s6sy761_data *sdata, bool enable)
+{
+	u8 scan_mode[] = { 0x00, enable ? FTS1BA90A_SCAN_MS_SS : 0x00 };
+
+	return i2c_smbus_write_i2c_block_data(sdata->client,
+					      FTS1BA90A_SET_SCAN_MODE,
+					      sizeof(scan_mode), scan_mode);
+}
+
 static int s6sy761_input_open(struct input_dev *dev)
 {
 	struct s6sy761_data *sdata = input_get_drvdata(dev);
@@ -313,7 +329,7 @@ ATTRIBUTE_GROUPS(s6sy761_sysfs);
 
 static int s6sy761_boot_complete(struct s6sy761_data *sdata)
 {
-	u8 buffer[S6SY761_EVENT_SIZE];
+	u8 buffer[S6SY761_MAX_EVENT_SIZE];
 	u8 event;
 	int ret;
 
@@ -356,6 +372,23 @@ static int s6sy761_boot(struct s6sy761_data *sdata)
 	return 0;
 }
 
+static int fts1ba90a_boot(struct s6sy761_data *sdata)
+{
+	static const u8 system_reset[] = { 0xfa, 0x20, 0x00, 0x00, 0x24, 0x81 };
+	int ret;
+
+	ret = i2c_master_send(sdata->client, system_reset,
+			      sizeof(system_reset));
+	if (ret != sizeof(system_reset))
+		return ret < 0 ? ret : -EIO;
+
+	usleep_range(10000, 11000);
+
+	return read_poll_timeout(s6sy761_boot_complete, ret, !ret,
+				 20 * USEC_PER_MSEC, 3 * USEC_PER_SEC, false,
+				 sdata);
+}
+
 static int s6sy761_power_on(struct s6sy761_data *sdata)
 {
 	int ret;
@@ -612,9 +645,21 @@ static const struct s6sy761_chip_data s6sy761_chip = {
 	.has_app_mode	= true,
 };
 
+static const struct s6sy761_chip_data fts1ba90a_chip = {
+	.boot		= fts1ba90a_boot,
+	.set_sense	= fts1ba90a_set_sense,
+	.touch_function	= S6SY761_MASK_TOUCH | S6SY761_MASK_PALM |
+			  S6SY761_MASK_WET,
+	.event_size	= FTS1BA90A_EVENT_SIZE,
+	.devid_cmd	= FTS1BA90A_DEVICE_ID,
+	.devid_size	= FTS1BA90A_DEVID_SIZE,
+	.devid_offset	= 2,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id s6sy761_of_match[] = {
 	{ .compatible = "samsung,s6sy761", .data = &s6sy761_chip },
+	{ .compatible = "st,fts1ba90a", .data = &fts1ba90a_chip },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, s6sy761_of_match);
@@ -622,6 +667,7 @@ MODULE_DEVICE_TABLE(of, s6sy761_of_match);
 
 static const struct i2c_device_id s6sy761_id[] = {
 	{ .name = "s6sy761", .driver_data = (kernel_ulong_t)&s6sy761_chip },
+	{ .name = "fts1ba90a", .driver_data = (kernel_ulong_t)&fts1ba90a_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, s6sy761_id);

-- 
2.56.0


