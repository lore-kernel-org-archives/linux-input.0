Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467934;
	b=WP3UG4W3k95k11oG4f4jpUDtpkzaWbwRnoq7LBaqra0YvMXso6JZMZrMgJdyqjysVbQA
	 qy/vxpyDOmff2XszVOjU7O/W/rZVm1yu5SG4W8uOrbjlePPc6s61Nx0mqZuJW9kDZmAMA
	 /MFsZIE7x/r+l4FUV/gmho2V2rCbBKSNwmFwzoV7n+P2PcVbAztCTUr08Iw9nBHf2sGrQ
	 9cTatuoAjnf1AxJp/iHtMLSuPNakXEF2/cAUX+GSSQZjfwJwuEeTYsqojtO3ahfz4Iipd
	 yn9x6AMFXYhTbM+pd6IHRcZ9YZ9UlX08+16DiBpvriQMVTQCtee3FvbEYaJUIa+haSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467934;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=06RCvUv+3GOF8YxEHS3pupiOZtY6wOlCm3wqCkRtaX8=;
	b=DdKIUhf9MH6gKlYGbNUyt1VsdgI1UZeN2RL8axdCzgcPCSupenfKCwHES2q3zWmJa+ya
	 r4qwqga7+B5x6NUmy+B0XvbUwvcbg7VRhtA4aaaOILMWFXmH5o+GX9cpllNF9SkzJmKeG
	 uBtg8nnEo75WEvv5E5kRUqIGCXnRb58jwhDSn1puafBYAcuKdP7fghT/Je85jz+L59q0W
	 FLp6X37s4IQY4TH3lpT1Qc2BR0YDDSwdHmo6AZU9KYONw4/GYWhHJ4nH6dhyGmbhWmOzd
	 T0oq4zd4GkuduVHsZOO7n8tHUmcMD8hyxgp+cs/Ts7PxPN59vnSnq16z1J0VFmj+W3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=miffe.org;
	spf=pass smtp.mailfrom=miffe.org;
	dkim=pass header.d=miffe.org header.i=@miffe.org header.a=rsa-sha256 header.s=fm1 header.b=iQHhi8ny;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pKtLPgxv;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4E606A331
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 21:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A4E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=miffe.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miffe.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=miffe.org header.i=@miffe.org header.a=rsa-sha256 header.s=fm1 header.b=iQHhi8ny;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pKtLPgxv
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7089E1D00665
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:05:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 23 Nov 2026 16:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miffe.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1795467930; x=1795554330; bh=06RCvUv+3GOF8YxEHS3pu
	piOZtY6wOlCm3wqCkRtaX8=; b=iQHhi8ny2FnqPq/kUotPYX3WyKCMop7Qdc2Y1
	nPGxox5uSU/X6XaPFp3iz0ej1vTaCtgQ7RpC5kzUZjGleZzWq+tfNNHmtE9FVOfk
	AY1EKQ6p7ds4Lkm0wf5Kr54jeXGlRxl3WZKJHhcGTM7RxO45WIeOPxI16GUFeE07
	M0u3nKzSHWarY2+iTK4YgIe0mJ3OVbLc/22PnAsy5+TAHyXk20SS2xJJQ2QCDBcH
	mE+LjBb9VYOvWPKkixDyMF8Tezlbvst7QRQJ+ShrlYyo45KwFucPaDSMKKWcFb5l
	g1yVkuYqwlgMENxIG9/FZpaH4737gJNqAKdCB+8JCZGUDqw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795467930; x=1795554330; bh=06RCvUv+3GOF8YxEHS3pupiOZtY6wOlCm3w
	qCkRtaX8=; b=pKtLPgxvonY9iRdEhYH8XYjzlKIfOtRsSDSCcx+HKii5w/7KZW7
	FCy2rgb5x2CFJS6iSA8XCrnW+bPGwgTtxSseamZnLP6L1TJLTN+P1RQdxpXidHsC
	3C4wRtP3YO8SZKE7ylhJsK+FNVKSl6Jkx/0MCb1Md2LX0RP/YkbVNFJE84754t6T
	+/dyIhrzkwJjf+xrJBWDtxkgVJCZI6B0MPjmb9O8xSbLVblT9putL7lAJq9Cqyyi
	Hi0YvCcAOVxgqVLWMsnCxm7eJ2HE8OVb+3yPhCZNdpyrD+gkY9Q/q5QjnoVNSmOQ
	9XZcPTsfntIoXKfUflDswmU1JWOcYVrWzGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=miffe.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795467930; d=miffe.org;
	mf=PG1pZmZlQG1pZmZlLm9yZz4=;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:QN2qWs3yiaMX4hzcukwHTjqKkyslYu8Ic70FLWFY55XsuJA
	niBcQVRfD1xrRNmdML2TJrW2MtDczn8l+EXt9t5B/cx7AlO+TMN5SoBb6Q6ebUUo
	miyc9c2G8YKrS5qn+fFHufzV8OMC9hh6n91CF+G3QIcbOJ8OQf9/1WVj4sCmE3Su
	EsX8ycRBW04UBFiu/c+AfHRBoXpfd1IJqjYvZ9vAkHKMsxkXXnt1JHzgTCZI2TuM
	ukMe0SQqCilYwIgJVj1KD15u56HBOimhPG2t/x874hqgU69+sMW5uQLaMoScAFWJ
	P1rF4ocXaK4Z6Y8kn/VH9Klz3VPewgVDzZ2aXJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:nW+yLRgEzh6yqplV+ikKt+/QlhZ+jm5Sg/GSy428GPs=:zHKTu2+MMx5jsXxAT81Ykiu3c6pYB4+Q5HnX8lIuMK8=;
X-ME-Sender: <xms:mqoEa4j57XvY1oKUztREW-z3Q8lXliE9iVqwEDfCZteUhHJ4Su4yTA>
    <xme:mqoEa-18A2V4lt2TjfHjw3bBv5nfrXmNyilBMNtsvZb7Pk-gFiSrjAJ01KvZugvk2
    dkxjbYNwJwCixtJ4bE4gTy0HxCgeieEhv2yqROyAH6fXJEu_KuJmw>
X-ME-Received: <xmr:mqoEa6hUdoJpMJhb2U2B2AwHHZBd90990lZBkagnE7yxR6dAp3WExcArfGtxxAvn1AFcExkaiGtifVKwPiV6kozgTttjDGLmAU0>
X-ME-Proxy-Cause: dmFkZTFkUCpoQTpxXeaZdXs8pPnqcIfcQfeksO+PjLThQwR39OlBvWglG72fGu0L2UxFvL
    GxsDQ5nNjlO3ir9oCib1yiJ+0udJ9VyxsU0VFnNDbYmDFH7ABifef4Enc+5zfUoHVssSO6
    QN8eEU/AdNY54Wm+12nAPz7+/Np45CUMCvk1mwrppuhzcmB2XrBxXis1kbrkmWqbOzD0Zz
    6bHAVgPpfTmifML/W6wb6TQ92kwNmhE9vuamaCSUSPhjo6m2JYMPvpiWgWjwoDVUff2c0G
    sxp04++IlmDU/fTJjKeIHs2L7H0dkyFvTS0G4YHYeluXXIJqgRHOFPoIxkAczhdCBaktPC
    QisYwZn+TDJIPsnlB9tzLnmhdIEGEpoWVJDyPvC8hN5jvjKy5iMnleCnzMty2PRU/+HJ8C
    qkX2FUwYmexOZCoBJj4BftDBcSu0Q+X4whaF4oX4JbZNLp78uFJooC046hWFAniMwM1nMw
    g0foJPc1fKxyugfgr4VxTSCerO3mr/+x/ifoA+xp9Tb1rbquXcAejrUwcoa7vSLglbonEa
    brXBqwSxhPoOm+/+hGIbujU8oHp2pKmQOnFjygA+Lp8j3AoA7Iv4zi9a+Kx2F4oXWFWW4U
    XYzFg9UJSowd/IWIGayBGlteOv2/XPCHGZv7C2Dytq5q4n6DYeC+r7ncPn1Q
X-ME-Proxy: <xmx:mqoEa2dJ5-VQwu8O7U6NYzrYz9hA_oyWKq9EZfPqvovVLkqBRyNDyA>
    <xmx:mqoEa1neSzT8AaWttgJJC8a1XkQCp_EE00mpCukgWFzYri5S7DsUqw>
    <xmx:mqoEa3uISrH50-NE7ek-YqUAEYjLM-ZQ2epTGw8hHusxirLS7uP6Sw>
    <xmx:mqoEaz8x0ZETkghhRSoD-aT8LlwsrCfRYN-XrRZnZShHrm3W_tyLCw>
    <xmx:mqoEa9doF75QuR7xvoYNAxOjbOMBBvDKr4LDIVVOtkKHe4_ivc74CZ9V>
Feedback-ID: ic71042b1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 16:05:30 -0500 (EST)
Received: (nullmailer pid 12617 invoked by uid 1000);
	Mon, 23 Nov 2026 21:05:29 -0000
From: Miffe <miffe@miffe.org>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: corsair-sabre: Add Corsair Sabre v2 Pro battery driver
Date: Mon, 23 Nov 2026 22:05:29 +0100
Message-ID: <20261123210529.12608-1-miffe@miffe.org>
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

The Corsair Sabre v2 Pro Ultralight wireless receiver (1b1c:2b2a) does
not use Corsair's Bragi protocol. Its vendor interface takes output
report 0x08 with a command byte and a checksum that makes all 17 bytes
sum to 0x55, and answers with input report 0x08 in the same layout.
Command 0x03 reports whether the mouse is connected, and command 0x04
returns the battery level in percent, a charging flag and the battery
voltage in mV.

Add a driver that exposes this as a device-scope power_supply with
present, online, status, capacity and voltage_now, so that UPower and
desktop environments show the mouse battery.

The receiver does not report the mouse being switched off, or going to
sleep after about 3 minutes without input. Both look the same: the
status command reports it as disconnected. The driver therefore polls
every 30 seconds, or every 5 seconds while the mouse is disconnected. It
also refreshes right away when the receiver sends its unsolicited power
event (charging cable plugged or unplugged, mouse switched on). Polling
stops across system suspend. The battery is read once in probe, before
it is registered, so that its first values are real ones. Capacity keeps
the last known value while the mouse is disconnected, because UPower
ignores a device battery whose capacity cannot be read when it first
appears; online is cleared instead.

The charging flag stays set at 100% while the cable is plugged in, so
the driver never reports POWER_SUPPLY_STATUS_FULL.

hidraw keeps working alongside the driver. The mouse and keyboard
interfaces are passed through unchanged.

Tested with a Sabre v2 Pro on 7.3.5, and on hid/for-next with lockdep,
KASAN, UBSAN, debug objects and kmemleak enabled: level, charging state
and voltage match the vendor protocol; charging cable plug and unplug,
mouse power off and on, idle sleep, receiver hot-plug, module reload and
unbind/rebind loops, S3 and s2idle suspend. No reports from the debug
options.

The protocol was reverse-engineered by sniffing the receiver's vendor
interface. The driver and this changelog were written with the help of
an AI coding assistant (Claude Code, Claude Opus 5.5), then reviewed and
tested on hardware by the author.

Signed-off-by: Miffe <miffe@miffe.org>
---
 drivers/hid/Kconfig             |   2 +
 drivers/hid/Makefile            |   2 +-
 drivers/hid/hid-corsair-sabre.c | 482 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h           |   1 +
 4 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/hid-corsair-sabre.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d17d960ab5e2..6dc6c5149bb5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -251,11 +251,13 @@ config HID_CORSAIR
 	Support for Corsair devices that are not fully compliant with the
 	HID standard.
 	Support for Corsair Void headsets.
+	Support for the Corsair Sabre v2 Pro mouse battery.
 
 	Supported devices:
 	- Vengeance K90
 	- Scimitar PRO RGB
 	- Corsair Void headsets
+	- Sabre v2 Pro Ultralight wireless receiver
 
 config HID_COUGAR
 	tristate "Cougar devices"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index dc30faaac969..eb7690c6be54 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CMEDIA)	+= hid-cmedia.o
-obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o hid-corsair-void.o
+obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o hid-corsair-void.o hid-corsair-sabre.o
 obj-$(CONFIG_HID_COUGAR)	+= hid-cougar.o
 obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
 obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
diff --git a/drivers/hid/hid-corsair-sabre.c b/drivers/hid/hid-corsair-sabre.c
new file mode 100644
index 000000000000..a9605cba1a71
--- /dev/null
+++ b/drivers/hid/hid-corsair-sabre.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HID driver for the Corsair Sabre v2 Pro wireless receiver
+ *
+ * Exposes the battery level, charging state and voltage of the paired
+ * mouse as a power_supply.
+ *
+ * The receiver's vendor interface accepts output report 0x08 with 16 data
+ * bytes: a command byte, zero padding, and a trailing checksum chosen so
+ * that all 17 bytes (including the report ID) sum to 0x55. Replies arrive
+ * as input report 0x08 with the same layout:
+ *
+ *   [0] report ID (0x08)
+ *   [1] command
+ *   [5] payload length
+ *   [6] payload ...
+ *   [16] checksum
+ *
+ * Command 0x03 (status): payload[0] is 1 if the mouse is connected.
+ * Command 0x04 (battery): payload[0] is the level in percent, payload[1] is
+ * 1 while charging, payload[2..3] is the battery voltage in mV (big endian).
+ *
+ * The level is derived from the voltage and therefore reads high while the
+ * mouse is charging, and settles over a minute or two after the charging
+ * cable is removed. The charging flag stays set at 100%, so it cannot be
+ * used to detect a full battery.
+ *
+ * The receiver also sends unsolicited event reports (command 0x0a) whose
+ * payload[0] holds flags: 0x40 when the power state changes (charging cable
+ * plugged or unplugged, mouse switched on) and 0x01 when the DPI changes.
+ * A power event triggers an immediate refresh. Switching the mouse off is
+ * not reported, so polling is still needed to notice it.
+ */
+
+#include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define SABRE_REPORT_ID		0x08
+#define SABRE_REPORT_SIZE	17
+#define SABRE_CHECKSUM		0x55
+
+#define SABRE_CMD_STATUS	0x03
+#define SABRE_CMD_BATTERY	0x04
+#define SABRE_CMD_EVENT		0x0a
+
+#define SABRE_EVENT_POWER	BIT(6)
+
+#define SABRE_PAYLOAD		6
+#define SABRE_TIMEOUT_MS	500
+#define SABRE_POLL_INTERVAL_S	30
+/*
+ * Used while the mouse is disconnected, as the receiver doesn't always report
+ * it (re)connecting, and after a failed read.
+ */
+#define SABRE_POLL_RETRY_S	5
+/*
+ * The receiver can take a few seconds to answer again after a system resume,
+ * so only warn if reads keep failing.
+ */
+#define SABRE_MAX_FAILURES	3
+
+struct sabre_drvdata {
+	struct hid_device *hdev;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	struct delayed_work poll_work;
+
+	/* Serialises commands sent to the receiver */
+	struct mutex cmd_lock;
+	/* Protects pending_cmd, response and polling */
+	spinlock_t lock;
+	struct completion done;
+	u8 pending_cmd;
+	u8 response[SABRE_REPORT_SIZE];
+	bool polling;
+
+	/* Consecutive failed reads, only touched by poll_work */
+	unsigned int failures;
+	bool connected;
+	bool charging;
+	int capacity;
+	int voltage_mv;
+};
+
+static enum power_supply_property sabre_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static u8 sabre_checksum(const u8 *buf, size_t len)
+{
+	u8 sum = 0;
+
+	while (len--)
+		sum += *buf++;
+	return sum;
+}
+
+static int sabre_command(struct sabre_drvdata *drvdata, u8 cmd, u8 *resp)
+{
+	struct hid_device *hdev = drvdata->hdev;
+	unsigned long flags;
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(SABRE_REPORT_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = SABRE_REPORT_ID;
+	buf[1] = cmd;
+	buf[SABRE_REPORT_SIZE - 1] = SABRE_CHECKSUM -
+		sabre_checksum(buf, SABRE_REPORT_SIZE - 1);
+
+	mutex_lock(&drvdata->cmd_lock);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->pending_cmd = cmd;
+	reinit_completion(&drvdata->done);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	ret = hid_hw_raw_request(hdev, SABRE_REPORT_ID, buf, SABRE_REPORT_SIZE,
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		goto out;
+
+	if (!wait_for_completion_timeout(&drvdata->done,
+					 msecs_to_jiffies(SABRE_TIMEOUT_MS))) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	memcpy(resp, drvdata->response, SABRE_REPORT_SIZE);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	ret = 0;
+
+out:
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->pending_cmd = 0;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	mutex_unlock(&drvdata->cmd_lock);
+	kfree(buf);
+	return ret;
+}
+
+static int sabre_refresh(struct sabre_drvdata *drvdata)
+{
+	u8 resp[SABRE_REPORT_SIZE];
+	bool connected, charging = false;
+	/* Keep the last known values while the mouse is disconnected */
+	int capacity = drvdata->capacity, voltage_mv = drvdata->voltage_mv;
+	bool changed;
+	int ret;
+
+	ret = sabre_command(drvdata, SABRE_CMD_STATUS, resp);
+	if (ret)
+		return ret;
+
+	connected = resp[SABRE_PAYLOAD];
+	if (connected) {
+		ret = sabre_command(drvdata, SABRE_CMD_BATTERY, resp);
+		if (ret)
+			return ret;
+
+		capacity = clamp_t(int, resp[SABRE_PAYLOAD], 0, 100);
+		charging = resp[SABRE_PAYLOAD + 1];
+		voltage_mv = get_unaligned_be16(&resp[SABRE_PAYLOAD + 2]);
+	}
+
+	changed = connected != drvdata->connected ||
+		  charging != drvdata->charging ||
+		  capacity != drvdata->capacity;
+
+	drvdata->connected = connected;
+	drvdata->charging = charging;
+	drvdata->capacity = capacity;
+	drvdata->voltage_mv = voltage_mv;
+
+	/* The first refresh runs in probe, before the battery is registered */
+	if (changed && drvdata->battery)
+		power_supply_changed(drvdata->battery);
+
+	return 0;
+}
+
+static void sabre_poll_work(struct work_struct *work)
+{
+	struct sabre_drvdata *drvdata = container_of(to_delayed_work(work),
+		struct sabre_drvdata, poll_work);
+	unsigned int interval = SABRE_POLL_INTERVAL_S;
+	int ret;
+
+	ret = sabre_refresh(drvdata);
+	if (!ret) {
+		drvdata->failures = 0;
+	} else if (++drvdata->failures == SABRE_MAX_FAILURES) {
+		hid_warn(drvdata->hdev, "failed to read battery status: %d\n",
+			 ret);
+	} else {
+		hid_dbg(drvdata->hdev, "failed to read battery status: %d\n",
+			ret);
+	}
+
+	if (ret || !drvdata->connected)
+		interval = SABRE_POLL_RETRY_S;
+
+	schedule_delayed_work(&drvdata->poll_work, secs_to_jiffies(interval));
+}
+
+static void sabre_start_polling(struct sabre_drvdata *drvdata,
+				unsigned long delay)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->polling = true;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	schedule_delayed_work(&drvdata->poll_work, delay);
+}
+
+static void sabre_stop_polling(struct sabre_drvdata *drvdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->polling = false;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	cancel_delayed_work_sync(&drvdata->poll_work);
+}
+
+static int sabre_battery_get_property(struct power_supply *psy,
+				      enum power_supply_property prop,
+				      union power_supply_propval *val)
+{
+	struct sabre_drvdata *drvdata = power_supply_get_drvdata(psy);
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = drvdata->connected;
+		return 0;
+	/*
+	 * UPower ignores a device-scope supply for good if capacity can't be
+	 * read when it first sees it, e.g. at boot before the first poll or
+	 * with the mouse asleep. It uses online to hide it while disconnected.
+	 */
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = drvdata->capacity;
+		return 0;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		return 0;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = drvdata->hdev->name;
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Corsair";
+		return 0;
+	default:
+		break;
+	}
+
+	if (!drvdata->connected)
+		return -ENODATA;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = drvdata->charging ?
+			POWER_SUPPLY_STATUS_CHARGING :
+			POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = drvdata->voltage_mv * 1000;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sabre_raw_event(struct hid_device *hdev, struct hid_report *report,
+			   u8 *data, int size)
+{
+	struct sabre_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned long flags;
+
+	if (!drvdata || report->id != SABRE_REPORT_ID ||
+	    size < SABRE_REPORT_SIZE)
+		return 0;
+
+	if (sabre_checksum(data, SABRE_REPORT_SIZE) != SABRE_CHECKSUM)
+		return 0;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	if (drvdata->pending_cmd && data[1] == drvdata->pending_cmd) {
+		memcpy(drvdata->response, data, SABRE_REPORT_SIZE);
+		drvdata->pending_cmd = 0;
+		complete(&drvdata->done);
+	} else if (drvdata->polling && data[1] == SABRE_CMD_EVENT &&
+		   (data[SABRE_PAYLOAD] & SABRE_EVENT_POWER)) {
+		/* Charging cable plugged or unplugged, or mouse switched on */
+		mod_delayed_work(system_percpu_wq, &drvdata->poll_work,
+				 msecs_to_jiffies(100));
+	}
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	/* Let hidraw see the report as well */
+	return 0;
+}
+
+static int sabre_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct power_supply_config psy_cfg = {};
+	struct sabre_drvdata *drvdata;
+	struct hid_report_enum *output;
+	bool refreshed;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Only the vendor interface carries the battery protocol */
+	output = &hdev->report_enum[HID_OUTPUT_REPORT];
+	if (!output->report_id_hash[SABRE_REPORT_ID])
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->hdev = hdev;
+	mutex_init(&drvdata->cmd_lock);
+	spin_lock_init(&drvdata->lock);
+	init_completion(&drvdata->done);
+	INIT_DELAYED_WORK(&drvdata->poll_work, sabre_poll_work);
+
+	drvdata->battery_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						    "corsair-sabre-%d-battery",
+						    hdev->id);
+	if (!drvdata->battery_desc.name)
+		return -ENOMEM;
+
+	drvdata->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	drvdata->battery_desc.properties = sabre_battery_props;
+	drvdata->battery_desc.num_properties = ARRAY_SIZE(sabre_battery_props);
+	drvdata->battery_desc.get_property = sabre_battery_get_property;
+
+	hid_set_drvdata(hdev, drvdata);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Keep the interrupt endpoint running so replies reach raw_event */
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "hw open failed: %d\n", ret);
+		goto err_stop;
+	}
+
+	/* The HID core drops input reports during probe unless asked not to */
+	hid_device_io_start(hdev);
+
+	/*
+	 * Read the battery once before registering it, so that the first
+	 * capacity UPower sees is a real one rather than 0. If this fails,
+	 * the poll below retries soon.
+	 */
+	ret = sabre_refresh(drvdata);
+	if (ret)
+		hid_dbg(hdev, "initial battery read failed: %d\n", ret);
+	else
+		hid_dbg(hdev, "initial read: connected=%d capacity=%d\n",
+			drvdata->connected, drvdata->capacity);
+	refreshed = !ret;
+
+	/*
+	 * Register the battery only once the input devices exist. UPower
+	 * derives the battery type (mouse, keyboard, ...) from them, and
+	 * otherwise briefly reports it as a system battery.
+	 */
+	psy_cfg.drv_data = drvdata;
+	drvdata->battery = devm_power_supply_register(&hdev->dev,
+						      &drvdata->battery_desc,
+						      &psy_cfg);
+	if (IS_ERR(drvdata->battery)) {
+		ret = PTR_ERR(drvdata->battery);
+		hid_err(hdev, "failed to register battery: %d\n", ret);
+		goto err_close;
+	}
+
+	sabre_start_polling(drvdata,
+			    secs_to_jiffies(refreshed && drvdata->connected ?
+					    SABRE_POLL_INTERVAL_S :
+					    SABRE_POLL_RETRY_S));
+	return 0;
+
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void sabre_remove(struct hid_device *hdev)
+{
+	struct sabre_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata) {
+		sabre_stop_polling(drvdata);
+		hid_hw_close(hdev);
+	}
+
+	hid_hw_stop(hdev);
+}
+
+static int sabre_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct sabre_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata)
+		sabre_stop_polling(drvdata);
+
+	return 0;
+}
+
+static int sabre_resume(struct hid_device *hdev)
+{
+	struct sabre_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (drvdata)
+		sabre_start_polling(drvdata, 0);
+
+	return 0;
+}
+
+static const struct hid_device_id sabre_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
+			 USB_DEVICE_ID_CORSAIR_SABRE_V2_PRO_RECEIVER) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, sabre_devices);
+
+static struct hid_driver sabre_driver = {
+	.name = "hid-corsair-sabre",
+	.id_table = sabre_devices,
+	.probe = sabre_probe,
+	.remove = sabre_remove,
+	.raw_event = sabre_raw_event,
+	.suspend = pm_ptr(sabre_suspend),
+	.resume = pm_ptr(sabre_resume),
+	.reset_resume = pm_ptr(sabre_resume),
+};
+module_hid_driver(sabre_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HID driver for Corsair Sabre v2 Pro wireless receiver battery");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c40d818417a2..418477967ca5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -385,6 +385,7 @@
 #define USB_DEVICE_ID_CORSAIR_K70RGB_RAPIDFIRE  0x1b38
 #define USB_DEVICE_ID_CORSAIR_K65RGB_RAPIDFIRE  0x1b39
 #define USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB  0x1b3e
+#define USB_DEVICE_ID_CORSAIR_SABRE_V2_PRO_RECEIVER	0x2b2a
 
 #define USB_VENDOR_ID_CREATIVELABS	0x041e
 #define USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51	0x322c
-- 
2.56.1

