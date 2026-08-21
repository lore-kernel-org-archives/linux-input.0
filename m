Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96B34D4E9
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348910; cv=none; b=Oc0OigVmPvkhDqkba4wV7Q4qYUA4a2YS8mOJ2eCygak0cUp9XJrntAOIBpLDS81UFyB5m+Fm3fpzaJv3EgiqwszyVMQRz7xJyipsNoHsJCBc+XLfb2enPpC60veVtjepucEdzKBWJmcVH4CxOLJV7iVN+tz8++y0szmHhvBMSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348910; c=relaxed/simple;
	bh=Q9+jME9VJAGMwbs5dL+qzw2sN4dhcaFkxpJUEyVEaG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY0y02F6gqM84p23x3D+iUo8xISgGZ+K8U31NspMLXuoKX1UbKSLs6oYmWQuRdG90ylRxMXLfHyPctJRjnIpNDhNrQrStPGaurwCexFPAO3ggBBhTfzcG5x4MsfYtxCjh6OCs1NTuu8jUbYBJa4gfz/YsecIV3AA7+Mj971Id4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGTrpOgX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGTrpOgX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1156302a12.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348908; x=1787953708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5voLgM5slHX2FHecq7U0sNP2etbB1183FHydBmLAB6E=;
        b=kGTrpOgXz1h+JPRUNCp6iUcNUE2BFhdwtjvMovufiQ1wBxIOLUJpFtwYsfWKkIqzzx
         FEUl9B9MS1Sky7RlBdImlrDTTx1lWkitXabYFzIJQqUAA7Un1/ROR9bzENmZ9G6eJ77m
         7Va18COFHnWqG1ieZ5WCHs2SbSY9ckEXuqbzdyQ3cKikQXBwZbX5UEpOeZGRuv1dub7x
         6X2A/3SH39deoqHWuqLmFKfLb6+JXA1yIqV0fscUd8hP3h5pZp4VVYxcXEFi2AQAJC4C
         i3sEmAOo2lb8RuNq3tzv4HqYeSZotMc2ZjmQ6I3zTg/UwJ3CviZpwzpt9bJgqkkPq1BL
         MzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348908; x=1787953708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5voLgM5slHX2FHecq7U0sNP2etbB1183FHydBmLAB6E=;
        b=RnVqdmMeJWXxHSjMeDhsLplOxAbpUn3bPOUybDmArjDbyj3OI2YEEH9Ew1nBh8SFIs
         zu+cEeHnk1+VegJwFjyWYsBLumZzVrPdwfRN6FH6CQ7Tf6f3to6jiAEda7ZasBTLICix
         Ca9PmfttI9mJLYkX3e3W0E0qOQfE/oT1HMolyldQa8is3cgZvLa3YVwteEjRDzGgXOWn
         maiDDE67hQXq87vaUziLWZd9ifbNLYHwJ7KQGcWTu6SHMX3h3EmZ+iA/V2Qe7TBKJNaA
         thdvmqmyMXkDs380IerokCXnlrTzGgIixQYaIZbxPMQ3EuwoiF0TkbupwiwWOA/NEtzs
         bIoA==
X-Gm-Message-State: AFuF++liFGJUdw0wCiTOdm12TN6fHBMK9etCacFRN8pJauEpqi/VVrmD
	bmSYdtXsNVYeEGhM6MLsQZJocJIzSvy9y1UG7LxPfRIiGY49KbvGB8QNbyu8yKBS
X-Gm-Gg: AR+sD11sCkH39BgL+YhjlN1VEnvZswVXvAzJaDiU1UB2YOjylS2X7yPJyifPnqKawdu
	dkfHG12fFld4TizVJogkWE1QQJkrr6c9mlr8Aezk8QAx+0oqi9V8KDeoQwjh+QNsnkynH1ZOOl0
	zLJ4eoG/7PhVL7Ic4erMEhoXgVSZ3PnQBR57EIjLpZN9D9oRx4sBTNbwrVynscHqXI8+WXk608+
	F0o2oWDe7hkrFxYDnHGjGe3Bncd0shuj1plFzITqBV563d1agrIDHMR0CvLCgMIO9a/B6sIX1Ul
	/o94oEwh8W2O1A73VAHj6wJBX2801/c/rBvqPIBIRrjUQOqHTq4gZA194zMzOAUsT5HIIBAM90f
	5Zcus8nitHsPszZ3XujBKRIGv/q7GPp58R3M/mHM16eLpbz6LEtQO0nZKyGhUau2Mrw1fbptyM8
	QQe4y1GJLtSRbfkPHmXLjXVz0IX0pJRcWsKpwXUcoTRck2CGpNkZmtyibnZEIquSFkTr16wWbLS
	DrjvUwlg8dcsOAnfekDG0OSL9zY1y8=
X-Received: by 2002:a05:6a20:9d96:b0:3bf:6237:4d3f with SMTP id adf61e73a8af0-3cd4bc45418mr3436077637.18.1787348908325;
        Fri, 21 Aug 2026 14:48:28 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:27 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] HID: hid-lenovo-go: record calibration completion state
Date: Sat, 22 Aug 2026 03:18:08 +0530
Message-ID: <20260821214810.87826-4-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821214810.87826-1-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware uses result value 0 for failure and 1 for success. The driver
stores this value directly as a state index. Index 0 means unknown, so the
driver reports a firmware failure as unknown.

Map the result value to the matching failure or success state.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
A successful calibration completion was tested on hardware. No final
failure completion was captured.

 drivers/hid/hid-lenovo-go.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index a6e9a130ad41..d2d134873dd1 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -577,17 +577,19 @@ static int hid_go_light_event(struct command_report *cmd_rep)
 
 static int hid_go_device_status_event(struct command_report *cmd_rep)
 {
+	u8 status = cmd_rep->data[1] ? CAL_STAT_SUCCESS : CAL_STAT_FAILURE;
+
 	switch (cmd_rep->device_type) {
 	case LEFT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_left_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_left_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_left_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_left_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
@@ -596,13 +598,13 @@ static int hid_go_device_status_event(struct command_report *cmd_rep)
 	case RIGHT_CONTROLLER:
 		switch (cmd_rep->data[0]) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_right_gyro_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_gyro_cal_status = status;
 			return 0;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_right_joy_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_joy_cal_status = status;
 			return 0;
 		case CALDEV_TRIGGER:
-			drvdata.gp_right_trigg_cal_status = cmd_rep->data[1];
+			drvdata.gp_right_trigg_cal_status = status;
 			return 0;
 		default:
 			return -EINVAL;
-- 
2.55.0

