From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] inputattach: add support for tsc40
Date: Tue, 27 Sep 2011 09:40:13 +0200
Message-ID: <CAH9NwWfm2YC4PrPWhm-A=OJOVyw3LApVw__OjfekeCMgQmaGKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63803 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1I0Hkd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Sep 2011 03:40:33 -0400
Received: by iaqq3 with SMTP id q3so5412781iaq.19
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2011 00:40:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Stephen Kitt <steve@sk2.org>

This patch adds support for TSC-40 driver to inputattach.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---

diff -Nur linuxconsoletools-1.4.2/docs/inputattach.1
linuxconsoletools-1.4.2_patched//docs/inputattach.1
--- linuxconsoletools-1.4.2/docs/inputattach.1	2011-08-09
07:35:02.000000000 +0200
+++ linuxconsoletools-1.4.2_patched//docs/inputattach.1	2011-09-27
11:39:28.935479294 +0200
@@ -108,6 +108,9 @@
 .BR \-taos ", " \-\-taos\-evm
 TAOS evaluation module.
 .TP
+.BR \-tsc ", " \-\-tsc
+TSC-10/25/40 touch screen.
+.TP
 .BR \-t213 ", " \-\-touchit213
 Sahara Touch-iT213 Tablet PC.
 .TP
diff -Nur linuxconsoletools-1.4.2/utils/inputattach.c
linuxconsoletools-1.4.2_patched//utils/inputattach.c
--- linuxconsoletools-1.4.2/utils/inputattach.c	2011-08-09
07:43:10.000000000 +0200
+++ linuxconsoletools-1.4.2_patched//utils/inputattach.c	2011-09-27
11:38:01.071479288 +0200
@@ -354,6 +354,82 @@
 	return 0;
 }

+static int tsc40_init(int fd, unsigned long *id, unsigned long *extra)
+{
+	unsigned char cmd[2], data;
+	unsigned int eeprom;
+
+	/* Datasheet can be found here:
+	 * http://www.distec.de/PDF/Drivers/DMC/TSC40_Protocol_Description.pdf
+	 */
+
+#define TSC40_CMD_DATA1	0x01
+#define TSC40_CMD_RATE	0x05
+#define TSC40_CMD_ID	0x15
+#define TSC40_CMD_RESET	0x55
+
+#define TSC40_RATE_150	0x45
+#define TSC40_NACK	0x15
+
+	/* trigger a software reset to get into a well known state */
+	cmd[0] = TSC40_CMD_RESET;
+	if (write(fd, cmd, 1) != 1)
+		return -1;
+	
+	/* wait to settle down */
+	usleep(15 * 1000); /* 15 ms */	
+	
+	/* read panel ID to check if an EEPROM is used */
+	cmd[0] = TSC40_CMD_ID;
+	if (write(fd, cmd, 1) != 1)
+		return -1;
+	
+	if (readchar(fd, &data, 100))
+		return -1;
+
+	/* if bit7 is not set --> EEPROM is used */
+	eeprom = !((data & 0x80) >> 7);
+	
+	/* ignore 2nd byte of ID cmd */
+	if (readchar(fd, &data, 100))
+		return -1;
+	
+	/* set coordinate oupt rate setting */
+	cmd[0] = TSC40_CMD_RATE;
+	cmd[1] = TSC40_RATE_150;
+	if (write(fd, cmd, 2) != 2)
+		return -1;
+	
+	/* read response */
+	if (readchar(fd, &data, 100))
+		return -1;
+	
+	if ((data == TSC40_NACK) && (eeprom == 1)) {
+		/* get detailed failure information */
+		if (readchar(fd, &data, 100))
+			return -1;
+
+		switch (data) {
+		case 0x02:	/* EEPROM data abnormal */
+		case 0x04:	/* EEPROM write error */
+		case 0x08:	/* Touch screen not connected */
+			return -1;
+			break;
+			
+		default:
+			/* 0x01: EEPROM data empty */
+			break;
+		}
+	}
+
+	/* start sending coordinate informations */
+	cmd[0] = TSC40_CMD_DATA1;
+	if (write(fd, cmd, 1) != 1)
+		return -1;
+
+	return 0;
+}
+
 static int t213_init(int fd, unsigned long *id, unsigned long *extra)
 {
 	char cmd[]={0x0a,1,'A'};
@@ -556,6 +632,9 @@
 { "--mtouch",		"-mtouch",	"MicroTouch (3M) touchscreen",
 	B9600, CS8 | CRTSCTS,
 	SERIO_MICROTOUCH,	0x00,	0x00,	0,	NULL },
+{ "--tsc",		"-tsc",		"TSC-10/25/40 serial touchscreen",
+	B9600, CS8,
+	SERIO_TSC40,		0x00,	0x00,	0,	tsc40_init },
 { "--touchit213",	"-t213",	"Sahara Touch-iT213 Tablet PC",
 	B9600, CS8,
 	SERIO_TOUCHIT213,	0x00,	0x00,	0,	t213_init },
