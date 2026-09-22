Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457F534443;
	Tue, 22 Sep 2026 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120174; cv=none; b=KCElX63Mi3GpXyQFfjIrLJ0kNj1GRk8YonHsN6Y4fkCYqq6yYUixJsOMFT3h1fg8rtsL335BUp2edY69UntHoyqkfz2CNYyYeKADMx50sjJzO2pyqmvq3y+ShWVEfdIG/wjwpDLGaNZkwRl48Rw2aI+C+gNvJJeg+zOCiRCXUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120174; c=relaxed/simple;
	bh=fQCDqNYMWXfYuaMG7xP0BtWWt8rzyUy+m0rnKhQRRnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxUzzph0X4L7AZYEjjLjny877lWwHbgN5zOXvYIa5hrs3dABYnPWtQcmodYxrEto1Ra5bxzBQPcVA5LjIoQm46uNAVCYslXCKLLwT5Sbpqxq7Dua2RBhYWxPmtWNg/o/5Saw4s6ru03LC/C63k6mVvs+0h4BqtGfri3hNW/HlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eoC5cf0+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eoC5cf0+"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 295F782B20;
	Wed, 23 Sep 2026 01:36:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msRIRTWDIPzA; Wed, 23 Sep 2026 01:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790120164; bh=fQCDqNYMWXfYuaMG7xP0BtWWt8rzyUy+m0rnKhQRRnU=;
	h=From:To:Cc:Subject:Date;
	b=eoC5cf0+MRWL8Vzk+YB88wW+omtNzfiE2HgRn/WQAhae4y0VKoBLE00YVvMWTjW4p
	 +cppfVesuWJsKrHuCx2euX17OiBvjBet9koEFeVeocMU/dK+e6MkJXk69nEntdVBQc
	 O172ELqpwKB6i6L/3ljfLDH6+/aafs6JNYbygZq6jnnTlaH0ccdwJzzqPxCTCMRIyY
	 l/JvclfDWA+nBjB1sBxhimypdWElDJ26sUmtsizHR3Y/BNH6Z4zBNl3qSe6sETyVhB
	 x5eKltZwpJ85VswbNbdmM461qtnHepBlRX5NwEHrwXTmk/Mo+1YXs7AqXoX24D4hIF
	 xBiTXszy+JFZg==
From: "R. Larocque" <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	dave.wang@emc.com.tw,
	jingle.wu@emc.com.tw,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [RFC PATCH V2] Input: elan_i2c_smbus - resend ENABLE_TP on wake from sleep (NOT TESTED, NEEDS TESTER!) (v2: typo fixes)
Date: Tue, 22 Sep 2026 19:35:47 -0400
Message-ID: <20260922233549.10431-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Raphaël Larocque" <rlarocque@disroot.org>

elan_smbus_sleep_control() sends ETP_SMBUS_SLEEP_CMD to put the
controller to sleep, but does nothing on wake, leaving a long-standing
XXX comment questioning whether ETP_SMBUS_ENABLE_TP should be re-sent.

elan_initialize() already treats sleep_control(client, false) as a
genuine "wake device up" primitive (see the ASUS special-firmware
branch and its accompanying dev_err() message), so this makes the
non-ASUS/default path resend ETP_SMBUS_ENABLE_TP symmetrically with
elan_smbus_initialize() instead of being a no-op.

Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
RFC: I don't have the Elan SMBus protocol datasheet and consequently 
haven't been able to test this on any real hardware where the previous no-op
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

