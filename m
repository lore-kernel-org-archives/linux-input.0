Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59239EF1C;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=heY09pV7p4G3hD+5ANpQerLb/zffBwOJUtVXffdLqJoJ/9j+sJIZcnkGzLJioc5inbjXxDNJeh3fv6DSD7+smYrjda4FwvnO4NDuT31D1ReF9hTsmkzcEp6pbt+gIlAJLSrEuoKGcrp0+mHA6j8Zt7r3I2tfvH7o/CMLRsrH/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=p2S3IYvzW9HBaNZTdf+/qhKil6rJJLwJwZyWnJWPmAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNi2ST0F3X18Akmwd6v0LoItUs2O6ceqgdcwfWfws9za56s10Q7q+sOP65FUci74KKSzBcMbnHsxnTxcNM66Gz4BzEUJz2EJUxKigiBYpoudDaqCZXNVn3/Pzqy26Ba7NSg5CrW+aCq84zW0Gxp6vVry/IHZ2Bqg7uZuuehOG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDVNdC+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDVNdC+U"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226A2C2BCFD;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347845;
	bh=p2S3IYvzW9HBaNZTdf+/qhKil6rJJLwJwZyWnJWPmAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mDVNdC+U32xkxL2F6rrIynVGUG4hk/90jZVgJY89u4q/mgQG38XfkhzRGQzIOdmzX
	 j5r0KHqeUqQJ5xF9K6Jqj43b5QWjsnssDYEgWSpA12RYUU9DKgqQz8wRbn1ALEnZWL
	 AHauCBT78ZtSBJseLru3892SrH98k0oqW3+oVdDb7bzlxlEECB2u4xP/fg6BNeF5OR
	 EZv2Qy7SVNfyqyaAar0t7QAgwH6yIzvZstNO98DfNFSP0G22KvipARPP6VC1I5qm1I
	 oyNa8y1GTjLIvUj2Xs/Vi72OoopL0ayKWYDs3j9jWGmXuFM+ykpJD9xxs/wk+FgGR6
	 nUK5xGmQoTW8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C67C5DF97;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Sat, 22 Aug 2026 00:30:16 +0300
Subject: [PATCH 4/5] Input: imagis - add support for the IST40xx touch
 reporting format
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-imagis-40xx-v1-4-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
In-Reply-To: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=4630;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=nhgSejXLaeik0yd9gYDsbPQiM2+SayHHbjInSk+Mj6E=;
 b=7C43MGJhylrJewIzJXjOOWCV8q3FUHf60NP5sZPEmAV/ZaBKvKPCELcF/BeihPZX/gflkBDrV
 V0QHEAQ9cvQDiHgO/vrVQkQfwEo3JR/wYuPMZ4oFwX4jRqsaysdJkns
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

Chips of the Imagis IST40xx family share the register interface and the
coordinate format with IST3038C, but report touches differently: the
per-contact records are 8 bytes apart, and instead of pairing the record
index with a "pressed" bitmask from the interrupt message, each record
carries a hardware-assigned touch ID (1-based, bits 31:28) and an event
type (press or release, bits 27:24). The event type occupies the bits
which hold the contact area on IST3038C, and no contact area is
available in the coordinate word.

Add an IMAGIS_PROTOCOL_TOUCH_EVENTS variant for this format: derive the
contact slot from the touch ID instead of the record index, translate
press/release events into the contact state, ignore records with an
out-of-range touch ID or an unknown event type, and do not declare the
ABS_MT_TOUCH_MAJOR axis.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/imagis.c | 49 +++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 6552d97efe32..5254cccdd653 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -44,11 +44,18 @@
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 #define IST3032C_KEY_STATUS_MASK	GENMASK(20, 16)
 
+#define IST40XX_TOUCH_ID_MASK		GENMASK(31, 28)
+#define IST40XX_TOUCH_EVENT_MASK	GENMASK(27, 24)
+#define IST40XX_TOUCH_EVENT_PRESS	1
+#define IST40XX_TOUCH_EVENT_RELEASE	2
+
 enum imagis_protocol {
 	/* one coordinate register shared by all contacts */
 	IMAGIS_PROTOCOL_SHARED_REGISTER,
 	/* one coordinate register per contact */
 	IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS,
+	/* one record per contact, carrying a touch ID and an event type */
+	IMAGIS_PROTOCOL_TOUCH_EVENTS,
 };
 
 struct imagis_properties {
@@ -134,9 +141,14 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	finger_pressed = FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
 
 	for (i = 0; i < finger_count; i++) {
+		unsigned int slot = i;
 		bool pressed;
 
-		if (ts->tdata->protocol == IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS)
+		if (ts->tdata->protocol == IMAGIS_PROTOCOL_TOUCH_EVENTS)
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd + (i * 8),
+						    &finger_status);
+		else if (ts->tdata->protocol == IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS)
 			error = imagis_i2c_read_reg(ts,
 						    ts->tdata->touch_coord_cmd + (i * 4),
 						    &finger_status);
@@ -150,9 +162,31 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 			goto out;
 		}
 
-		pressed = finger_pressed & BIT(i);
+		if (ts->tdata->protocol == IMAGIS_PROTOCOL_TOUCH_EVENTS) {
+			unsigned int id = FIELD_GET(IST40XX_TOUCH_ID_MASK,
+						    finger_status);
+
+			if (!id || id > IST3038C_MAX_FINGER_NUM)
+				continue;
+
+			slot = id - 1;
+
+			switch (FIELD_GET(IST40XX_TOUCH_EVENT_MASK,
+					  finger_status)) {
+			case IST40XX_TOUCH_EVENT_PRESS:
+				pressed = true;
+				break;
+			case IST40XX_TOUCH_EVENT_RELEASE:
+				pressed = false;
+				break;
+			default:
+				continue;
+			}
+		} else {
+			pressed = finger_pressed & BIT(i);
+		}
 
-		input_mt_slot(ts->input_dev, i);
+		input_mt_slot(ts->input_dev, slot);
 		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, pressed);
 		if (!pressed)
 			continue;
@@ -161,8 +195,10 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 				       FIELD_GET(IST3038C_X_MASK, finger_status),
 				       FIELD_GET(IST3038C_Y_MASK, finger_status),
 				       true);
-		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
-				 FIELD_GET(IST3038C_AREA_MASK, finger_status));
+		if (ts->tdata->protocol != IMAGIS_PROTOCOL_TOUCH_EVENTS)
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+					 FIELD_GET(IST3038C_AREA_MASK,
+						   finger_status));
 	}
 
 	key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
@@ -255,7 +291,8 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
+	if (ts->tdata->protocol != IMAGIS_PROTOCOL_TOUCH_EVENTS)
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 	if (ts->tdata->touch_keys_supported) {
 		ts->num_keycodes = of_property_read_variable_u32_array(
 				ts->client->dev.of_node, "linux,keycodes",

-- 
2.55.0


