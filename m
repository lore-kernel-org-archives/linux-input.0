From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH 4/7] HID: picoLCD: satify some checkpatch warnings
Date: Mon, 30 Jul 2012 21:38:54 +0200
Message-ID: <20120730213854.4bb52224@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: static const char * array should probably be static const char=
 * const
+static const char *error_codes[] =3D {

WARNING: min() should probably be min_t(size_t, 20, s)
+       raw_data[2] =3D min((size_t)20, s);

Note: the second min_t suggestion cannot be followed because GCC is not
smart enough to track constants through it and make
copy_from_user_overflow() check happy.

WARNING: min() should probably be min_t(u8, 20, raw_data[2])
+       if (copy_from_user(raw_data+3, u, min((u8)20, raw_data[2])))
                return -EFAULT;

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd_debugfs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolc=
d_debugfs.c
index ff74645..f2491fa 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -135,7 +135,7 @@ static ssize_t picolcd_debug_eeprom_write(struct fi=
le *f, const char __user *u,
 	memset(raw_data, 0, sizeof(raw_data));
 	raw_data[0] =3D *off & 0xff;
 	raw_data[1] =3D (*off >> 8) & 0xff;
-	raw_data[2] =3D min((size_t)20, s);
+	raw_data[2] =3D min_t(size_t, 20, s);
 	if (*off + raw_data[2] > 0xff)
 		raw_data[2] =3D 0x100 - *off;
=20
@@ -370,7 +370,7 @@ static const struct file_operations picolcd_debug_f=
lash_fops =3D {
 /*
  * Helper code for HID report level dumping/debugging
  */
-static const char *error_codes[] =3D {
+static const char * const error_codes[] =3D {
 	"success", "parameter missing", "data_missing", "block readonly",
 	"block not erasable", "block too big", "section overflow",
 	"invalid command length", "invalid data length",
--=20
1.7.8.6
