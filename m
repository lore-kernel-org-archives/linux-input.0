Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0B425872;
	Tue, 22 Sep 2026 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119656; cv=none; b=SMhjAYCIq2Wwt3n3LLxmXP+YbLD8iEBagO6wQTOKdccIitq98HDKCrplWs5yYkdETazl4xf64lUgI+bD1Pvr01BNQLeivf3eohzTMZ3uy6gfGTiJWp+/Ki6jBeGmgzxORNpfUMJyN7XrzHtkNcE9+7BkhRextiaXGD4PjXx3B0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119656; c=relaxed/simple;
	bh=MsM6Q3k+xZGBgqTNeflUgX0yRpWfvapZFPDDSbiUcRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFFURgdj72ij7kHBiKzXYDUgOtKJaTJ54tvBTBSSbW1mJvz95ezWmYYrRhW3eTM7AG6rvTLXukUfwS9/yUn4xgASAWXrP9D+Wvm/hY6gkDXl8H8516ZZgxFT0ytARUvNaiHlGTI0Lye4Qxu+zcm6WvsVFt4pG2bZdPlqN1RiCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Coa/JF/C; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Coa/JF/C"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7ED7382A93;
	Wed, 23 Sep 2026 01:27:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S76HrBS9fi7C; Wed, 23 Sep 2026 01:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790119639; bh=MsM6Q3k+xZGBgqTNeflUgX0yRpWfvapZFPDDSbiUcRY=;
	h=From:To:Cc:Subject:Date;
	b=Coa/JF/C5I1UFMhEvq6CNavNdwprNWPHXRUYVw/VGVnhZG/fIcicMob3JpnPFfipJ
	 M3dBezvQ83UYtAYo529IgY1Wf7ojlOzdSrqFpZ6XMbbbTYS75G0uPaJqWuP7KtG5iN
	 kv8eMIXAyWjU7KKaTPr9R3D/ZyGtLzZKybaTuxbXnfhwwunSyf1D/8exATSPPFgQgd
	 +GodSniixBZZzTj1heb1Y8mbHJChOE6TOZNTH3q3DTcqTMxk4LX/MTnh2xgAbnUcnC
	 TGG5q5rbXr946wMzToioC8jr0F96Qryv+iMEkQHPcr5p0umQkRmLo8sBSg2/UzkJZr
	 IAqG49P2qAfJA==
From: "R. Larocque" <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	dave.wang@emc.com.tw,
	jingle.wu@emc.com.tw,
	linux-kernel@vger.kernel.org,
	"R. Larocque" <rlarocque@disroot.org>
Subject: [RFC PATCH] Input: elan_i2c_smbus - resend ENABLE_TP on wake from sleep (NOT TESTED, NEEDS TESTER!)
Date: Tue, 22 Sep 2026 19:17:12 -0400
Message-ID: <20260922232707.8949-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

elan_smbus_sleep_control() sends ETP_SMBUS_SLEEP_CMD to put the
controller to sleep, but does nothing on wake, leaving a long-standing
XXX comment questionning wether ETP_SMBUS_ENABLE_TP should be re sent.

elan_initialize() already treats sleep_control(client, false) as a
genuine "wake device up" primitive (see the ASUS special-firmware
branch and its accompanying dev_err() message), so this makes the
non-ASUS/default path resend ETP_SMBUS_ENABLE_TP symetrically with
elan_smbus_initialize() instead of being a no-op.

Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
RFC: I dont have the Elan SMBus protocol datasheet and consequently 
havent been able to test this on any real hardware where the previous no-op
path was actually relied upon. Sending this for testing by
someone with access to affected devices before it is considered for
merge. A bad SMBus write to a sleeping controller could leave it
in a weird state on the wrong firmware revision if unlucky.

 drivers/input/mouse/elan_i2c_smbus.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index 0287441cda46..95f5951e9549 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -93,10 +93,25 @@ static int elan_smbus_set_mode(struct i2c_client *client, u8 mode)
 
 static int elan_smbus_sleep_control(struct i2c_client *client, bool sleep)
 {
+	int error;
+
 	if (sleep)
 		return i2c_smbus_write_byte(client, ETP_SMBUS_SLEEP_CMD);
-	else
-		return 0; /* XXX should we send ETP_SMBUS_ENABLE_TP here? */
+
+	/*
+	 * The controller stops touch reporting while asleep; resend
+	 * ETP_SMBUS_ENABLE_TP on wake, mirroring what is done during
+	 * elan_smbus_initialize(), so that reporting actually resumes.
+	 */
+	error = i2c_smbus_write_byte(client, ETP_SMBUS_ENABLE_TP);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to re-enable touchpad after wake: %d\n",
+			error);
+		return error;
+	}
+
+	return 0;
 }
 
 static int elan_smbus_power_control(struct i2c_client *client, bool enable)
-- 
2.55.0

