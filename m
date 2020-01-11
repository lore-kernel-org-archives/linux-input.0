Return-Path: <SRS0=NUkw=3A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E897C282DD
	for <linux-input@archiver.kernel.org>; Sat, 11 Jan 2020 19:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BF206ED
	for <linux-input@archiver.kernel.org>; Sat, 11 Jan 2020 19:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgAKTYo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 11 Jan 2020 14:24:44 -0500
Received: from orion.archlinux.org ([88.198.91.70]:48662 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgAKTYo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Jan 2020 14:24:44 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 4841E180A9717F;
        Sat, 11 Jan 2020 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:8a0:f254:2300:dad6:8c60:8394:88da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Sat, 11 Jan 2020 19:24:40 +0000 (UTC)
From:   =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pedro Vanzella <pedro@pedrovanzella.com>
Cc:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH] HID: logitech-hidpp: BatteryVoltage: only read chargeStatus if extPower is active
Date:   Sat, 11 Jan 2020 19:24:19 +0000
Message-Id: <20200111192419.2503922-1-lains@archlinux.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

In the HID++ 2.0 function getBatteryInfo() from the BatteryVoltage
(0x1001) feature, chargeStatus is only valid if extPower is active.

Previously we were ignoring extPower, which resulted in wrong values.

Example:
    With an unplugged mouse

    $ cat /sys/class/power_supply/hidpp_battery_0/status
    Charging

This patch makes fixes that, it also renames charge_sts to flags as
charge_sts can be confused with chargeStatus from the spec.

Spec:
+--------+-------------------------------------------------------------------------+
|  byte  |                                    2                                    |
+--------+--------------+------------+------------+----------+----------+----------+
|   bit  |     0..2     |      3     |      4     |     5    |     6    |     7    |
+--------+--------------+------------+------------+----------+----------+----------+
| buffer | chargeStatus | fastCharge | slowCharge | critical | (unused) | extPower |
+--------+--------------+------------+------------+----------+----------+----------+
Table 1 - battery voltage (0x1001), getBatteryInfo() (ASE 0), 3rd byte

+-------+--------------------------------------+
| value |                meaning               |
+-------+--------------------------------------+
|   0   | Charging                             |
+-------+--------------------------------------+
|   1   | End of charge (100% charged)         |
+-------+--------------------------------------+
|   2   | Charge stopped (any "normal" reason) |
+-------+--------------------------------------+
|   7   | Hardware error                       |
+-------+--------------------------------------+
Table 2 - chargeStatus value

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---
 drivers/hid/hid-logitech-hidpp.c | 43 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index bb063e7d48df..39a5ee0aaab0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1256,36 +1256,35 @@ static int hidpp20_battery_map_status_voltage(u8 data[3], int *voltage,
 {
 	int status;
 
-	long charge_sts = (long)data[2];
+	long flags = (long) data[2];
 
-	*level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
-	switch (data[2] & 0xe0) {
-	case 0x00:
-		status = POWER_SUPPLY_STATUS_CHARGING;
-		break;
-	case 0x20:
-		status = POWER_SUPPLY_STATUS_FULL;
-		*level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		break;
-	case 0x40:
+	if (flags & 0x80)
+		switch (flags & 0x07) {
+		case 0:
+			status = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+		case 1:
+			status = POWER_SUPPLY_STATUS_FULL;
+			*level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+			break;
+		case 2:
+			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		default:
+			status = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+	else
 		status = POWER_SUPPLY_STATUS_DISCHARGING;
-		break;
-	case 0xe0:
-		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		break;
-	default:
-		status = POWER_SUPPLY_STATUS_UNKNOWN;
-	}
 
 	*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
-	if (test_bit(3, &charge_sts)) {
+	if (test_bit(3, &flags)) {
 		*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	}
-	if (test_bit(4, &charge_sts)) {
+	if (test_bit(4, &flags)) {
 		*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
 	}
-
-	if (test_bit(5, &charge_sts)) {
+	if (test_bit(5, &flags)) {
 		*level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 	}
 
-- 
2.24.1
