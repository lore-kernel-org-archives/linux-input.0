Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D553002B3;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=oWJ/QmG3vRN4uIbagNgnFdN2rkQxUjgUKjUmFFPiZ590Oo9rpput+Ar9dyWyOfzdGT9wV9lMtQHgjXpL4j2gtaUZFtqF5+bTgHnuiohaEX/Ucpu8CAzP/33svN32JYvqul1OyzDR/3y0umo3rI9blVlV5eeAdxUQtdJSTKl1AXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=9K+o0qOH6VZK2UnK4AHRlWVpMQgG3iSkVHNlb8og+hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6CIb/hEC2UDTiKE14iksslezGRrwoav1GaodXktW8SqknNz68VVYJAMrGXWPhLTe+FwFZxOUD5ghxKTvpRSdl8dG4hbYazXeL4BETzAjjfLc+1IzKuNRb0f1hxKZ2Br5hYuu42dlgAwkWnC2DpRqkVBG9hFPuhxqCTEJRjOUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU9P9PZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU9P9PZM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1100DC2BCFC;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347845;
	bh=9K+o0qOH6VZK2UnK4AHRlWVpMQgG3iSkVHNlb8og+hI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iU9P9PZMmx0YrhIkDV994Px8JUiW94/yaWdLW2i4tkyeangKMqnsXKvnbpqI7E6C+
	 DFmdL0VpG8R1aN/h6t2eW9PIecjXdAIjIdK4abKur9KnzI07ayssYtcwpZO3zCfaXy
	 UOmoAd5oyIIxt2gjym9sDNx0e/7TzBErMONNymvpFuo719ZylM8tkDh6h5Hx6WgPjc
	 KveOfldtQI1kFokot8cboscwBfymBQorzf9ChTHxXj0AFFhvTYIOvwXE5BTcfnp46+
	 F4CdtocbOprz0fsIGysLXU3g4Ix27rRWThiV5ay2cMYSSmWE7lfC/fGwViZoSUogdH
	 1OM8J7COEHQ4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6AC5DF9C;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Sat, 22 Aug 2026 00:30:15 +0300
Subject: [PATCH 3/5] Input: imagis - replace the protocol_b flag with a
 protocol enum
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-imagis-40xx-v1-3-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
In-Reply-To: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=3691;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=kllTREbKM7MPt6EgqVJAPrfjFuWKJEaN3O2mls6UtuE=;
 b=QYzkDd9z2iAFsYaVTIAB9W+xbs2cVUPDasvPtIbc9ySO3G5gxnRyUirYatexynCkNRm4b+uS+
 xI4lgZNEmxfBS8rcNWOg4ENDy/QUWD7phfbln3k3W3MKeQtuDBDxPV2
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

The driver tells the two supported touch reporting formats apart with
the protocol_b flag. The naming is unfortunate: "protocol B" is the
format of the IST30XXC series, while the B-suffixed chips use the
unnamed other format. Adding support for the IST40xx family is about to
introduce a third format, at which point a collection of booleans gets
easy to misuse.

Replace the flag with an enum which describes each reporting format:
IMAGIS_PROTOCOL_SHARED_REGISTER for the single coordinate register
shared by all contacts (IST3038, IST3038B and IST3038H), and
IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS for one coordinate register per
contact (IST3032C and IST3038C).

No functional change intended.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/input/touchscreen/imagis.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 7cc91f97c06e..6552d97efe32 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -44,12 +44,19 @@
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 #define IST3032C_KEY_STATUS_MASK	GENMASK(20, 16)
 
+enum imagis_protocol {
+	/* one coordinate register shared by all contacts */
+	IMAGIS_PROTOCOL_SHARED_REGISTER,
+	/* one coordinate register per contact */
+	IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS,
+};
+
 struct imagis_properties {
 	unsigned int interrupt_msg_cmd;
 	unsigned int touch_coord_cmd;
 	unsigned int whoami_cmd;
 	unsigned int whoami_val;
-	bool protocol_b;
+	enum imagis_protocol protocol;
 	bool touch_keys_supported;
 };
 
@@ -129,7 +136,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	for (i = 0; i < finger_count; i++) {
 		bool pressed;
 
-		if (ts->tdata->protocol_b)
+		if (ts->tdata->protocol == IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS)
 			error = imagis_i2c_read_reg(ts,
 						    ts->tdata->touch_coord_cmd + (i * 4),
 						    &finger_status);
@@ -410,8 +417,8 @@ static const struct imagis_properties imagis_3032c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3032C_WHOAMI,
+	.protocol = IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS,
 	.touch_keys_supported = true,
-	.protocol_b = true,
 };
 
 static const struct imagis_properties imagis_3038_data = {
@@ -419,6 +426,7 @@ static const struct imagis_properties imagis_3038_data = {
 	.touch_coord_cmd = IST30XX_REG_STATUS,
 	.whoami_cmd = IST30XX_REG_CHIPID,
 	.whoami_val = IST3038_WHOAMI,
+	.protocol = IMAGIS_PROTOCOL_SHARED_REGISTER,
 	.touch_keys_supported = true,
 };
 
@@ -427,6 +435,7 @@ static const struct imagis_properties imagis_3038b_data = {
 	.touch_coord_cmd = IST30XX_REG_STATUS,
 	.whoami_cmd = IST3038B_REG_CHIPID,
 	.whoami_val = IST3038B_WHOAMI,
+	.protocol = IMAGIS_PROTOCOL_SHARED_REGISTER,
 };
 
 static const struct imagis_properties imagis_3038c_data = {
@@ -434,7 +443,7 @@ static const struct imagis_properties imagis_3038c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3038C_WHOAMI,
-	.protocol_b = true,
+	.protocol = IMAGIS_PROTOCOL_PER_CONTACT_REGISTERS,
 };
 
 static const struct imagis_properties imagis_3038h_data = {
@@ -442,6 +451,7 @@ static const struct imagis_properties imagis_3038h_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3038H_WHOAMI,
+	.protocol = IMAGIS_PROTOCOL_SHARED_REGISTER,
 };
 
 static const struct of_device_id imagis_of_match[] = {

-- 
2.55.0


