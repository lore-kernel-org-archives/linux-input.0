Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AC3806B5;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=oi+lU0lCNXDlaEADKWsfChcJDGDmwzoaAQP3XT6B7/uQtlQI4QacRu7+5B7dT26QmwkC7ROTMkEI1F0a+k44VcMbdSMCARkk4XTS0514mJT2PKooMLocOFuFomef1NL9xoMAoGsIJwvKBs2p58H2aZUeFCP9wdYuRATWO5vcm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=YYQpmxoUDJklr9fi4c17eF6VqKaZew/1JC8NWvw/BrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwIWU+xagB0cSOZDr/EjfH8His9FhYQ6lFZ/AvFhO3w6tUIK4DauKYllY6vHZtywbCHmhW/v85MMW65ORmlc8hOhr7+MVp8ZZs9qSbi+9tb7u0dViAby7fRq7wXZ5GBk/WnE+z77nenN9Lk0cVDooQW3N1Qq3mKfTlwFL6YXTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvgDhGnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvgDhGnB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1578C2BCFB;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347845;
	bh=YYQpmxoUDJklr9fi4c17eF6VqKaZew/1JC8NWvw/BrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lvgDhGnBbP7nk3/+w2+DS5/WqMxu4JXfCcHnjnc41eo3TU2wviBg/EDSdeYze9Woz
	 UhNNpGuJJRCPKvhXDXOCkAZC2m5nuVz7xnw2sS32MAAOFdqW+ANSOJrnIA6YrSkWG1
	 Mqgu19r1Wa0Ch7d1Be42/Z0EmUgta+SVLd0MGQV/e6We0RIijKCgCsE3yBC8wgdouk
	 dtHDZvj1gW7iQJ2E6/9f44auOtGREmKwjdYVIouWjAyrek1Uhw+qh/zQsrRmLc6xof
	 a00BPwcVu9UmaJirJXn/Fz4GTiCJERdgOHINnH0AQo6csHa07uM2VI+KQsWbdAYRsd
	 0Wbn/aa+DV7qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FFDC5DF9B;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Sat, 22 Aug 2026 00:30:14 +0300
Subject: [PATCH 2/5] Input: imagis - do not report coordinates of released
 contacts
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-imagis-40xx-v1-2-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
In-Reply-To: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=1815;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=/89QleBijrj8h5epT76LuQ4gCzsyr6Wpor71MQ0Dksk=;
 b=WLXIrjwJPs3d2Z4zlM11Ew5aCBf3PVpRFXqhiA2baum1Dmyb8XqOjM3KcPsvPDi3BhRSRxI68
 wX0r8R52Mh7CXL0qcIHse3c1+kpKqLqk1Zp3VlFemqNRZ1VhaJmsHvq
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

The position and the contact area are currently reported even for
contacts which are being released. The slot has already been deactivated
at that point, so these events carry no information for userspace.
Report the position and the contact area only for active contacts.

This also prepares the driver for the IST40xx family: its per-contact
records carry an event type in the bits which hold the contact area on
the currently supported chips, so release records must not be parsed for
coordinates or the contact area.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/imagis.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 7bbb00beec3b..7cc91f97c06e 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -127,6 +127,8 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	finger_pressed = FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
 
 	for (i = 0; i < finger_count; i++) {
+		bool pressed;
+
 		if (ts->tdata->protocol_b)
 			error = imagis_i2c_read_reg(ts,
 						    ts->tdata->touch_coord_cmd + (i * 4),
@@ -141,9 +143,13 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 			goto out;
 		}
 
+		pressed = finger_pressed & BIT(i);
+
 		input_mt_slot(ts->input_dev, i);
-		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
-					   finger_pressed & BIT(i));
+		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, pressed);
+		if (!pressed)
+			continue;
+
 		touchscreen_report_pos(ts->input_dev, &ts->prop,
 				       FIELD_GET(IST3038C_X_MASK, finger_status),
 				       FIELD_GET(IST3038C_Y_MASK, finger_status),

-- 
2.55.0


