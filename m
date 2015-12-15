From: =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?=
	<zboszormenyi@sicom.com>
Subject: [PATCH] Add support for the egalax serial touchscreen driver
Date: Tue, 15 Dec 2015 12:24:32 +0100
Message-ID: <1450178672-26885-1-git-send-email-zboszormenyi@sicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:55517 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965052AbbLOMJx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 07:09:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.com>
Cc: linux-input@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net, =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>

=46rom: B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n <zboszor@pr.hu>

Add inputattach support for the egalax serial touchscreen driver.

Signed-off-by: B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n <zboszor@pr.hu>

---
 utils/inputattach.c | 72 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 72 insertions(+)

diff --git a/utils/inputattach.c b/utils/inputattach.c
index bdaafa3..720a0b5 100644
--- a/utils/inputattach.c
+++ b/utils/inputattach.c
@@ -615,20 +615,82 @@ static int wacom_iv_init(int fd, unsigned long *i=
d, unsigned long *extra)
 	if (write(fd, WACOM_IV_RESET, WACOM_IV_RESET_LEN) !=3D WACOM_IV_RESET=
_LEN)
 		return -1;
 	usleep(75 * 1000);
 	if (write(fd, WACOM_IV_STOP, WACOM_IV_STOP_LEN) !=3D WACOM_IV_STOP_LE=
N)
 		return -1;
 	usleep(30 * 1000);
=20
 	return 0;
 }
=20
+static int check_egalax_response(int fd, unsigned char *command, int s=
z, unsigned char *response) {
+	int pos =3D 0;
+	int error =3D 0;
+	int rest_length;
+
+	if (write(fd, command, sz) !=3D sz)
+		return -1;
+
+	for (pos =3D 0; pos < 3; pos++) {
+		if (readchar(fd, &response[pos], 100)) {
+			error =3D 1;
+			break;
+		}
+	}
+
+	if (error)
+		return -1;
+
+	rest_length =3D response[1] - 1;
+
+	for (; rest_length; rest_length--, pos++) {
+		if (readchar(fd, &response[pos], 100)) {
+			error =3D 1;
+			break;
+		}
+	}
+
+	if (error)
+		return -1;
+
+	if (response[1] >=3D command[1] &&
+		response[0] =3D=3D command[0] &&
+		response[2] =3D=3D command[2])
+		return 0;
+
+	return -1;
+}
+
+static int egalax_init(int fd, unsigned long *id, unsigned long *extra=
) {
+	unsigned char packet_alive_query[3] =3D { 0x0a, 0x01, 'A' };
+	unsigned char packet_fw_ver[3] =3D { 0x0a, 0x01, 'D' };
+	unsigned char packet_ctrl_type[3] =3D { 0x0a, 0x01, 'E' };
+	unsigned char response[128];
+
+	if (check_egalax_response(fd, packet_alive_query, sizeof(packet_alive=
_query), response))
+		return -1;
+
+	if (check_egalax_response(fd, packet_fw_ver, sizeof(packet_fw_ver), r=
esponse))
+		return -1;
+
+	response[(unsigned char)response[1] + 2] =3D '\0';
+	printf("EETI eGalaxTouch firmware: %s\n", &response[3]);
+
+	if (check_egalax_response(fd, packet_ctrl_type, sizeof(packet_ctrl_ty=
pe), response))
+		return -1;
+
+	response[(unsigned char)response[1] + 2] =3D '\0';
+	printf("EETI eGalaxTouch controller type: %s\n", &response[3]);
+
+	return 0;
+}
+
 struct input_types {
 	const char *name;
 	const char *name2;
 	const char *desc;
 	int speed;
 	int flags;
 	unsigned long type;
 	unsigned long id;
 	unsigned long extra;
 	int flush;
@@ -700,32 +762,42 @@ static struct input_types input_types[] =3D {
 	SERIO_STOWAWAY,		0x00,	0x00,	1,	NULL },
 { "--ps2serkbd",	"-ps2ser",	"PS/2 via serial keyboard",
 	B1200, CS8,
 	SERIO_PS2SER,		0x00,	0x00,	1,	NULL },
 { "--twiddler",		"-twid",	"Handykey Twiddler chording keyboard",
 	B2400, CS8,
 	SERIO_TWIDKBD,		0x00,	0x00,	0,	twiddler_init },
 { "--twiddler-joy",	"-twidjoy",	"Handykey Twiddler used as a joystick"=
,
 	B2400, CS8,
 	SERIO_TWIDJOY,		0x00,	0x00,	0,	twiddler_init },
+#ifdef SERIO_EGALAX
+{ "--eetiegalax",	"-eeti",	"EETI eGalaxTouch",
+	B9600, CS8,
+	SERIO_EGALAX,		0x00,	0x00,	0,	egalax_init },
+#endif
 { "--elotouch",		"-elo",		"ELO touchscreen, 10-byte mode",
 	B9600, CS8,
 	SERIO_ELO,		0x00,	0x00,	0,	NULL },
 { "--elo4002",		"-elo6b",	"ELO touchscreen, 6-byte mode",
 	B9600, CS8 | CRTSCTS,
 	SERIO_ELO,		0x01,	0x00,	0,	NULL },
 { "--elo271-140",	"-elo4b",	"ELO touchscreen, 4-byte mode",
 	B9600, CS8 | CRTSCTS,
 	SERIO_ELO,		0x02,	0x00,	0,	NULL },
 { "--elo261-280",	"-elo3b",	"ELO Touchscreen, 3-byte mode",
 	B9600, CS8 | CRTSCTS,
 	SERIO_ELO,		0x03,	0x00,	0,	NULL },
+#ifdef SERIO_HAMPSHIRE
+{ "--hampshire",   "-ham",         "Hampshire touchscreen",
+	B9600, CS8,
+	SERIO_HAMPSHIRE,	0x00,   0x00,   0,  NULL },
+#endif
 { "--mtouch",		"-mtouch",	"MicroTouch (3M) touchscreen",
 	B9600, CS8 | CRTSCTS,
 	SERIO_MICROTOUCH,	0x00,	0x00,	0,	NULL },
 #ifdef SERIO_TSC40
 { "--tsc",		"-tsc",		"TSC-10/25/40 serial touchscreen",
 	B9600, CS8,
 	SERIO_TSC40,		0x00,	0x00,	0,	tsc40_init },
 #endif
 { "--touchit213",	"-t213",	"Sahara Touch-iT213 Tablet PC",
 	B9600, CS8,
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
