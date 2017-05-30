From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH v4] Input: mousedev - fix implicit conversion warning
Date: Mon, 29 May 2017 22:41:51 -0700
Message-ID: <20170530054151.16639-1-nick.desaulniers@gmail.com>
References: <20170526154029.9405-1-nick.desaulniers@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36069 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdE3FmJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 01:42:09 -0400
In-Reply-To: <20170526154029.9405-1-nick.desaulniers@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Clang warns:

drivers/input/mousedev.c:653:63: error: implicit conversion from 'int'
to 'signed char' changes value from 200 to -56
[-Wconstant-conversion]
  client->ps2[1] = 0x60; client->ps2[2] = 3; client->ps2[3] = 200;
                                                            ~ ^~~

As far as I can tell, from

http://www.computer-engineering.org/ps2mouse/

Under "Command Set" > "0xE9 (Status Request)"

the value 200 is a valid sample rate. Using unsigned char [], rather than
signed char [], for client->ps2 silences this warning.

Also moves some reused logic into a helper function.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
What's new in v4:
* replace mousedev_limit_delta() with update_clamped() that also updates
  the ps2_data and delta values. The use of the temporary val should
  avoid integral conversion and promotion issues.

 drivers/input/mousedev.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 0e0ff84088fd..e645b8c6f2cb 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -103,7 +103,7 @@ struct mousedev_client {
 	spinlock_t packet_lock;
 	int pos_x, pos_y;
 
-	signed char ps2[6];
+	unsigned char ps2[6];
 	unsigned char ready, buffer, bufsiz;
 	unsigned char imexseq, impsseq;
 	enum mousedev_emul mode;
@@ -571,27 +571,27 @@ static int mousedev_open(struct inode *inode, struct file *file)
 	return error;
 }
 
-static inline int mousedev_limit_delta(int delta, int limit)
+static inline void
+update_clamped(unsigned char *ps2_data, int *delta, int limit)
 {
-	return delta > limit ? limit : (delta < -limit ? -limit : delta);
+	int val = *delta > limit ? limit : (*delta < -limit ? -limit : *delta);
+	*ps2_data = (unsigned char) val;
+	*delta -= val;
 }
 
 static void mousedev_packet(struct mousedev_client *client,
-			    signed char *ps2_data)
+	unsigned char *ps2_data)
 {
 	struct mousedev_motion *p = &client->packets[client->tail];
 
 	ps2_data[0] = 0x08 |
 		((p->dx < 0) << 4) | ((p->dy < 0) << 5) | (p->buttons & 0x07);
-	ps2_data[1] = mousedev_limit_delta(p->dx, 127);
-	ps2_data[2] = mousedev_limit_delta(p->dy, 127);
-	p->dx -= ps2_data[1];
-	p->dy -= ps2_data[2];
+	update_clamped(&ps2_data[1], &p->dx, 127);
+	update_clamped(&ps2_data[2], &p->dy, 127);
 
 	switch (client->mode) {
 	case MOUSEDEV_EMUL_EXPS:
-		ps2_data[3] = mousedev_limit_delta(p->dz, 7);
-		p->dz -= ps2_data[3];
+		update_clamped(&ps2_data[3], &p->dz, 7);
 		ps2_data[3] = (ps2_data[3] & 0x0f) | ((p->buttons & 0x18) << 1);
 		client->bufsiz = 4;
 		break;
@@ -599,8 +599,7 @@ static void mousedev_packet(struct mousedev_client *client,
 	case MOUSEDEV_EMUL_IMPS:
 		ps2_data[0] |=
 			((p->buttons & 0x10) >> 3) | ((p->buttons & 0x08) >> 1);
-		ps2_data[3] = mousedev_limit_delta(p->dz, 127);
-		p->dz -= ps2_data[3];
+		update_clamped(&ps2_data[3], &p->dz, 127);
 		client->bufsiz = 4;
 		break;
 
-- 
2.11.0

