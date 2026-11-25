Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569967;
	b=VKMmlSzztjxUE5fjfIuTL0GOQLr5GwGb5EmUagZZyl8CXb9euU0kcZErqzQzuj+JiFCB
	 5LHFkmyxhrvY1mKykOzYsIrwgfD1XniBgPTF/O1nLEf+wjTXNrRDvbk1YRHpFNTo/UR8X
	 eaF9HLfurCW3+07RxVivL8OBi9cLO2p0pUQpSMnZgaaqCQ30gboUYCKoJzwafzdU65lu8
	 f7dZJ5yOdVcMeKil4uiEw7yjSjy53jB2Yv+6fDL63zPV/fNs+voSoqqUUDzBpApKfBSDD
	 gy19atGDDL7Llp50fBo5DibqaE2dRtg2uUJFhIR0pFw1r3HEt8iIhobalGDrK2B6D3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569967;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=duFfCg5XuF+e7SucsyQ0ES83Lv3e5tbVUov16HwsMYI=;
	b=D25qCVonNn9JC6qO6/xYFop8Ewvmu0rkSxVMgStshj0c9EtmFKhfctEeF9yjcq4UMk2m
	 kFnZtCVSY1yQ7u3KmNqfHDz/w4NgTFZKNk952XqzO6A9E4CpzLeroKkMuwWeeR4EDH/J3
	 exY290HjRBGn5CduBwD+xQCEg2WnXV9GvsYi5+I1YCualZYyz1+BfIlSBGo9kMsaxCRqd
	 It8jSs0OW+ax6B4LJ6LR+H9qNPB2JCFf8hZ7HSvU4Gg0GcIyfzYsoo7u8QYO35MrKFwNb
	 Fo+aBfpNdJ7o5G2/3dWAN1LzfLoQJsFxXoJbXAMPuIg/hk7vDr3M/9VVJtUZtLAid+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=miffe.org;
	spf=pass smtp.mailfrom=miffe.org;
	dkim=pass header.d=miffe.org header.i=@miffe.org header.a=rsa-sha256 header.s=fm1 header.b=Lx9cusMS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="BNFTjGX/";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F23606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 01:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F23606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=miffe.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miffe.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=miffe.org header.i=@miffe.org header.a=rsa-sha256 header.s=fm1 header.b=Lx9cusMS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BNFTjGX/
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CE3AD1D0062D
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 20:26:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Nov 2026 20:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miffe.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1795569965; x=1795656365; bh=duFfCg5XuF+e7SucsyQ0E
	S83Lv3e5tbVUov16HwsMYI=; b=Lx9cusMSVYVdu80iXLLQrmEgyeSRWrBVh8pX0
	MpKmGBp3qbxU8Bia8FmB8USo4Y8jOlj7t57+WsG0EBXH9zqmZ78xqmgIxa0GO2Qt
	7u2t4Xw+NLlD3cnoOitpWn/xUX5849dehsVW2/XRNFMkr2uese2bZzznbqAP/Q3E
	6BmFhkxl4F3FZdLO7xq94LfBXw6n8uyaOR3sahOkiYXWXMEo/cI96q3jCkJekK04
	qNfMRHikO/lfkiLQvygOOrH8FzLaAul6leSwgOTxM7S5vWHqz38huxWad5PqoqPN
	t/y6J7CnfD7+pxDvzaZo2KoRWtydZMDVGfGRvnG+RUdX57XdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795569965; x=1795656365; bh=duFfCg5XuF+e7SucsyQ0ES83Lv3e5tbVUov
	16HwsMYI=; b=BNFTjGX/dzkPQ5nuH5nrIQmkLmuyG0fbvnT4X5gQ9TZt0w65iCn
	TXTHQMnntiCodvitfvq79QCgyhTk30qpsaVWDYRe0IKBbl2dPU2giiVRG7uNhLgI
	HTvHvtoGtpYBSWbcu+NRakgaegTMC0+XA4KuJaoV/T7GTOGtoThIPdSrcm8wcPOJ
	/THYWF5BZyUG0/CMbxR4c8YEt56IeQqSUUg47Rs7ZlK2iEiSn8qygZa+URGVCIha
	nDKm/6i92NGzPk4xoNy+6NXPIatvcPUzIHrj8/GKqs3/PR7zfuHG46BwvEhnNwZc
	leMHG9VQs+Rl6GONsSVMxhp+OqRH3uMbkCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=miffe.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795569965; d=miffe.org;
	mf=PG1pZmZlQG1pZmZlLm9yZz4=;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:s+6SzQEb3+5ko4AYU8TmcUhJBCBxC3kovNrsCxVmjJCe9q8
	/kpmr8qUa0Dvy/Hf+pbMaLUYbCzJnlCZtC+SKjB++dSh3AU9dMDZ6rZxhRpp1PgQ
	b/Cga/4Ds4QapFFzTfmv4EWHyDlsYIb5Impp74+PcCXc7VIKYuP9r0IFY3BVRo9+
	tVHeNzQR3fz+jM6zjP0b9D5rfXZ/ImU16PS1d5HhibnEyd9fFdWP3MqNuUHBMXzD
	laTzZEArWOcS3s3folnl6uiDYXth1MNb/R07+SvpaE3xP8sXiq2xec+Z9idVi0Lk
	hVdfpQes8m+6BqwGOghNtKYUvDY6qEqZ1nsqBqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:6fBxvxmfAY2gr/ibo5uLRH28FrfOejVLv0Wirl54Lgg=:TDfyyiJfzSPaFKZszvLE7UitlYu1D8r4r/4S3YBdQGQ=;
X-ME-Sender: <xms:LTkGa4wNl3EwXf6BnyJvVoXHhJxmv40WlGDX0-0msBmdUW5LR7br3Q>
    <xme:LTkGa1n8edyxSex8kdKLIlQmuk_kCG1y5hFzH7qoIpFztdcys1x5uQtYs4zxzYj4f
    _CjQp3Us8kFET8RgcbxvQnwnCEFxcoFKS7lxTYRKXeQXfFaibdd>
X-ME-Received: <xmr:LTkGaxk3Kq8w9BgQBkkLCd94b-MxcEwROirAZWbpHsaGdbT1MI6UC8bN3_jQobNkfWb28nZLVjlliKTQwM6ZjqlazTeBK60r4IXJEUHq>
X-ME-Proxy-Cause: dmFkZTE6Tn63XXPF/rDv1BOxzWGPvcY1QTxHYt43C6npE8yvuFGpdPW2K0fS/h/5VsBCI8
    k7xG+jQjp/bEk8iS0SDIb2M/ykhzr3splhoQwv92MPgrfPhhoVVReyfGMeqh6OFWLnIqf5
    cHIey47Nw0fP6C7Vt826/5REWPuAL7xhhO5YVKQ6ktDrYxihk4CScRy0qb1LPiS2XA9LBO
    pLrfSG9tqa/8PPv/yogz1lWmNefasGMR+OG8edKm0IugXQY1NESgHT2e0z1jjcVnO6oTtP
    hTF6fZFhdTPQ9KYMjNX5QznLBRUr/lmGARTfE2rZ9osPMncTZtALxfTYNqtqZTnS6veoTY
    /TbYrfZ3gvYb08s1dwX7eFpwRrqmGBl8p0/oW2F9fjgsH1gkSUpmrWaUOs/tszCeUpw/gw
    YZz8UNCs1caWi6V21zxcDb+P8Ut6DtRLnDESCAPuI4wU9OOahExmmtKrQTKwzEyGngOrXo
    wFc4IGvawWAo4y3cV/vkQfY5GViHn0ya57HWnxmYRsYCKmVxu3oX7veDQAv3kWy/7Wgp24
    ChOjtHe87l/gix6DYMc3NgD4ohaNS5X7RkgUToUUAPOnK/hHan4AqLUXR5vVaits5L2QPY
    okJIhhD4V0f9sKfzT/jJQtRpiDJxDXFNwGPCpOYohBt3TdxXzU7LBgsL+V1A
X-ME-Proxy: <xmx:LTkGa3wKtoojAsYejBTMrjn-tKfjjj2m-PrNVWzHSz8M-YtQpZv4bw>
    <xmx:LTkGa2pVRt0h55tuCS-ZvuEgsObuyiOl2Br3QPq8hCFmoHwa4iW1ZA>
    <xmx:LTkGa26eNRCybw_vYlXZ5_ibMn0lL08c6qhfckquGzKyTJwhQH-h4g>
    <xmx:LTkGa9ck12_DkPF_5km4HH2wm7kWGvXvhUxFqnlSx3q-N-EwuV5QyA>
    <xmx:LTkGa95NGHrAD6x-D8Bix_93AOMjqEx0yeJO60CN0Dukkh6az9gyStKE>
Feedback-ID: ic71042b1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 20:26:04 -0500 (EST)
Received: (nullmailer pid 177926 invoked by uid 1000);
	Wed, 25 Nov 2026 01:26:02 -0000
From: Miffe <miffe@miffe.org>
To: linux-input@vger.kernel.org, miffe@miffe.org
Cc: jikos@kernel.org, bentiss@kernel.org, benjaminblume@posteo.de, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hyperx: Add battery support for the Cloud Alpha Wireless headset
Date: Wed, 25 Nov 2026 02:26:02 +0100
Message-ID: <20261125012602.177917-1-miffe@miffe.org>
X-Mailer: git-send-email 2.56.1
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

The HyperX Cloud Alpha Wireless dongle (03f0:098d) reports the headset's
battery level and charging state through vendor-defined reports on page
0xff43, report id 0x21. Expose them as a power_supply so UPower and
desktop battery indicators pick them up, while normal HID input (the
consumer control keys) keeps working.

The dongle answers queries for the connection state (0x03), battery
level (0x0b) and charging state (0x0c), and announces connection and
charging changes unsolicited with their own codes (0x24, 0x26) and the
same values. The battery level is not announced, so it is polled every
60 seconds, and immediately after the headset connects and on resume.

The battery is registered only while the headset is connected, and
only once its first level is known: UPower treats a device-scope
supply whose capacity cannot be read as an AC adapter and never
re-reads it.

Tested on a Cloud Alpha Wireless: power on/off and plugging/unplugging
the charging cable are reflected within about a second, and the state
is refreshed after suspend/resume, including when the headset was
switched off while suspended.

The headset support was written with the help of an AI coding
assistant (Claude Opus 5.5, Claude Code), based on reverse engineering
the protocol from the dongle's report descriptor and hidraw traces; the
QuadCast 2 code is unchanged apart from being restricted to its device.

Signed-off-by: Miffe <miffe@miffe.org>
---
 drivers/hid/Kconfig      |  17 +-
 drivers/hid/hid-hyperx.c | 407 ++++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-ids.h    |   1 +
 3 files changed, 414 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d17d960ab..590085fbd 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -434,17 +434,24 @@ config HOLTEK_FF
 	  and want to have force feedback support for it.
 
 config HID_HYPERX
-	tristate "HyperX microphones"
+	tristate "HyperX microphones and headsets"
 	depends on USB_HID
+	select POWER_SUPPLY
 	help
-	  Support for the mute button of HyperX microphones.
+	  Support for the mute button of HyperX microphones and the battery
+	  of HyperX wireless headsets.
+
+	  The microphone mute button is handled in the device firmware and only
+	  reports the resulting mute state through a vendor-defined collection,
+	  so without this driver userspace never learns that the microphone was
+	  muted.
 
-	  The button is handled in the device firmware and only reports the
-	  resulting mute state through a vendor-defined collection, so without
-	  this driver userspace never learns that the microphone was muted.
+	  The headset battery level and charging state are reported through
+	  vendor-defined reports and exposed as a power supply.
 
 	  Supported devices:
 	  - HyperX QuadCast 2
+	  - HyperX Cloud Alpha Wireless
 
 config HID_VIVALDI_COMMON
 	tristate
diff --git a/drivers/hid/hid-hyperx.c b/drivers/hid/hid-hyperx.c
index 18d2dc24c..a85475532 100644
--- a/drivers/hid/hid-hyperx.c
+++ b/drivers/hid/hid-hyperx.c
@@ -1,19 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  HID driver for the HyperX QuadCast 2 microphone
+ *  HID driver for HyperX microphones and headsets
  *
+ *  QuadCast 2 microphone:
  *  The tap-to-mute button is handled entirely in the device firmware: it gates
  *  the audio internally and does not send the Telephony "Phone Mute" usage its
  *  own report descriptor advertises.  The resulting mute state is only reported
  *  through a vendor-defined collection, which hid-input cannot map, so the
  *  button is invisible to userspace.
  *
+ *  Cloud Alpha Wireless headset:
+ *  The USB dongle reports the headset's battery level and charging state
+ *  through vendor-defined reports, which are exposed as a power_supply.
+ *  Protocol (vendor page 0xff43, report id 0x21, 31 byte reports):
+ *    request:  21 bb <cmd> 00 ...
+ *    response: 21 bb <cmd> <value> ...
+ *    cmd 0x03: connection state (1 = headset off/unpaired, 2 = connected)
+ *    cmd 0x0b: battery level in percent
+ *    cmd 0x0c: charging (0 = no, 1 = yes)
+ *  State changes are announced unsolicited with their own command codes:
+ *    0x24: connection state, same values as 0x03
+ *    0x26: charging, same values as 0x0c
+ *  The battery level is not announced, so it is polled.
+ *
  *  Copyright (c) 2026 Benjamin Blume <benjaminblume@posteo.de>
+ *  Copyright (c) 2026 Miffe <miffe@miffe.org>
  */
 
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include "hid-ids.h"
 
@@ -21,10 +41,47 @@
 #define HYPERX_QC2_EVENT_MUTE	0x06
 #define HYPERX_QC2_MUTE_LEN	3
 
+#define HYPERX_CAW_REPORT_ID		0x21
+#define HYPERX_CAW_MAGIC		0xbb
+#define HYPERX_CAW_REPORT_SIZE		31
+
+#define HYPERX_CAW_CMD_CONNECTION	0x03
+#define HYPERX_CAW_CMD_BATTERY		0x0b
+#define HYPERX_CAW_CMD_CHARGING		0x0c
+#define HYPERX_CAW_EVT_CONNECTION	0x24
+#define HYPERX_CAW_EVT_CHARGING		0x26
+
+#define HYPERX_CAW_CONNECTED		0x02
+
+#define HYPERX_CAW_POLL_INTERVAL	60	/* seconds */
+
+enum hyperx_model {
+	HYPERX_QUADCAST_2,
+	HYPERX_CLOUD_ALPHA_WIRELESS,
+};
+
 struct hyperx_drvdata {
+	struct hid_device *hdev;
+	enum hyperx_model model;
+
+	/* QuadCast 2 */
 	struct input_dev *input;
 	bool muted;
 	bool have_state;
+
+	/* Cloud Alpha Wireless */
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	struct delayed_work poll_work;
+	struct work_struct battery_work;
+	/* Protects battery, removed and the headset state below. */
+	spinlock_t lock;
+	bool battery_iface;
+	bool removed;
+	bool connected;
+	bool capacity_valid;
+	u8 capacity;
+	bool charging;
 };
 
 static int hyperx_input_configured(struct hid_device *hdev,
@@ -32,6 +89,9 @@ static int hyperx_input_configured(struct hid_device *hdev,
 {
 	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	if (drvdata->model != HYPERX_QUADCAST_2)
+		return 0;
+
 	/*
 	 * The device exposes several application collections.  Prefer the
 	 * telephony one, which already advertises KEY_MICMUTE, and fall back
@@ -45,10 +105,10 @@ static int hyperx_input_configured(struct hid_device *hdev,
 	return 0;
 }
 
-static int hyperx_raw_event(struct hid_device *hdev, struct hid_report *report,
-			    u8 *data, int size)
+static int hyperx_qc2_raw_event(struct hyperx_drvdata *drvdata, u8 *data,
+				int size)
 {
-	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct hid_device *hdev = drvdata->hdev;
 	bool muted;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !drvdata->input)
@@ -78,6 +138,306 @@ static int hyperx_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static enum power_supply_property hyperx_caw_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int hyperx_caw_battery_get_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
+{
+	struct hyperx_drvdata *drvdata = power_supply_get_drvdata(psy);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		/* Registered only while the headset is connected. */
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (drvdata->charging)
+			val->intval = drvdata->capacity >= 100 ?
+				POWER_SUPPLY_STATUS_FULL :
+				POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		/* Registration waits for the first level after connecting. */
+		val->intval = drvdata->capacity;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "Cloud Alpha Wireless";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "HyperX";
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	return ret;
+}
+
+static int hyperx_caw_send_cmd(struct hid_device *hdev, u8 cmd)
+{
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(HYPERX_CAW_REPORT_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = HYPERX_CAW_REPORT_ID;
+	buf[1] = HYPERX_CAW_MAGIC;
+	buf[2] = cmd;
+
+	ret = hid_hw_output_report(hdev, buf, HYPERX_CAW_REPORT_SIZE);
+	kfree(buf);
+
+	return ret < 0 ? ret : 0;
+}
+
+static void hyperx_caw_poll_work(struct work_struct *work)
+{
+	struct hyperx_drvdata *drvdata = container_of(to_delayed_work(work),
+						      struct hyperx_drvdata,
+						      poll_work);
+	struct hid_device *hdev = drvdata->hdev;
+	int ret;
+
+	/*
+	 * Responses arrive asynchronously through raw_event.  Battery and
+	 * charging are only queried while connected; raw_event polls again
+	 * right away when the headset connects.
+	 */
+	ret = hyperx_caw_send_cmd(hdev, HYPERX_CAW_CMD_CONNECTION);
+	if (!ret && READ_ONCE(drvdata->connected))
+		ret = hyperx_caw_send_cmd(hdev, HYPERX_CAW_CMD_BATTERY);
+	if (!ret && READ_ONCE(drvdata->connected))
+		ret = hyperx_caw_send_cmd(hdev, HYPERX_CAW_CMD_CHARGING);
+	if (ret)
+		hid_dbg(hdev, "failed to query headset: %d\n", ret);
+
+	if (!READ_ONCE(drvdata->removed))
+		queue_delayed_work(system_dfl_wq, &drvdata->poll_work,
+				   secs_to_jiffies(HYPERX_CAW_POLL_INTERVAL));
+}
+
+/*
+ * The battery exists only while the headset is connected, so desktops
+ * drop it when the headset is switched off.  It is registered only once
+ * the first level is known: UPower treats a device-scope supply whose
+ * capacity cannot be read as an AC adapter and never looks at it again.
+ */
+static void hyperx_caw_battery_work(struct work_struct *work)
+{
+	struct hyperx_drvdata *drvdata = container_of(work,
+						      struct hyperx_drvdata,
+						      battery_work);
+	struct power_supply_config psy_cfg = { .drv_data = drvdata };
+	struct hid_device *hdev = drvdata->hdev;
+	struct power_supply *battery;
+	unsigned long flags;
+	bool wanted;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	wanted = drvdata->connected && drvdata->capacity_valid &&
+		 !drvdata->removed;
+	battery = drvdata->battery;
+	if (!wanted)
+		drvdata->battery = NULL;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	if (!wanted) {
+		if (battery)
+			power_supply_unregister(battery);
+		return;
+	}
+	if (battery)
+		return;
+
+	battery = power_supply_register(&hdev->dev, &drvdata->battery_desc,
+					&psy_cfg);
+	if (IS_ERR(battery)) {
+		hid_err(hdev, "failed to register battery: %ld\n",
+			PTR_ERR(battery));
+		return;
+	}
+	if (power_supply_powers(battery, &hdev->dev))
+		hid_warn(hdev, "failed to link battery to device\n");
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->battery = battery;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+}
+
+static int hyperx_caw_raw_event(struct hyperx_drvdata *drvdata, u8 *data,
+				int size)
+{
+	unsigned long flags;
+	bool changed = false;
+
+	if (!READ_ONCE(drvdata->battery_iface) || size < 4 ||
+	    data[0] != HYPERX_CAW_REPORT_ID || data[1] != HYPERX_CAW_MAGIC)
+		return 0;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	switch (data[2]) {
+	case HYPERX_CAW_CMD_CONNECTION:
+	case HYPERX_CAW_EVT_CONNECTION: {
+		bool connected = data[3] == HYPERX_CAW_CONNECTED;
+
+		if (connected != drvdata->connected) {
+			WRITE_ONCE(drvdata->connected, connected);
+			changed = true;
+			if (!connected) {
+				drvdata->capacity_valid = false;
+				drvdata->charging = false;
+			}
+			if (!drvdata->removed) {
+				/* Drop the battery, or fetch fresh data now. */
+				if (connected)
+					mod_delayed_work(system_dfl_wq,
+							 &drvdata->poll_work, 0);
+				else
+					queue_work(system_dfl_wq,
+						   &drvdata->battery_work);
+			}
+		}
+		break;
+	}
+	case HYPERX_CAW_CMD_BATTERY:
+		/* Ignore the level while the headset is off or unpaired. */
+		if (!drvdata->connected || data[3] > 100)
+			break;
+		if (drvdata->capacity != data[3]) {
+			drvdata->capacity = data[3];
+			changed = true;
+		}
+		drvdata->capacity_valid = true;
+		if (!drvdata->battery && !drvdata->removed)
+			queue_work(system_dfl_wq, &drvdata->battery_work);
+		break;
+	case HYPERX_CAW_CMD_CHARGING:
+	case HYPERX_CAW_EVT_CHARGING:
+		if (drvdata->charging != !!data[3]) {
+			drvdata->charging = !!data[3];
+			changed = true;
+		}
+		break;
+	}
+	/* Under the lock so battery_work cannot unregister it meanwhile. */
+	if (changed && drvdata->battery)
+		power_supply_changed(drvdata->battery);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	return 0;
+}
+
+static int hyperx_raw_event(struct hid_device *hdev, struct hid_report *report,
+			    u8 *data, int size)
+{
+	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata)
+		return 0;
+
+	switch (drvdata->model) {
+	case HYPERX_QUADCAST_2:
+		return hyperx_qc2_raw_event(drvdata, data, size);
+	case HYPERX_CLOUD_ALPHA_WIRELESS:
+		return hyperx_caw_raw_event(drvdata, data, size);
+	}
+
+	return 0;
+}
+
+static int hyperx_caw_probe(struct hyperx_drvdata *drvdata)
+{
+	struct hid_device *hdev = drvdata->hdev;
+	int ret;
+
+	spin_lock_init(&drvdata->lock);
+	INIT_DELAYED_WORK(&drvdata->poll_work, hyperx_caw_poll_work);
+	INIT_WORK(&drvdata->battery_work, hyperx_caw_battery_work);
+
+	/*
+	 * Only the vendor interface carries the battery report.  Check that
+	 * it exists first, as hid_validate_values() logs an error otherwise.
+	 */
+	if (!hid_is_usb(hdev) ||
+	    !hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[HYPERX_CAW_REPORT_ID] ||
+	    !hid_validate_values(hdev, HID_OUTPUT_REPORT, HYPERX_CAW_REPORT_ID,
+				 0, HYPERX_CAW_REPORT_SIZE - 1))
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	drvdata->battery_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						    "hyperx-calphaw-%d",
+						    hdev->id);
+	if (!drvdata->battery_desc.name)
+		return -ENOMEM;
+	drvdata->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	drvdata->battery_desc.properties = hyperx_caw_battery_props;
+	drvdata->battery_desc.num_properties =
+		ARRAY_SIZE(hyperx_caw_battery_props);
+	drvdata->battery_desc.get_property = hyperx_caw_battery_get_property;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	/* Keep the device open so unsolicited reports reach raw_event. */
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "hw open failed\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	WRITE_ONCE(drvdata->battery_iface, true);
+	queue_delayed_work(system_dfl_wq, &drvdata->poll_work, 0);
+
+	return 0;
+}
+
+static void hyperx_caw_remove(struct hyperx_drvdata *drvdata)
+{
+	struct power_supply *battery;
+	unsigned long flags;
+
+	if (!drvdata->battery_iface)
+		return;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->removed = true;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	cancel_work_sync(&drvdata->battery_work);
+	cancel_delayed_work_sync(&drvdata->poll_work);
+	hid_hw_close(drvdata->hdev);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	battery = drvdata->battery;
+	drvdata->battery = NULL;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	if (battery)
+		power_supply_unregister(battery);
+}
+
 static int hyperx_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hyperx_drvdata *drvdata;
@@ -87,18 +447,49 @@ static int hyperx_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->hdev = hdev;
+	drvdata->model = id->driver_data;
 	hid_set_drvdata(hdev, drvdata);
 
 	ret = hid_parse(hdev);
 	if (ret)
 		return ret;
 
+	if (drvdata->model == HYPERX_CLOUD_ALPHA_WIRELESS)
+		return hyperx_caw_probe(drvdata);
+
 	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 }
 
+static void hyperx_remove(struct hid_device *hdev)
+{
+	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->model == HYPERX_CLOUD_ALPHA_WIRELESS)
+		hyperx_caw_remove(drvdata);
+
+	hid_hw_stop(hdev);
+}
+
+/* The headset may have been switched on, off or plugged in meanwhile. */
+static int hyperx_resume(struct hid_device *hdev)
+{
+	struct hyperx_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata->model == HYPERX_CLOUD_ALPHA_WIRELESS &&
+	    drvdata->battery_iface)
+		mod_delayed_work(system_dfl_wq, &drvdata->poll_work, 0);
+
+	return 0;
+}
+
 static const struct hid_device_id hyperx_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
-			 USB_PRODUCT_ID_HP_HYPERX_QUADCAST_2) },
+			 USB_PRODUCT_ID_HP_HYPERX_QUADCAST_2),
+	  .driver_data = HYPERX_QUADCAST_2 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
+			 USB_PRODUCT_ID_HP_HYPERX_CLOUD_ALPHA_WIRELESS),
+	  .driver_data = HYPERX_CLOUD_ALPHA_WIRELESS },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hyperx_devices);
@@ -107,11 +498,15 @@ static struct hid_driver hyperx_driver = {
 	.name			= "hyperx",
 	.id_table		= hyperx_devices,
 	.probe			= hyperx_probe,
+	.remove			= hyperx_remove,
 	.input_configured	= hyperx_input_configured,
 	.raw_event		= hyperx_raw_event,
+	.resume			= pm_ptr(hyperx_resume),
+	.reset_resume		= pm_ptr(hyperx_resume),
 };
 module_hid_driver(hyperx_driver);
 
-MODULE_DESCRIPTION("HID driver for the HyperX QuadCast 2 microphone");
+MODULE_DESCRIPTION("HID driver for HyperX microphones and headsets");
 MODULE_AUTHOR("Benjamin Blume <benjaminblume@posteo.de>");
+MODULE_AUTHOR("Miffe <miffe@miffe.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c40d81841..476494178 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -710,6 +710,7 @@
 
 #define USB_VENDOR_ID_HP		0x03f0
 #define USB_PRODUCT_ID_HP_HYPERX_QUADCAST_2			0x07b4
+#define USB_PRODUCT_ID_HP_HYPERX_CLOUD_ALPHA_WIRELESS		0x098d
 #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
-- 
2.56.1

