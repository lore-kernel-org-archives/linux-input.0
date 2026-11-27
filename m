Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751352;
	b=ihzK1TTeW8ekf3UB68VG5MfFFLYtGDNiOt8np8G0sM9Qd8CNiw4rZYFgvdtPTP4GFwpp
	 GNZQTcu5q9ADsdhW+CcvLDLpZtDGsGKjBQ3TjxjN93cupn1JTa6OWkeAD4L+cybbKzsjz
	 rKrkcDX4ZxnW5lczVPijKffOH2fUyKafXdu/+/qIfLlBuv6kZ5KOH/2u86Gb9p4rVVOXN
	 3B+EhhozCYLAkl+ass544BuemrVn/h/dbMxTYiGWJiqF+IYvV/DsO5U0U3a4BlrtCR2+C
	 zCBBW8DwI/MCKGcD1SscmPf1J/aJgWKlwv4LSdwK1Xs6rUydfG5WJSab4ethGpnxZHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bNNN8QE9jG9CcO4Gq86DYSJYJULEdsC0+tUFsyFkiZk=;
	b=koepIEVpLdl65fEqbaPHAZ95Llw1DRyR5/TRxukhlBefiFQr2gOXuWmwXPYlCE3r78PK
	 N/RPEUIsFfK63f23bEsVfB82MByZUOVqXlpsG2gUL8+FtJr/Bn/XR4IAeXG7AxcEbb42t
	 cQXKlk46SY/1ctDYQ3gSljneZb/MgR9nZtovGWOYzyOGFr6qgZJT6pUXOQ3MSERD1u6bS
	 3uP5Jo22GMiWFUz4EV+xNyOrMoPqCPvxL70/EapcmuhtHdltY46MuTs5qJ/7GRAjm2T1m
	 kI5PckfgwlpQNF7bn4lG8x7Sl/UMP62UsaPhd5P4qKFcsQTRFxRoZF2IUAOXt1p/WEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ooAqd2ZW;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F37606A31C;
	Fri, 27 Nov 2026 03:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ooAqd2ZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ooAqd2ZW1mRm2e/OsdJqYAUy+sHFZfxmaEDL8d2+I55A0nrRXNUMZxO8NOvnaMOBGPub9HFxE2Jjy
	 XG+eadpeM+0xWi/WQOKemA9WvGkQEpthvYoTArTErzDZR7Tvn/F49LpeRIeuCVvfOayyjTxfRqf5dO
	 GXNJhnmcgprZ+K+I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26b08fdad717-9e055;
	Fri, 27 Nov 2026 11:49:07 +0800 (CST)
X-RM-TRANSID:2ee26b08fdad717-9e055
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16b08fdb1330-84e2c;
	Fri, 27 Nov 2026 11:49:07 +0800 (CST)
X-RM-TRANSID:2ee16b08fdb1330-84e2c
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: joystick: use scnprintf() for the device physical paths
Date: Fri, 27 Nov 2026 11:49:03 +0800
Message-ID: <20261127034904.288-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

The joystick drivers compose the physical path of their input devices as
"%s/input%d" (or "%s/input0") from gameport->phys, which is a 32 byte
string, into buffers of the same size.  The composed string can reach 39
bytes, so it does not fit: the path is informational and truncating it is
acceptable, but the call sites do not say so.

Because -Wformat-truncation is enabled for W=1 builds and COMPILE_TEST
configurations turn the warning into an error through CONFIG_WERROR,
these files do not build today, for example:

  drivers/input/joystick/a3d.c:287:51: error: '/input0' directive output
    may be truncated writing 7 bytes into a region of size between 1 and
    32 [-Werror=format-truncation=]

Use scnprintf(), the helper that expresses a bounded, truncation tolerant
write, so that the files build warning free and the intent is visible at
the call sites.

No functional change.

Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 drivers/input/joystick/a3d.c       | 2 +-
 drivers/input/joystick/analog.c    | 2 +-
 drivers/input/joystick/gf2k.c      | 2 +-
 drivers/input/joystick/grip.c      | 2 +-
 drivers/input/joystick/guillemot.c | 2 +-
 drivers/input/joystick/interact.c  | 2 +-
 drivers/input/joystick/magellan.c  | 2 +-
 drivers/input/joystick/spaceball.c | 2 +-
 drivers/input/joystick/spaceorb.c  | 2 +-
 drivers/input/joystick/tmdc.c      | 2 +-
 drivers/input/joystick/twidjoy.c   | 2 +-
 drivers/input/joystick/warrior.c   | 2 +-
 drivers/input/joystick/zhenhua.c   | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
index 48a145796..d31de7c6c 100644
--- a/drivers/input/joystick/a3d.c
+++ b/drivers/input/joystick/a3d.c
@@ -284,7 +284,7 @@ static int a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
 	gameport_set_poll_handler(gameport, a3d_poll);
 	gameport_set_poll_interval(gameport, 20);
 
-	snprintf(a3d->phys, sizeof(a3d->phys), "%s/input0", gameport->phys);
+	scnprintf(a3d->phys, sizeof(a3d->phys), "%s/input0", gameport->phys);
 
 	input_dev->name = a3d_names[a3d->mode];
 	input_dev->phys = a3d->phys;
diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index b6f7bce1c..6bbe981e8 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -367,7 +367,7 @@ static int analog_init_device(struct analog_port *port, struct analog *analog, i
 	int error;
 
 	analog_name(analog);
-	snprintf(analog->phys, sizeof(analog->phys),
+	scnprintf(analog->phys, sizeof(analog->phys),
 		 "%s/input%d", port->gameport->phys, index);
 	analog->buttons = (analog->mask & ANALOG_GAMEPAD) ? analog_pad_btn : analog_joy_btn;
 
diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 1d843115d..940dc8067 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -278,7 +278,7 @@ static int gf2k_connect(struct gameport *gameport, struct gameport_driver *drv)
 	gameport_set_poll_handler(gameport, gf2k_poll);
 	gameport_set_poll_interval(gameport, 20);
 
-	snprintf(gf2k->phys, sizeof(gf2k->phys), "%s/input0", gameport->phys);
+	scnprintf(gf2k->phys, sizeof(gf2k->phys), "%s/input0", gameport->phys);
 
 	gf2k->length = gf2k_lens[gf2k->id];
 
diff --git a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
index 2a3f768a7..f685a62ca 100644
--- a/drivers/input/joystick/grip.c
+++ b/drivers/input/joystick/grip.c
@@ -333,7 +333,7 @@ static int grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 			goto fail3;
 		}
 
-		snprintf(grip->phys[i], sizeof(grip->phys[i]),
+		scnprintf(grip->phys[i], sizeof(grip->phys[i]),
 			 "%s/input%d", gameport->phys, i);
 
 		input_dev->name = grip_name[grip->mode[i]];
diff --git a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
index 13f0fa4d3..d6771cef5 100644
--- a/drivers/input/joystick/guillemot.c
+++ b/drivers/input/joystick/guillemot.c
@@ -200,7 +200,7 @@ static int guillemot_connect(struct gameport *gameport, struct gameport_driver *
 	gameport_set_poll_handler(gameport, guillemot_poll);
 	gameport_set_poll_interval(gameport, 20);
 
-	snprintf(guillemot->phys, sizeof(guillemot->phys), "%s/input0", gameport->phys);
+	scnprintf(guillemot->phys, sizeof(guillemot->phys), "%s/input0", gameport->phys);
 	guillemot->type = guillemot_type + i;
 
 	input_dev->name = guillemot_type[i].name;
diff --git a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
index 507cec36b..d4961017d 100644
--- a/drivers/input/joystick/interact.c
+++ b/drivers/input/joystick/interact.c
@@ -229,7 +229,7 @@ static int interact_connect(struct gameport *gameport, struct gameport_driver *d
 	gameport_set_poll_handler(gameport, interact_poll);
 	gameport_set_poll_interval(gameport, 20);
 
-	snprintf(interact->phys, sizeof(interact->phys), "%s/input0", gameport->phys);
+	scnprintf(interact->phys, sizeof(interact->phys), "%s/input0", gameport->phys);
 
 	interact->type = i;
 	interact->length = interact_type[i].length;
diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
index 201a049c8..61fcf0620 100644
--- a/drivers/input/joystick/magellan.c
+++ b/drivers/input/joystick/magellan.c
@@ -138,7 +138,7 @@ static int magellan_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	magellan->dev = input_dev;
-	snprintf(magellan->phys, sizeof(magellan->phys), "%s/input0", serio->phys);
+	scnprintf(magellan->phys, sizeof(magellan->phys), "%s/input0", serio->phys);
 
 	input_dev->name = "LogiCad3D Magellan / SpaceMouse";
 	input_dev->phys = magellan->phys;
diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index 1af299a41..cb536c6a0 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -205,7 +205,7 @@ static int spaceball_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	spaceball->dev = input_dev;
-	snprintf(spaceball->phys, sizeof(spaceball->phys), "%s/input0", serio->phys);
+	scnprintf(spaceball->phys, sizeof(spaceball->phys), "%s/input0", serio->phys);
 
 	input_dev->name = spaceball_names[id];
 	input_dev->phys = spaceball->phys;
diff --git a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
index ba5b31899..a2a3d19db 100644
--- a/drivers/input/joystick/spaceorb.c
+++ b/drivers/input/joystick/spaceorb.c
@@ -153,7 +153,7 @@ static int spaceorb_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	spaceorb->dev = input_dev;
-	snprintf(spaceorb->phys, sizeof(spaceorb->phys), "%s/input0", serio->phys);
+	scnprintf(spaceorb->phys, sizeof(spaceorb->phys), "%s/input0", serio->phys);
 
 	input_dev->name = "SpaceTec SpaceOrb 360 / Avenger";
 	input_dev->phys = spaceorb->phys;
diff --git a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
index d419f41e6..b7457b3a6 100644
--- a/drivers/input/joystick/tmdc.c
+++ b/drivers/input/joystick/tmdc.c
@@ -294,7 +294,7 @@ static int tmdc_setup_port(struct tmdc *tmdc, int idx, unsigned char *data)
 
 	snprintf(port->name, sizeof(port->name), model->name,
 		 port->absc, (data[TMDC_BYTE_DEF] & 0xf) << 3, port->mode);
-	snprintf(port->phys, sizeof(port->phys), "%s/input%d", tmdc->gameport->phys, i);
+	scnprintf(port->phys, sizeof(port->phys), "%s/input%d", tmdc->gameport->phys, i);
 
 	port->dev = input_dev;
 
diff --git a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
index fb452552c..5d8a5081b 100644
--- a/drivers/input/joystick/twidjoy.c
+++ b/drivers/input/joystick/twidjoy.c
@@ -177,7 +177,7 @@ static int twidjoy_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	twidjoy->dev = input_dev;
-	snprintf(twidjoy->phys, sizeof(twidjoy->phys), "%s/input0", serio->phys);
+	scnprintf(twidjoy->phys, sizeof(twidjoy->phys), "%s/input0", serio->phys);
 
 	input_dev->name = "Handykey Twiddler";
 	input_dev->phys = twidjoy->phys;
diff --git a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
index 2e1c6df98..119402782 100644
--- a/drivers/input/joystick/warrior.c
+++ b/drivers/input/joystick/warrior.c
@@ -130,7 +130,7 @@ static int warrior_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	warrior->dev = input_dev;
-	snprintf(warrior->phys, sizeof(warrior->phys), "%s/input0", serio->phys);
+	scnprintf(warrior->phys, sizeof(warrior->phys), "%s/input0", serio->phys);
 
 	input_dev->name = "Logitech WingMan Warrior";
 	input_dev->phys = warrior->phys;
diff --git a/drivers/input/joystick/zhenhua.c b/drivers/input/joystick/zhenhua.c
index 8ca189663..d38ab4ea2 100644
--- a/drivers/input/joystick/zhenhua.c
+++ b/drivers/input/joystick/zhenhua.c
@@ -137,7 +137,7 @@ static int zhenhua_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail1;
 
 	zhenhua->dev = input_dev;
-	snprintf(zhenhua->phys, sizeof(zhenhua->phys), "%s/input0", serio->phys);
+	scnprintf(zhenhua->phys, sizeof(zhenhua->phys), "%s/input0", serio->phys);
 
 	input_dev->name = "Zhen Hua 5-byte device";
 	input_dev->phys = zhenhua->phys;


