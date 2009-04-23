From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: [PATCH] Keypad controller driver for Intel Moorestwon platform
Date: Thu, 23 Apr 2009 14:50:20 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C1771573C36D@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_61563CE63B4F854986A895DA7AD3C1771573C36Dpdsmsx502ccrcor_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2081 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbZDWGwX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2009 02:52:23 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--_002_61563CE63B4F854986A895DA7AD3C1771573C36Dpdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to submit keypad driver patch based on Intel Moorestown platform, =
the details are given below:

Feature implemented:
Enabled keypad matrix key support. This keypad driver works like a normal k=
eyboard except for some function keys (Fn).

Dependency:
Keypad driver only works upon Moorestown GPIO module which hasn't been subm=
itted yet. The current version removed GPIO part.

Checkpatch:
total: 0 errors, 0 warnings, 782 lines checked

drivers/input/keyboard/mrst_keypad.c has no obvious style problems and is r=
eady for submission.

How to use this driver:
1. Add the patch to latest Linus tree
2. Select CONFIG_KEYBOARD_MRST
3. Make kernel

>From 5ba1666123e93196e89061f23e1c6a6e3b510065 Mon Sep 17 00:00:00 2001
From: Zheng Ba <zheng.ba@intel.com>
Date: Thu, 23 Apr 2009 14:19:56 +0800
Subject: [PATCH] Driver for the matrix keypad controller on Moorestown plat=
form

The keypad driver will work like a standard keyboard except for some functi=
on keys(Fn).

added: drivers/input/keyboard/mrst_keypad.c
modified: drivers/input/keyboard/Makefile
          drivers/input/keyboard/Kconfig

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
---
 drivers/input/keyboard/Kconfig       |    7 +
 drivers/input/keyboard/Makefile      |    1 +
 drivers/input/keyboard/mrst_keypad.c |  780 ++++++++++++++++++++++++++++++=
++++
 3 files changed, 788 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mrst_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
index ea2638b..f61a452 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -332,4 +332,11 @@ config KEYBOARD_SH_KEYSC

          To compile this driver as a module, choose M here: the
          module will be called sh_keysc.
+
+config KEYBOARD_MRST
+       tristate "MRST keypad support"
+       help
+         Say Y if you want to use the mrst keypad
+         depends on GPIO_MOORESTOWN
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index 36351e1..7b18336 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)          +=3D jornada720_kbd=
.o
 obj-$(CONFIG_KEYBOARD_MAPLE)           +=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)            +=3D bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)                +=3D sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MRST)            +=3D mrst_keypad.o
diff --git a/drivers/input/keyboard/mrst_keypad.c b/drivers/input/keyboard/=
mrst_keypad.c
new file mode 100644
index 0000000..b72d090
--- /dev/null
+++ b/drivers/input/keyboard/mrst_keypad.c
@@ -0,0 +1,780 @@
+/*
+ * linux/drivers/input/keyboard/mrst_keypad.c
+ *
+ * Driver for the matrix keypad controller on Moorestown platform.
+ *
+ * Copyright (c) 2009 Intel Corporation.
+ *
+ * Based on pxa27x_keypad.c by Rodolfo Giometti <giometti@linux.it>
+ * pxa27x_keypad.c is based on a previous implementation by Kevin O'Connor
+ * <kevin_at_keconnor.net> and Alex Osborne <bobofdoom@gmail.com> and
+ * on some suggestions by Nicolas Pitre <nico@cam.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#define DRV_NAME       "mrst_keypad"
+#define DRV_VERSION    "0.0.1"
+#define MRST_KEYPAD_DRIVER_NAME   DRV_NAME " " DRV_VERSION
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+
+/*
+ * Keypad Controller registers
+ */
+#define KPC             0x0000 /* Keypad Control register */
+#define KPDK            0x0004 /* Keypad Direct Key register */
+#define KPREC           0x0008 /* Keypad Rotary Encoder register */
+#define KPMK            0x000C /* Keypad Matrix Key register */
+#define KPAS            0x0010 /* Keypad Automatic Scan register */
+
+/* Keypad Automatic Scan Multiple Key Presser register 0-3 */
+#define KPASMKP0        0x0014
+#define KPASMKP1        0x0018
+#define KPASMKP2        0x001C
+#define KPASMKP3        0x0020
+#define KPKDI           0x0024
+
+/* bit definitions */
+#define KPC_MKRN(n)    ((((n) - 1) & 0x7) << 26) /* matrix key row number =
*/
+#define KPC_MKCN(n)    ((((n) - 1) & 0x7) << 23) /* matrix key col number =
*/
+#define KPC_DKN(n)     ((((n) - 1) & 0x7) << 6)  /* direct key number */
+
+#define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
+#define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */
+#define KPC_MI          (0x1 << 22)  /* Matrix interrupt bit */
+#define KPC_IMKP        (0x1 << 21)  /* Ignore Multiple Key Press */
+
+#define KPC_MS(n)      (0x1 << (13 + (n)))     /* Matrix scan line 'n' */
+#define KPC_MS_ALL      (0xff << 13)
+
+#define KPC_ME          (0x1 << 12)  /* Matrix Keypad Enable */
+#define KPC_MIE         (0x1 << 11)  /* Matrix Interrupt Enable */
+#define KPC_DK_DEB_SEL (0x1 <<  9)  /* Direct Keypad Debounce Select */
+#define KPC_DI          (0x1 <<  5)  /* Direct key interrupt bit */
+#define KPC_RE_ZERO_DEB (0x1 <<  4)  /* Rotary Encoder Zero Debounce */
+#define KPC_REE1        (0x1 <<  3)  /* Rotary Encoder1 Enable */
+#define KPC_REE0        (0x1 <<  2)  /* Rotary Encoder0 Enable */
+#define KPC_DE          (0x1 <<  1)  /* Direct Keypad Enable */
+#define KPC_DIE         (0x1 <<  0)  /* Direct Keypad interrupt Enable */
+
+#define KPDK_DKP        (0x1 << 31)
+#define KPDK_DK(n)     ((n) & 0xff)
+
+#define KPREC_OF1       (0x1 << 31)
+#define kPREC_UF1       (0x1 << 30)
+#define KPREC_OF0       (0x1 << 15)
+#define KPREC_UF0       (0x1 << 14)
+
+#define KPREC_RECOUNT0(n)      ((n) & 0xff)
+#define KPREC_RECOUNT1(n)      (((n) >> 16) & 0xff)
+
+#define KPMK_MKP        (0x1 << 31)
+#define KPAS_SO         (0x1 << 31)
+#define KPASMKPx_SO     (0x1 << 31)
+
+#define KPAS_MUKP(n)   (((n) >> 26) & 0x1f)
+#define KPAS_RP(n)     (((n) >> 4) & 0xf)
+#define KPAS_CP(n)     ((n) & 0xf)
+
+#define KPASMKP_MKC_MASK       (0xff)
+
+
+static struct pci_device_id keypad_pci_tbl[] =3D {
+       {0x8086, 0x0805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       {0,}
+};
+MODULE_DEVICE_TABLE(pci, keypad_pci_tbl);
+
+#define keypad_readl(off)      readl(keypad->mmio_base + (off))
+#define keypad_writel(off, v)  writel((v), keypad->mmio_base + (off))
+
+#define MAX_MATRIX_KEY_NUM     (8 * 8)
+#define MAX_DIRECT_KEY_NUM     (4)
+
+#define MAX_MATRIX_KEY_ROWS    (8)
+#define MAX_MATRIX_KEY_COLS    (8)
+#define DEBOUNCE_INTERVAL      100
+
+#define KEY_HALFSHUTTER                KEY_PROG1
+#define KEY_FULLSHUTTER                KEY_CAMERA
+
+static unsigned int mrst_keycode[MAX_MATRIX_KEY_NUM] =3D {
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3=
,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_U, KEY_7, KEY_M, KEY_J, KEY_8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y=
,
+       KEY_MINUS, KEY_0, KEY_LEFT, KEY_SEMICOLON, KEY_P, KEY_DOWN, KEY_UP,=
 \
+       KEY_BACKSPACE,
+       KEY_L, KEY_K, KEY_I, KEY_SLASH, KEY_COMMA, KEY_O, KEY_9, KEY_DOT,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN=
, \
+       KEY_A,
+       0, KEY_RIGHTSHIFT, KEY_ENTER, 0, KEY_RIGHT, 0, 0, 0,
+};
+
+/* NumLk key mapping */
+static unsigned int mrst_keycode_numlck[MAX_MATRIX_KEY_NUM] =3D {
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3=
,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_KP4, KEY_KP7, KEY_KP0, KEY_KP1, KEY_KP=
8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y=
,
+       KEY_MINUS, KEY_KPSLASH, KEY_LEFT, KEY_KPMINUS, KEY_KPASTERISK, \
+       KEY_DOWN, KEY_UP, KEY_BACKSPACE,
+       KEY_KP3, KEY_KP2, KEY_KP5, KEY_SLASH, KEY_KPDOT, KEY_KP6, KEY_KP9, =
\
+       KEY_KPPLUS,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN=
, \
+       KEY_A,
+       0, KEY_RIGHTSHIFT, KEY_ENTER, 0, KEY_RIGHT, 0, 0, 0,
+};
+
+/* Fn key mapping */
+static unsigned int mrst_keycode_fn[MAX_MATRIX_KEY_NUM] =3D {
+       0, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, 0, 0, 0, 0, 0, 0,
+       KEY_LEFTBRACE, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, KEY_HOME, 0, 0, KEY_PAGEDOWN, KEY_PAGEUP, 0,
+       0, 0, 0, KEY_RIGHTBRACE, KEY_LEFTBRACE, 0, 0, KEY_RIGHTBRACE,
+       0, 0, 0, KEY_LEFTSHIFT, 0, 0, KEY_FN, 0,
+       0, KEY_RIGHTSHIFT, 0, 0, KEY_END, 0, 0, 0,
+};
+
+/* direct key map */
+static unsigned int mrst_direct_keycode[MAX_DIRECT_KEY_NUM] =3D {
+       KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_HALFSHUTTER, KEY_FULLSHUTTER,
+};
+
+struct mrst_keypad {
+
+       struct input_dev *input_dev;
+       void __iomem *mmio_base;
+
+       unsigned int    matrix_key_rows;
+       unsigned int    matrix_key_cols;
+       int             matrix_key_map_size;
+
+       /* key debounce interval */
+       unsigned int    debounce_interval;
+
+       /* matrix key code map */
+       unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+
+       /* state row bits of each column scan */
+       uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
+       uint32_t direct_key_state;
+
+       unsigned int direct_key_mask;
+
+       int direct_key_num;
+
+       unsigned int direct_key_map[MAX_DIRECT_KEY_NUM];
+
+       /* rotary encoders 0 */
+       int enable_rotary0;
+       int rotary0_rel_code;
+       int rotary0_up_key;
+       int rotary0_down_key;
+
+       /* rotary encoders 1 */
+       int enable_rotary1;
+       int rotary1_rel_code;
+       int rotary1_up_key;
+       int rotary1_down_key;
+
+       int rotary_rel_code[2];
+       int rotary_up_key[2];
+       int rotary_down_key[2];
+
+       /* Fn key */
+       int fn;
+
+       /* Number Lock key */
+       int numlck;
+};
+
+static void mrst_keypad_build_keycode(struct mrst_keypad *keypad)
+{
+       struct input_dev *input_dev =3D keypad->input_dev;
+       unsigned int *key;
+       int i, code;
+
+       keypad->matrix_key_rows =3D MAX_MATRIX_KEY_ROWS;
+       keypad->matrix_key_cols =3D MAX_MATRIX_KEY_COLS;
+       keypad->matrix_key_map_size =3D MAX_MATRIX_KEY_NUM;
+       keypad->debounce_interval =3D DEBOUNCE_INTERVAL;
+
+       /* three sets of keycode here */
+       if (keypad->fn)
+               memcpy(keypad->matrix_keycodes, mrst_keycode_fn, \
+                      sizeof(keypad->matrix_keycodes));
+       else if (keypad->numlck)
+               memcpy(keypad->matrix_keycodes, mrst_keycode_numlck, \
+                      sizeof(keypad->matrix_keycodes));
+       else
+               memcpy(keypad->matrix_keycodes, mrst_keycode, \
+                      sizeof(keypad->matrix_keycodes));
+
+       memcpy(keypad->direct_key_map, mrst_direct_keycode, \
+              sizeof(keypad->direct_key_map));
+
+       key =3D &keypad->matrix_keycodes[0];
+       for (i =3D 0; i < MAX_MATRIX_KEY_NUM; i++, key++) {
+               code =3D (*key) & 0xffffff;
+               set_bit(code, input_dev->keybit);
+       }
+
+       key =3D &keypad->direct_key_map[0];
+       for (i =3D 0; i < MAX_DIRECT_KEY_NUM; i++, key++) {
+               code =3D (*key) & 0xffffff;
+               set_bit(code, input_dev->keybit);
+       }
+
+       keypad->direct_key_num =3D 0;
+       keypad->enable_rotary0 =3D 0;
+       keypad->enable_rotary1 =3D 0;
+
+}
+
+static inline unsigned int lookup_matrix_keycode(
+               struct mrst_keypad *keypad, int row, int col)
+{
+       return keypad->matrix_keycodes[(row << 3) + col];
+}
+
+static void handle_constant_keypress(struct mrst_keypad *keypad,
+                                    int num, int col, int row,
+                                    uint32_t *old_state)
+{
+       struct input_dev *dev =3D keypad->input_dev;
+       int state =3D old_state[col] & (1 << row);
+
+       switch (num) {
+       case 0:
+               if (keypad->fn)
+                       keypad->fn =3D 0;
+               /* Manually release special keys (Fn combinations) */
+               if (!!test_bit(KEY_LEFTBRACE, dev->key))
+                       input_report_key(dev, KEY_LEFTBRACE, 0);
+               if (!!test_bit(KEY_RIGHTBRACE, dev->key))
+                       input_report_key(dev, KEY_RIGHTBRACE, 0);
+               if (!!test_bit(KEY_HOME, dev->key))
+                       input_report_key(dev, KEY_RIGHTBRACE, 0);
+               if (!!test_bit(KEY_END, dev->key))
+                       input_report_key(dev, KEY_END, 0);
+               if (!!test_bit(KEY_PAGEUP, dev->key))
+                       input_report_key(dev, KEY_RIGHTBRACE, 0);
+               if (!!test_bit(KEY_PAGEDOWN, dev->key))
+                       input_report_key(dev, KEY_RIGHTBRACE, 0);
+
+               return;
+
+       case 1:
+               /* if Fn pressed */
+               if (col =3D=3D 6 && row =3D=3D 6)
+                       keypad->fn =3D 1;
+               /* key '[' */
+               else if ((col =3D=3D 0 && row =3D=3D 2) && state) {
+                       keypad->fn =3D 0;
+                       set_bit(KEY_EQUAL, dev->key);
+                       dev->repeat_key =3D KEY_EQUAL;
+               }
+               /* key ']' */
+               else if ((col =3D=3D 3 && row =3D=3D 5) && state) {
+                       keypad->fn =3D 0;
+                       set_bit(KEY_SLASH, dev->key);
+                       dev->repeat_key =3D KEY_SLASH;
+               }
+               /* key '{' */
+               else if ((col =3D=3D 4 && row =3D=3D 5) && state) {
+                       keypad->fn =3D 0;
+                       set_bit(KEY_COMMA, dev->key);
+                       dev->repeat_key =3D KEY_COMMA;
+               }
+               /* key '}' */
+               else if ((col =3D=3D 7 && row =3D=3D 5) && state) {
+                       keypad->fn =3D 0;
+                       set_bit(KEY_DOT, dev->key);
+                       dev->repeat_key =3D KEY_DOT;
+               }
+
+               return;
+       default:
+               ;
+       }
+}
+
+static void mrst_keypad_scan_matrix(struct mrst_keypad *keypad)
+{
+       int row, col, num_keys_pressed =3D 0;
+       uint32_t new_state[MAX_MATRIX_KEY_COLS];
+       uint32_t kpas =3D keypad_readl(KPAS);
+
+       num_keys_pressed =3D KPAS_MUKP(kpas);
+
+       memset(new_state, 0, sizeof(new_state));
+
+       if (num_keys_pressed =3D=3D 0) {
+               handle_constant_keypress(keypad, num_keys_pressed, 0, 0,
+                                        keypad->matrix_key_state);
+
+               goto scan;
+       }
+
+       if (num_keys_pressed =3D=3D 1) {
+               col =3D KPAS_CP(kpas);
+               row =3D KPAS_RP(kpas);
+
+               /* if invalid row/col, treat as no key pressed */
+               if (col >=3D keypad->matrix_key_cols ||
+                   row >=3D keypad->matrix_key_rows)
+                       goto scan;
+
+               /* if NumLk pressed */
+               if (col =3D=3D 0 && row =3D=3D 1)
+                       keypad->numlck =3D !keypad->numlck;
+
+               handle_constant_keypress(keypad, num_keys_pressed, col, row=
,
+                                        keypad->matrix_key_state);
+
+               new_state[col] =3D (1 << row);
+
+               goto scan;
+       }
+
+       if (num_keys_pressed > 1) {
+               uint32_t kpasmkp0 =3D keypad_readl(KPASMKP0);
+               uint32_t kpasmkp1 =3D keypad_readl(KPASMKP1);
+               uint32_t kpasmkp2 =3D keypad_readl(KPASMKP2);
+               uint32_t kpasmkp3 =3D keypad_readl(KPASMKP3);
+
+               new_state[0] =3D kpasmkp0 & KPASMKP_MKC_MASK;
+               new_state[1] =3D (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
+               new_state[2] =3D kpasmkp1 & KPASMKP_MKC_MASK;
+               new_state[3] =3D (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
+               new_state[4] =3D kpasmkp2 & KPASMKP_MKC_MASK;
+               new_state[5] =3D (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
+               new_state[6] =3D kpasmkp3 & KPASMKP_MKC_MASK;
+               new_state[7] =3D (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
+
+               /* if Fn is pressed, all SHIFT is ignored, except when {
+                * or } is pressed */
+               if (new_state[6] & 0x40) {
+                       keypad->fn =3D 1;
+                       new_state[3] &=3D ~0x40;
+                       new_state[1] &=3D ~0x80;
+               }
+
+               if (keypad->fn =3D=3D 1) {
+                       /* if { or } pressed */
+                       if ((new_state[4] & 0x20) || (new_state[7] & 0x20))=
 {
+                               /* as if LEFTSHIFT is pressed */
+                               new_state[3] |=3D 0x40;
+                               /* as if Fn not pressed */
+                               new_state[6] &=3D ~0x40;
+                       }
+                       /* if [ or ] pressed */
+                       if ((new_state[0] & 0x04) || (new_state[3] & 0x20))
+                               /* as if Fn not pressed */
+                               new_state[6] &=3D ~0x40;
+               }
+       }
+
+
+scan:
+       /* re-build keycode */
+       mrst_keypad_build_keycode(keypad);
+
+       for (col =3D 0; col < keypad->matrix_key_cols; col++) {
+               uint32_t bits_changed;
+
+               bits_changed =3D keypad->matrix_key_state[col] ^ new_state[=
col];
+               if (bits_changed =3D=3D 0)
+                       continue;
+
+               for (row =3D 0; row < keypad->matrix_key_rows; row++) {
+                       if ((bits_changed & (1 << row)) =3D=3D 0)
+                               continue;
+
+                       input_report_key(keypad->input_dev,
+                               lookup_matrix_keycode(keypad, row, col),
+                               new_state[col] & (1 << row));
+               }
+       }
+       input_sync(keypad->input_dev);
+       memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
+}
+
+#define DEFAULT_KPREC  (0x007f007f)
+
+static inline int rotary_delta(uint32_t kprec)
+{
+       if (kprec & KPREC_OF0)
+               return (kprec & 0xff) + 0x7f;
+       else if (kprec & KPREC_UF0)
+               return (kprec & 0xff) - 0x7f - 0xff;
+       else
+               return (kprec & 0xff) - 0x7f;
+}
+
+static void report_rotary_event(struct mrst_keypad *keypad, int r, int del=
ta)
+{
+       struct input_dev *dev =3D keypad->input_dev;
+
+       if (delta =3D=3D 0)
+               return;
+
+       if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
+               int keycode =3D (delta > 0) ? keypad->rotary_up_key[r] :
+                                           keypad->rotary_down_key[r];
+
+               /* simulate a press-n-release */
+               input_report_key(dev, keycode, 1);
+               input_sync(dev);
+               input_report_key(dev, keycode, 0);
+               input_sync(dev);
+       } else {
+               input_report_rel(dev, keypad->rotary_rel_code[r], delta);
+               input_sync(dev);
+       }
+}
+
+static void mrst_keypad_scan_rotary(struct mrst_keypad *keypad)
+{
+       unsigned int kprec;
+
+       /* read and reset to default count value */
+       kprec =3D keypad_readl(KPREC);
+       keypad_writel(KPREC, DEFAULT_KPREC);
+
+       if (keypad->enable_rotary0)
+               report_rotary_event(keypad, 0, rotary_delta(kprec));
+
+       if (keypad->enable_rotary1)
+               report_rotary_event(keypad, 1, rotary_delta(kprec >> 16));
+}
+
+static void mrst_keypad_scan_direct(struct mrst_keypad *keypad)
+{
+       unsigned int new_state;
+       uint32_t kpdk, bits_changed;
+       int i;
+
+       kpdk =3D keypad_readl(KPDK);
+
+       if (keypad->enable_rotary0 || keypad->enable_rotary1)
+               mrst_keypad_scan_rotary(keypad);
+
+       if (keypad->direct_key_map =3D=3D NULL) {
+               keypad->direct_key_state =3D 0;
+               return;
+       }
+
+       new_state =3D KPDK_DK(kpdk) & keypad->direct_key_mask;
+       new_state =3D ~new_state;
+       bits_changed =3D keypad->direct_key_state ^ new_state;
+
+       if (bits_changed =3D=3D 0)
+               return;
+
+       for (i =3D 0; i < keypad->direct_key_num; i++) {
+               if (bits_changed & (1 << i)) {
+                       input_report_key(keypad->input_dev,
+                                        keypad->direct_key_map[i],
+                                        (new_state & (1 << i)));
+               }
+       }
+       input_sync(keypad->input_dev);
+       keypad->direct_key_state =3D new_state;
+
+}
+
+static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
+{
+       struct mrst_keypad *keypad =3D dev_id;
+       unsigned long kpc =3D keypad_readl(KPC);
+
+       if (kpc & KPC_DI)
+               mrst_keypad_scan_direct(keypad);
+
+       if (kpc & KPC_MI)
+               mrst_keypad_scan_matrix(keypad);
+
+       return IRQ_HANDLED;
+}
+
+#if 0
+#define        KEYPAD_MATRIX_GPIO_IN_PIN       24
+#define        KEYPAD_MATRIX_GPIO_OUT_PIN      32
+#define KEYPAD_DIRECT_GPIO_IN_PIN      40
+static void mrst_keypad_gpio_init(void)
+{
+       int i;
+
+       for (i =3D 0; i < MAX_MATRIX_KEY_ROWS; i++) {
+               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
+               gpio_alt_func(KEYPAD_MATRIX_GPIO_IN_PIN + i, 1);
+       }
+
+       for (i =3D 0; i < MAX_MATRIX_KEY_COLS; i++) {
+               /* __gpio_set_value(KEYPAD_GPIO_OUT_PIN + i, 1); */
+               /* set action is executed in gpio_direction_output() */
+               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
+               gpio_alt_func(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
+       }
+
+       for (i =3D 0; i < MAX_DIRECT_KEY_NUM; i++) {
+               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
+               gpio_alt_func(KEYPAD_DIRECT_GPIO_IN_PIN + i, 1);
+       }
+}
+#endif
+
+static void mrst_keypad_config(struct mrst_keypad *keypad)
+{
+       unsigned int mask =3D 0, direct_key_num =3D 0;
+       unsigned long kpc =3D 0;
+
+       /* enable matrix keys with automatic scan */
+       if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
+               kpc |=3D KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
+               kpc |=3D KPC_MKRN(keypad->matrix_key_rows) |
+                      KPC_MKCN(keypad->matrix_key_cols);
+       }
+
+       /* enable rotary key, debounce interval same as direct keys */
+       if (keypad->enable_rotary0) {
+               mask |=3D 0x03;
+               direct_key_num =3D 2;
+               kpc |=3D KPC_REE0;
+       }
+
+       if (keypad->enable_rotary1) {
+               mask |=3D 0x0c;
+               direct_key_num =3D 4;
+               kpc |=3D KPC_REE1;
+       }
+
+       if (keypad->direct_key_num > direct_key_num)
+               direct_key_num =3D keypad->direct_key_num;
+
+       keypad->direct_key_mask =3D ((2 << direct_key_num) - 1) & ~mask;
+
+       /* enable direct key */
+       if (direct_key_num)
+               kpc |=3D KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
+
+       keypad_writel(KPC, kpc);
+       keypad_writel(KPREC, DEFAULT_KPREC);
+       keypad_writel(KPKDI, keypad->debounce_interval);
+}
+
+static int mrst_keypad_open(struct input_dev *dev)
+{
+       struct mrst_keypad *keypad =3D input_get_drvdata(dev);
+
+       /* depend on Moorestown GPIO driver...*/
+       /* mrst_keypad_gpio_init(); */
+       mrst_keypad_config(keypad);
+
+       return 0;
+}
+
+static void mrst_keypad_close(struct input_dev *dev)
+{
+       struct mrst_keypad *keypad ;
+       keypad =3D input_get_drvdata(dev);
+}
+
+#ifdef CONFIG_PM
+static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+       /* struct mrst_keypad *keypad =3D pci_get_drvdata(pdev); */
+
+       /* clk_disable(keypad->clk); */
+       return 0;
+}
+
+static int mrst_keypad_resume(struct pci_dev *pdev)
+{
+       struct mrst_keypad *keypad =3D pci_get_drvdata(pdev);
+       struct input_dev *input_dev =3D keypad->input_dev;
+
+       mutex_lock(&input_dev->mutex);
+
+       if (input_dev->users) {
+               /* Enable unit clock */
+               /* clk_enable(keypad->clk); */
+               mrst_keypad_config(keypad);
+       }
+
+       mutex_unlock(&input_dev->mutex);
+
+       return 0;
+}
+#else
+#define mrst_keypad_suspend    NULL
+#define mrst_keypad_resume     NULL
+#endif
+
+
+static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
+                       const struct pci_device_id *ent)
+{
+       struct mrst_keypad *keypad;
+       struct input_dev *input_dev;
+       int error;
+
+#ifndef MODULE
+       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
+#endif
+
+       keypad =3D kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
+       if (keypad =3D=3D NULL) {
+               dev_err(&pdev->dev, "failed to allocate driver data\n");
+               return -ENOMEM;
+       }
+
+       error =3D pci_enable_device(pdev);
+       if (error || (pdev->irq < 0)) {
+               dev_err(&pdev->dev, "failed to enable device/get irq\n");
+               error =3D -ENXIO;
+               goto failed_free;
+       }
+
+       error =3D pci_request_regions(pdev, DRV_NAME);
+       if (error) {
+               dev_err(&pdev->dev, "failed to request I/O memory\n");
+               goto failed_free;
+       }
+
+       keypad->mmio_base =3D ioremap(pci_resource_start(pdev, 0), \
+               pci_resource_len(pdev, 0));
+       if (keypad->mmio_base =3D=3D NULL) {
+               dev_err(&pdev->dev, "failed to remap I/O memory\n");
+               error =3D -ENXIO;
+               goto failed_free_mem;
+       }
+
+       /* Create and register the input driver. */
+       input_dev =3D input_allocate_device();
+       if (!input_dev) {
+               dev_err(&pdev->dev, "failed to allocate input device\n");
+               error =3D -ENOMEM;
+               goto failed_free_io;
+       }
+
+       input_dev->name =3D pci_name(pdev);
+       input_dev->id.bustype =3D BUS_PCI;
+       input_dev->open =3D mrst_keypad_open;
+       input_dev->close =3D mrst_keypad_close;
+       input_dev->dev.parent =3D &pdev->dev;
+
+       input_dev->keycode =3D keypad->matrix_keycodes;
+       input_dev->keycodesize =3D sizeof(unsigned int);
+       input_dev->keycodemax =3D ARRAY_SIZE(mrst_keycode);
+
+       keypad->input_dev =3D input_dev;
+       keypad->fn =3D 0;
+       keypad->numlck =3D 0;
+       input_set_drvdata(input_dev, keypad);
+
+       input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+               BIT_MASK(EV_REL);
+
+       mrst_keypad_build_keycode(keypad);
+       pci_set_drvdata(pdev, keypad);
+
+       error =3D request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHAR=
ED,
+               pci_name(pdev), keypad);
+       if (error) {
+               dev_err(&pdev->dev, "failed to request IRQ\n");
+               goto failed_free_dev;
+       }
+
+       /* Register the input device */
+       error =3D input_register_device(input_dev);
+       if (error) {
+               dev_err(&pdev->dev, "failed to register input device\n");
+               goto failed_free_irq;
+       }
+
+       printk(KERN_INFO "*** keypad driver load successfully ***\n");
+       return 0;
+
+failed_free_irq:
+       free_irq(pdev->irq, keypad);
+       pci_set_drvdata(pdev, NULL);
+failed_free_dev:
+       input_free_device(input_dev);
+failed_free_io:
+       iounmap(keypad->mmio_base);
+failed_free_mem:
+       pci_release_regions(pdev);
+failed_free:
+       kfree(keypad);
+       return error;
+}
+
+static void __devexit mrst_keypad_remove(struct pci_dev *pdev)
+{
+       struct mrst_keypad *keypad =3D pci_get_drvdata(pdev);
+
+       free_irq(pdev->irq, keypad);
+       input_unregister_device(keypad->input_dev);
+       iounmap(keypad->mmio_base);
+       pci_release_regions(pdev);
+       pci_set_drvdata(pdev, NULL);
+       kfree(keypad);
+}
+
+
+static struct pci_driver mrst_keypad_driver =3D {
+       .name           =3D DRV_NAME,
+       .id_table       =3D keypad_pci_tbl,
+       .probe          =3D mrst_keypad_probe,
+       .remove         =3D __devexit_p(mrst_keypad_remove),
+#ifdef CONFIG_PM
+       .suspend        =3D mrst_keypad_suspend,
+       .resume         =3D mrst_keypad_resume,
+#endif /* CONFIG_PM */
+};
+
+static int __init mrst_keypad_init(void)
+{
+#ifdef MODULE
+       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
+#endif
+
+       return pci_register_driver(&mrst_keypad_driver);
+}
+
+static void __exit mrst_keypad_exit(void)
+{
+       pci_unregister_driver(&mrst_keypad_driver);
+}
+
+module_init(mrst_keypad_init);
+module_exit(mrst_keypad_exit);
+
+MODULE_DESCRIPTION("MRST Keypad Controller Driver");
+MODULE_LICENSE("GPL v2");
--
1.5.2.5


--_002_61563CE63B4F854986A895DA7AD3C1771573C36Dpdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="Keypad-Moorestown-20090423.patch"
Content-Description: Keypad-Moorestown-20090423.patch
Content-Disposition: attachment;
	filename="Keypad-Moorestown-20090423.patch"; size=23739;
	creation-date="Thu, 23 Apr 2009 14:30:11 GMT";
	modification-date="Thu, 23 Apr 2009 14:20:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YmExNjY2MTIzZTkzMTk2ZTg5MDYxZjIzZTFjNmE2ZTNiNTEwMDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuZyBCYSA8emhlbmcuYmFAaW50ZWwuY29tPgpEYXRlOiBU
aHUsIDIzIEFwciAyMDA5IDE0OjE5OjU2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gRHJpdmVyIGZv
ciB0aGUgbWF0cml4IGtleXBhZCBjb250cm9sbGVyIG9uIE1vb3Jlc3Rvd24gcGxhdGZvcm0KClRo
ZSBrZXlwYWQgZHJpdmVyIHdpbGwgd29yayBsaWtlIGEgc3RhbmRhcmQga2V5Ym9hcmQgZXhjZXB0
IGZvciBzb21lIGZ1bmN0aW9uIGtleXMoRm4pLgoKYWRkZWQ6IGRyaXZlcnMvaW5wdXQva2V5Ym9h
cmQvbXJzdF9rZXlwYWQuYwptb2RpZmllZDogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmls
ZQoJICBkcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKClNpZ25lZC1vZmYtYnk6IFpoZW5n
IEJhIDx6aGVuZy5iYUBpbnRlbC5jb20+Ci0tLQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29u
ZmlnICAgICAgIHwgICAgNyArCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlICAgICAg
fCAgICAxICsKIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXJzdF9rZXlwYWQuYyB8ICA3ODAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA3ODggaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lu
cHV0L2tleWJvYXJkL21yc3Rfa2V5cGFkLmMKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL0tjb25maWcgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKaW5kZXggZWEy
NjM4Yi4uZjYxYTQ1MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmln
CisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZwpAQCAtMzMyLDQgKzMzMiwxMSBA
QCBjb25maWcgS0VZQk9BUkRfU0hfS0VZU0MKIAogCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBh
cyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlCiAJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQg
c2hfa2V5c2MuCisKK2NvbmZpZyBLRVlCT0FSRF9NUlNUCisJdHJpc3RhdGUgIk1SU1Qga2V5cGFk
IHN1cHBvcnQiCisJaGVscAorCSAgU2F5IFkgaWYgeW91IHdhbnQgdG8gdXNlIHRoZSBtcnN0IGtl
eXBhZAorCSAgZGVwZW5kcyBvbiBHUElPX01PT1JFU1RPV04KKwogZW5kaWYKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJk
L01ha2VmaWxlCmluZGV4IDM2MzUxZTEuLjdiMTgzMzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmls
ZQpAQCAtMjgsMyArMjgsNCBAQCBvYmotJChDT05GSUdfS0VZQk9BUkRfSFA3WFgpCQkrPSBqb3Ju
YWRhNzIwX2tiZC5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfTUFQTEUpCQkrPSBtYXBsZV9rZXli
Lm8KIG9iai0kKENPTkZJR19LRVlCT0FSRF9CRklOKQkJKz0gYmY1NHgta2V5cy5vCiBvYmotJChD
T05GSUdfS0VZQk9BUkRfU0hfS0VZU0MpCQkrPSBzaF9rZXlzYy5vCitvYmotJChDT05GSUdfS0VZ
Qk9BUkRfTVJTVCkJCSs9IG1yc3Rfa2V5cGFkLm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQv
a2V5Ym9hcmQvbXJzdF9rZXlwYWQuYyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXJzdF9rZXlw
YWQuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5iNzJkMDkwCi0tLSAvZGV2
L251bGwKKysrIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tcnN0X2tleXBhZC5jCkBAIC0wLDAg
KzEsNzgwIEBACisvKgorICogbGludXgvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tcnN0X2tleXBh
ZC5jCisgKgorICogRHJpdmVyIGZvciB0aGUgbWF0cml4IGtleXBhZCBjb250cm9sbGVyIG9uIE1v
b3Jlc3Rvd24gcGxhdGZvcm0uCisgKgorICogQ29weXJpZ2h0IChjKSAyMDA5IEludGVsIENvcnBv
cmF0aW9uLgorICoKKyAqIEJhc2VkIG9uIHB4YTI3eF9rZXlwYWQuYyBieSBSb2RvbGZvIEdpb21l
dHRpIDxnaW9tZXR0aUBsaW51eC5pdD4KKyAqIHB4YTI3eF9rZXlwYWQuYyBpcyBiYXNlZCBvbiBh
IHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGJ5IEtldmluIE8nQ29ubm9yCisgKiA8a2V2aW5fYXRf
a2Vjb25ub3IubmV0PiBhbmQgQWxleCBPc2Jvcm5lIDxib2JvZmRvb21AZ21haWwuY29tPiBhbmQK
KyAqIG9uIHNvbWUgc3VnZ2VzdGlvbnMgYnkgTmljb2xhcyBQaXRyZSA8bmljb0BjYW0ub3JnPgor
ICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1bmRlciB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLAorICogdmVyc2lvbiAyLCBhcyBwdWJs
aXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRI
T1VUCisgKiBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
ZiBNRVJDSEFOVEFCSUxJVFkgb3IKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAqIG1vcmUgZGV0YWls
cy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgKiB0aGlzIHByb2dyYW07IGlmIG5vdCwg
d3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyAqIDUxIEZyYW5r
bGluIFN0IC0gRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCisgKgorICov
CisKKyNkZWZpbmUgRFJWX05BTUUJIm1yc3Rfa2V5cGFkIgorI2RlZmluZSBEUlZfVkVSU0lPTgki
MC4wLjEiCisjZGVmaW5lIE1SU1RfS0VZUEFEX0RSSVZFUl9OQU1FICAgRFJWX05BTUUgIiAiIERS
Vl9WRVJTSU9OCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4K
KyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4KKyNpbmNs
dWRlIDxsaW51eC9ncGlvLmg+CisKKy8qCisgKiBLZXlwYWQgQ29udHJvbGxlciByZWdpc3RlcnMK
KyAqLworI2RlZmluZSBLUEMgICAgICAgICAgICAgMHgwMDAwIC8qIEtleXBhZCBDb250cm9sIHJl
Z2lzdGVyICovCisjZGVmaW5lIEtQREsgICAgICAgICAgICAweDAwMDQgLyogS2V5cGFkIERpcmVj
dCBLZXkgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BSRUMgICAgICAgICAgIDB4MDAwOCAvKiBLZXlw
YWQgUm90YXJ5IEVuY29kZXIgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BNSyAgICAgICAgICAgIDB4
MDAwQyAvKiBLZXlwYWQgTWF0cml4IEtleSByZWdpc3RlciAqLworI2RlZmluZSBLUEFTICAgICAg
ICAgICAgMHgwMDEwIC8qIEtleXBhZCBBdXRvbWF0aWMgU2NhbiByZWdpc3RlciAqLworCisvKiBL
ZXlwYWQgQXV0b21hdGljIFNjYW4gTXVsdGlwbGUgS2V5IFByZXNzZXIgcmVnaXN0ZXIgMC0zICov
CisjZGVmaW5lIEtQQVNNS1AwICAgICAgICAweDAwMTQKKyNkZWZpbmUgS1BBU01LUDEgICAgICAg
IDB4MDAxOAorI2RlZmluZSBLUEFTTUtQMiAgICAgICAgMHgwMDFDCisjZGVmaW5lIEtQQVNNS1Az
ICAgICAgICAweDAwMjAKKyNkZWZpbmUgS1BLREkgICAgICAgICAgIDB4MDAyNAorCisvKiBiaXQg
ZGVmaW5pdGlvbnMgKi8KKyNkZWZpbmUgS1BDX01LUk4obikJKCgoKG4pIC0gMSkgJiAweDcpIDw8
IDI2KSAvKiBtYXRyaXgga2V5IHJvdyBudW1iZXIgKi8KKyNkZWZpbmUgS1BDX01LQ04obikJKCgo
KG4pIC0gMSkgJiAweDcpIDw8IDIzKSAvKiBtYXRyaXgga2V5IGNvbCBudW1iZXIgKi8KKyNkZWZp
bmUgS1BDX0RLTihuKQkoKCgobikgLSAxKSAmIDB4NykgPDwgNikgIC8qIGRpcmVjdCBrZXkgbnVt
YmVyICovCisKKyNkZWZpbmUgS1BDX0FTICAgICAgICAgICgweDEgPDwgMzApICAvKiBBdXRvbWF0
aWMgU2NhbiBiaXQgKi8KKyNkZWZpbmUgS1BDX0FTQUNUICAgICAgICgweDEgPDwgMjkpICAvKiBB
dXRvbWF0aWMgU2NhbiBvbiBBY3Rpdml0eSAqLworI2RlZmluZSBLUENfTUkgICAgICAgICAgKDB4
MSA8PCAyMikgIC8qIE1hdHJpeCBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5lIEtQQ19JTUtQICAg
ICAgICAoMHgxIDw8IDIxKSAgLyogSWdub3JlIE11bHRpcGxlIEtleSBQcmVzcyAqLworCisjZGVm
aW5lIEtQQ19NUyhuKQkoMHgxIDw8ICgxMyArIChuKSkpCS8qIE1hdHJpeCBzY2FuIGxpbmUgJ24n
ICovCisjZGVmaW5lIEtQQ19NU19BTEwgICAgICAoMHhmZiA8PCAxMykKKworI2RlZmluZSBLUENf
TUUgICAgICAgICAgKDB4MSA8PCAxMikgIC8qIE1hdHJpeCBLZXlwYWQgRW5hYmxlICovCisjZGVm
aW5lIEtQQ19NSUUgICAgICAgICAoMHgxIDw8IDExKSAgLyogTWF0cml4IEludGVycnVwdCBFbmFi
bGUgKi8KKyNkZWZpbmUgS1BDX0RLX0RFQl9TRUwJKDB4MSA8PCAgOSkgIC8qIERpcmVjdCBLZXlw
YWQgRGVib3VuY2UgU2VsZWN0ICovCisjZGVmaW5lIEtQQ19ESSAgICAgICAgICAoMHgxIDw8ICA1
KSAgLyogRGlyZWN0IGtleSBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5lIEtQQ19SRV9aRVJPX0RF
QiAoMHgxIDw8ICA0KSAgLyogUm90YXJ5IEVuY29kZXIgWmVybyBEZWJvdW5jZSAqLworI2RlZmlu
ZSBLUENfUkVFMSAgICAgICAgKDB4MSA8PCAgMykgIC8qIFJvdGFyeSBFbmNvZGVyMSBFbmFibGUg
Ki8KKyNkZWZpbmUgS1BDX1JFRTAgICAgICAgICgweDEgPDwgIDIpICAvKiBSb3RhcnkgRW5jb2Rl
cjAgRW5hYmxlICovCisjZGVmaW5lIEtQQ19ERSAgICAgICAgICAoMHgxIDw8ICAxKSAgLyogRGly
ZWN0IEtleXBhZCBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX0RJRSAgICAgICAgICgweDEgPDwgIDAp
ICAvKiBEaXJlY3QgS2V5cGFkIGludGVycnVwdCBFbmFibGUgKi8KKworI2RlZmluZSBLUERLX0RL
UCAgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUgS1BES19ESyhuKQkoKG4pICYgMHhmZikKKwor
I2RlZmluZSBLUFJFQ19PRjEgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUga1BSRUNfVUYxICAg
ICAgICgweDEgPDwgMzApCisjZGVmaW5lIEtQUkVDX09GMCAgICAgICAoMHgxIDw8IDE1KQorI2Rl
ZmluZSBLUFJFQ19VRjAgICAgICAgKDB4MSA8PCAxNCkKKworI2RlZmluZSBLUFJFQ19SRUNPVU5U
MChuKQkoKG4pICYgMHhmZikKKyNkZWZpbmUgS1BSRUNfUkVDT1VOVDEobikJKCgobikgPj4gMTYp
ICYgMHhmZikKKworI2RlZmluZSBLUE1LX01LUCAgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUg
S1BBU19TTyAgICAgICAgICgweDEgPDwgMzEpCisjZGVmaW5lIEtQQVNNS1B4X1NPICAgICAoMHgx
IDw8IDMxKQorCisjZGVmaW5lIEtQQVNfTVVLUChuKQkoKChuKSA+PiAyNikgJiAweDFmKQorI2Rl
ZmluZSBLUEFTX1JQKG4pCSgoKG4pID4+IDQpICYgMHhmKQorI2RlZmluZSBLUEFTX0NQKG4pCSgo
bikgJiAweGYpCisKKyNkZWZpbmUgS1BBU01LUF9NS0NfTUFTSwkoMHhmZikKKworCitzdGF0aWMg
c3RydWN0IHBjaV9kZXZpY2VfaWQga2V5cGFkX3BjaV90YmxbXSA9IHsKKwl7MHg4MDg2LCAweDA4
MDUsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDAgfSwKKwl7MCx9Cit9OworTU9EVUxF
X0RFVklDRV9UQUJMRShwY2ksIGtleXBhZF9wY2lfdGJsKTsKKworI2RlZmluZSBrZXlwYWRfcmVh
ZGwob2ZmKQlyZWFkbChrZXlwYWQtPm1taW9fYmFzZSArIChvZmYpKQorI2RlZmluZSBrZXlwYWRf
d3JpdGVsKG9mZiwgdikJd3JpdGVsKCh2KSwga2V5cGFkLT5tbWlvX2Jhc2UgKyAob2ZmKSkKKwor
I2RlZmluZSBNQVhfTUFUUklYX0tFWV9OVU0JKDggKiA4KQorI2RlZmluZSBNQVhfRElSRUNUX0tF
WV9OVU0JKDQpCisKKyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfUk9XUwkoOCkKKyNkZWZpbmUgTUFY
X01BVFJJWF9LRVlfQ09MUwkoOCkKKyNkZWZpbmUgREVCT1VOQ0VfSU5URVJWQUwJMTAwCisKKyNk
ZWZpbmUgS0VZX0hBTEZTSFVUVEVSCQlLRVlfUFJPRzEKKyNkZWZpbmUgS0VZX0ZVTExTSFVUVEVS
CQlLRVlfQ0FNRVJBCisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXJzdF9rZXljb2RlW01BWF9NQVRS
SVhfS0VZX05VTV0gPSB7CisJS0VZX0YsIEtFWV9ELCBLRVlfRSwgS0VZX0dSQVZFLCBLRVlfQywg
S0VZX1IsIEtFWV80LCBLRVlfViwKKwlLRVlfTlVNTE9DSywgS0VZX0xFRlRDVFJMLCBLRVlfWiwg
S0VZX1csIEtFWV8yLCBLRVlfWCwgS0VZX1MsIEtFWV8zLAorCUtFWV9FUVVBTCwgS0VZX04sIEtF
WV9ILCBLRVlfVSwgS0VZXzcsIEtFWV9NLCBLRVlfSiwgS0VZXzgsCisJS0VZXzYsIEtFWV81LCBL
RVlfQVBPU1RST1BIRSwgS0VZX0csIEtFWV9ULCBLRVlfU1BBQ0UsIEtFWV9CLCBLRVlfWSwKKwlL
RVlfTUlOVVMsIEtFWV8wLCBLRVlfTEVGVCwgS0VZX1NFTUlDT0xPTiwgS0VZX1AsIEtFWV9ET1dO
LCBLRVlfVVAsIFwKKwlLRVlfQkFDS1NQQUNFLAorCUtFWV9MLCBLRVlfSywgS0VZX0ksIEtFWV9T
TEFTSCwgS0VZX0NPTU1BLCBLRVlfTywgS0VZXzksIEtFWV9ET1QsCisJS0VZX1EsIEtFWV9UQUIs
IEtFWV9FU0MsIEtFWV9MRUZUU0hJRlQsIEtFWV9DQVBTTE9DSywgS0VZXzEsIEtFWV9GTiwgXAor
CUtFWV9BLAorCTAsIEtFWV9SSUdIVFNISUZULCBLRVlfRU5URVIsIDAsIEtFWV9SSUdIVCwgMCwg
MCwgMCwKK307CisKKy8qIE51bUxrIGtleSBtYXBwaW5nICovCitzdGF0aWMgdW5zaWduZWQgaW50
IG1yc3Rfa2V5Y29kZV9udW1sY2tbTUFYX01BVFJJWF9LRVlfTlVNXSA9IHsKKwlLRVlfRiwgS0VZ
X0QsIEtFWV9FLCBLRVlfR1JBVkUsIEtFWV9DLCBLRVlfUiwgS0VZXzQsIEtFWV9WLAorCUtFWV9O
VU1MT0NLLCBLRVlfTEVGVENUUkwsIEtFWV9aLCBLRVlfVywgS0VZXzIsIEtFWV9YLCBLRVlfUywg
S0VZXzMsCisJS0VZX0VRVUFMLCBLRVlfTiwgS0VZX0gsIEtFWV9LUDQsIEtFWV9LUDcsIEtFWV9L
UDAsIEtFWV9LUDEsIEtFWV9LUDgsCisJS0VZXzYsIEtFWV81LCBLRVlfQVBPU1RST1BIRSwgS0VZ
X0csIEtFWV9ULCBLRVlfU1BBQ0UsIEtFWV9CLCBLRVlfWSwKKwlLRVlfTUlOVVMsIEtFWV9LUFNM
QVNILCBLRVlfTEVGVCwgS0VZX0tQTUlOVVMsIEtFWV9LUEFTVEVSSVNLLCBcCisJS0VZX0RPV04s
IEtFWV9VUCwgS0VZX0JBQ0tTUEFDRSwKKwlLRVlfS1AzLCBLRVlfS1AyLCBLRVlfS1A1LCBLRVlf
U0xBU0gsIEtFWV9LUERPVCwgS0VZX0tQNiwgS0VZX0tQOSwgXAorCUtFWV9LUFBMVVMsCisJS0VZ
X1EsIEtFWV9UQUIsIEtFWV9FU0MsIEtFWV9MRUZUU0hJRlQsIEtFWV9DQVBTTE9DSywgS0VZXzEs
IEtFWV9GTiwgXAorCUtFWV9BLAorCTAsIEtFWV9SSUdIVFNISUZULCBLRVlfRU5URVIsIDAsIEtF
WV9SSUdIVCwgMCwgMCwgMCwKK307CisKKy8qIEZuIGtleSBtYXBwaW5nICovCitzdGF0aWMgdW5z
aWduZWQgaW50IG1yc3Rfa2V5Y29kZV9mbltNQVhfTUFUUklYX0tFWV9OVU1dID0geworCTAsIDAs
IDAsIDAsIDAsIDAsIDAsIDAsCisJMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwKKwlLRVlfTEVGVEJS
QUNFLCAwLCAwLCAwLCAwLCAwLCAwLCAwLAorCTAsIDAsIDAsIDAsIDAsIDAsIDAsIDAsCisJMCwg
MCwgS0VZX0hPTUUsIDAsIDAsIEtFWV9QQUdFRE9XTiwgS0VZX1BBR0VVUCwgMCwKKwkwLCAwLCAw
LCBLRVlfUklHSFRCUkFDRSwgS0VZX0xFRlRCUkFDRSwgMCwgMCwgS0VZX1JJR0hUQlJBQ0UsCisJ
MCwgMCwgMCwgS0VZX0xFRlRTSElGVCwgMCwgMCwgS0VZX0ZOLCAwLAorCTAsIEtFWV9SSUdIVFNI
SUZULCAwLCAwLCBLRVlfRU5ELCAwLCAwLCAwLAorfTsKKworLyogZGlyZWN0IGtleSBtYXAgKi8K
K3N0YXRpYyB1bnNpZ25lZCBpbnQgbXJzdF9kaXJlY3Rfa2V5Y29kZVtNQVhfRElSRUNUX0tFWV9O
VU1dID0geworCUtFWV9WT0xVTUVVUCwgS0VZX1ZPTFVNRURPV04sIEtFWV9IQUxGU0hVVFRFUiwg
S0VZX0ZVTExTSFVUVEVSLAorfTsKKworc3RydWN0IG1yc3Rfa2V5cGFkIHsKKworCXN0cnVjdCBp
bnB1dF9kZXYgKmlucHV0X2RldjsKKwl2b2lkIF9faW9tZW0gKm1taW9fYmFzZTsKKworCXVuc2ln
bmVkIGludAltYXRyaXhfa2V5X3Jvd3M7CisJdW5zaWduZWQgaW50CW1hdHJpeF9rZXlfY29sczsK
KwlpbnQJCW1hdHJpeF9rZXlfbWFwX3NpemU7CisKKwkvKiBrZXkgZGVib3VuY2UgaW50ZXJ2YWwg
Ki8KKwl1bnNpZ25lZCBpbnQJZGVib3VuY2VfaW50ZXJ2YWw7CisKKwkvKiBtYXRyaXgga2V5IGNv
ZGUgbWFwICovCisJdW5zaWduZWQgaW50IG1hdHJpeF9rZXljb2Rlc1tNQVhfTUFUUklYX0tFWV9O
VU1dOworCisJLyogc3RhdGUgcm93IGJpdHMgb2YgZWFjaCBjb2x1bW4gc2NhbiAqLworCXVpbnQz
Ml90IG1hdHJpeF9rZXlfc3RhdGVbTUFYX01BVFJJWF9LRVlfQ09MU107CisJdWludDMyX3QgZGly
ZWN0X2tleV9zdGF0ZTsKKworCXVuc2lnbmVkIGludCBkaXJlY3Rfa2V5X21hc2s7CisKKwlpbnQg
ZGlyZWN0X2tleV9udW07CisKKwl1bnNpZ25lZCBpbnQgZGlyZWN0X2tleV9tYXBbTUFYX0RJUkVD
VF9LRVlfTlVNXTsKKworCS8qIHJvdGFyeSBlbmNvZGVycyAwICovCisJaW50IGVuYWJsZV9yb3Rh
cnkwOworCWludCByb3RhcnkwX3JlbF9jb2RlOworCWludCByb3RhcnkwX3VwX2tleTsKKwlpbnQg
cm90YXJ5MF9kb3duX2tleTsKKworCS8qIHJvdGFyeSBlbmNvZGVycyAxICovCisJaW50IGVuYWJs
ZV9yb3RhcnkxOworCWludCByb3RhcnkxX3JlbF9jb2RlOworCWludCByb3RhcnkxX3VwX2tleTsK
KwlpbnQgcm90YXJ5MV9kb3duX2tleTsKKworCWludCByb3RhcnlfcmVsX2NvZGVbMl07CisJaW50
IHJvdGFyeV91cF9rZXlbMl07CisJaW50IHJvdGFyeV9kb3duX2tleVsyXTsKKworCS8qIEZuIGtl
eSAqLworCWludCBmbjsKKworCS8qIE51bWJlciBMb2NrIGtleSAqLworCWludCBudW1sY2s7Cit9
OworCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9idWlsZF9rZXljb2RlKHN0cnVjdCBtcnN0X2tl
eXBhZCAqa2V5cGFkKQoreworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldiA9IGtleXBhZC0+
aW5wdXRfZGV2OworCXVuc2lnbmVkIGludCAqa2V5OworCWludCBpLCBjb2RlOworCisJa2V5cGFk
LT5tYXRyaXhfa2V5X3Jvd3MgPSBNQVhfTUFUUklYX0tFWV9ST1dTOworCWtleXBhZC0+bWF0cml4
X2tleV9jb2xzID0gTUFYX01BVFJJWF9LRVlfQ09MUzsKKwlrZXlwYWQtPm1hdHJpeF9rZXlfbWFw
X3NpemUgPSBNQVhfTUFUUklYX0tFWV9OVU07CisJa2V5cGFkLT5kZWJvdW5jZV9pbnRlcnZhbCA9
IERFQk9VTkNFX0lOVEVSVkFMOworCisJLyogdGhyZWUgc2V0cyBvZiBrZXljb2RlIGhlcmUgKi8K
KwlpZiAoa2V5cGFkLT5mbikKKwkJbWVtY3B5KGtleXBhZC0+bWF0cml4X2tleWNvZGVzLCBtcnN0
X2tleWNvZGVfZm4sIFwKKwkJICAgICAgIHNpemVvZihrZXlwYWQtPm1hdHJpeF9rZXljb2Rlcykp
OworCWVsc2UgaWYgKGtleXBhZC0+bnVtbGNrKQorCQltZW1jcHkoa2V5cGFkLT5tYXRyaXhfa2V5
Y29kZXMsIG1yc3Rfa2V5Y29kZV9udW1sY2ssIFwKKwkJICAgICAgIHNpemVvZihrZXlwYWQtPm1h
dHJpeF9rZXljb2RlcykpOworCWVsc2UKKwkJbWVtY3B5KGtleXBhZC0+bWF0cml4X2tleWNvZGVz
LCBtcnN0X2tleWNvZGUsIFwKKwkJICAgICAgIHNpemVvZihrZXlwYWQtPm1hdHJpeF9rZXljb2Rl
cykpOworCisJbWVtY3B5KGtleXBhZC0+ZGlyZWN0X2tleV9tYXAsIG1yc3RfZGlyZWN0X2tleWNv
ZGUsIFwKKwkgICAgICAgc2l6ZW9mKGtleXBhZC0+ZGlyZWN0X2tleV9tYXApKTsKKworCWtleSA9
ICZrZXlwYWQtPm1hdHJpeF9rZXljb2Rlc1swXTsKKwlmb3IgKGkgPSAwOyBpIDwgTUFYX01BVFJJ
WF9LRVlfTlVNOyBpKyssIGtleSsrKSB7CisJCWNvZGUgPSAoKmtleSkgJiAweGZmZmZmZjsKKwkJ
c2V0X2JpdChjb2RlLCBpbnB1dF9kZXYtPmtleWJpdCk7CisJfQorCisJa2V5ID0gJmtleXBhZC0+
ZGlyZWN0X2tleV9tYXBbMF07CisJZm9yIChpID0gMDsgaSA8IE1BWF9ESVJFQ1RfS0VZX05VTTsg
aSsrLCBrZXkrKykgeworCQljb2RlID0gKCprZXkpICYgMHhmZmZmZmY7CisJCXNldF9iaXQoY29k
ZSwgaW5wdXRfZGV2LT5rZXliaXQpOworCX0KKworCWtleXBhZC0+ZGlyZWN0X2tleV9udW0gPSAw
OworCWtleXBhZC0+ZW5hYmxlX3JvdGFyeTAgPSAwOworCWtleXBhZC0+ZW5hYmxlX3JvdGFyeTEg
PSAwOworCit9CisKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGxvb2t1cF9tYXRyaXhfa2V5
Y29kZSgKKwkJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQsIGludCByb3csIGludCBjb2wpCit7
CisJcmV0dXJuIGtleXBhZC0+bWF0cml4X2tleWNvZGVzWyhyb3cgPDwgMykgKyBjb2xdOworfQor
CitzdGF0aWMgdm9pZCBoYW5kbGVfY29uc3RhbnRfa2V5cHJlc3Moc3RydWN0IG1yc3Rfa2V5cGFk
ICprZXlwYWQsCisJCQkJICAgICBpbnQgbnVtLCBpbnQgY29sLCBpbnQgcm93LAorCQkJCSAgICAg
dWludDMyX3QgKm9sZF9zdGF0ZSkKK3sKKwlzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYgPSBrZXlwYWQt
PmlucHV0X2RldjsKKwlpbnQgc3RhdGUgPSBvbGRfc3RhdGVbY29sXSAmICgxIDw8IHJvdyk7CisK
Kwlzd2l0Y2ggKG51bSkgeworCWNhc2UgMDoKKwkJaWYgKGtleXBhZC0+Zm4pCisJCQlrZXlwYWQt
PmZuID0gMDsKKwkJLyogTWFudWFsbHkgcmVsZWFzZSBzcGVjaWFsIGtleXMgKEZuIGNvbWJpbmF0
aW9ucykgKi8KKwkJaWYgKCEhdGVzdF9iaXQoS0VZX0xFRlRCUkFDRSwgZGV2LT5rZXkpKQorCQkJ
aW5wdXRfcmVwb3J0X2tleShkZXYsIEtFWV9MRUZUQlJBQ0UsIDApOworCQlpZiAoISF0ZXN0X2Jp
dChLRVlfUklHSFRCUkFDRSwgZGV2LT5rZXkpKQorCQkJaW5wdXRfcmVwb3J0X2tleShkZXYsIEtF
WV9SSUdIVEJSQUNFLCAwKTsKKwkJaWYgKCEhdGVzdF9iaXQoS0VZX0hPTUUsIGRldi0+a2V5KSkK
KwkJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBLRVlfUklHSFRCUkFDRSwgMCk7CisJCWlmICghIXRl
c3RfYml0KEtFWV9FTkQsIGRldi0+a2V5KSkKKwkJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBLRVlf
RU5ELCAwKTsKKwkJaWYgKCEhdGVzdF9iaXQoS0VZX1BBR0VVUCwgZGV2LT5rZXkpKQorCQkJaW5w
dXRfcmVwb3J0X2tleShkZXYsIEtFWV9SSUdIVEJSQUNFLCAwKTsKKwkJaWYgKCEhdGVzdF9iaXQo
S0VZX1BBR0VET1dOLCBkZXYtPmtleSkpCisJCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwgS0VZX1JJ
R0hUQlJBQ0UsIDApOworCisJCXJldHVybjsKKworCWNhc2UgMToKKwkJLyogaWYgRm4gcHJlc3Nl
ZCAqLworCQlpZiAoY29sID09IDYgJiYgcm93ID09IDYpCisJCQlrZXlwYWQtPmZuID0gMTsKKwkJ
Lyoga2V5ICdbJyAqLworCQllbHNlIGlmICgoY29sID09IDAgJiYgcm93ID09IDIpICYmIHN0YXRl
KSB7CisJCQlrZXlwYWQtPmZuID0gMDsKKwkJCXNldF9iaXQoS0VZX0VRVUFMLCBkZXYtPmtleSk7
CisJCQlkZXYtPnJlcGVhdF9rZXkgPSBLRVlfRVFVQUw7CisJCX0KKwkJLyoga2V5ICddJyAqLwor
CQllbHNlIGlmICgoY29sID09IDMgJiYgcm93ID09IDUpICYmIHN0YXRlKSB7CisJCQlrZXlwYWQt
PmZuID0gMDsKKwkJCXNldF9iaXQoS0VZX1NMQVNILCBkZXYtPmtleSk7CisJCQlkZXYtPnJlcGVh
dF9rZXkgPSBLRVlfU0xBU0g7CisJCX0KKwkJLyoga2V5ICd7JyAqLworCQllbHNlIGlmICgoY29s
ID09IDQgJiYgcm93ID09IDUpICYmIHN0YXRlKSB7CisJCQlrZXlwYWQtPmZuID0gMDsKKwkJCXNl
dF9iaXQoS0VZX0NPTU1BLCBkZXYtPmtleSk7CisJCQlkZXYtPnJlcGVhdF9rZXkgPSBLRVlfQ09N
TUE7CisJCX0KKwkJLyoga2V5ICd9JyAqLworCQllbHNlIGlmICgoY29sID09IDcgJiYgcm93ID09
IDUpICYmIHN0YXRlKSB7CisJCQlrZXlwYWQtPmZuID0gMDsKKwkJCXNldF9iaXQoS0VZX0RPVCwg
ZGV2LT5rZXkpOworCQkJZGV2LT5yZXBlYXRfa2V5ID0gS0VZX0RPVDsKKwkJfQorCisJCXJldHVy
bjsKKwlkZWZhdWx0OgorCQk7CisJfQorfQorCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9zY2Fu
X21hdHJpeChzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwlpbnQgcm93LCBjb2wsIG51
bV9rZXlzX3ByZXNzZWQgPSAwOworCXVpbnQzMl90IG5ld19zdGF0ZVtNQVhfTUFUUklYX0tFWV9D
T0xTXTsKKwl1aW50MzJfdCBrcGFzID0ga2V5cGFkX3JlYWRsKEtQQVMpOworCisJbnVtX2tleXNf
cHJlc3NlZCA9IEtQQVNfTVVLUChrcGFzKTsKKworCW1lbXNldChuZXdfc3RhdGUsIDAsIHNpemVv
ZihuZXdfc3RhdGUpKTsKKworCWlmIChudW1fa2V5c19wcmVzc2VkID09IDApIHsKKwkJaGFuZGxl
X2NvbnN0YW50X2tleXByZXNzKGtleXBhZCwgbnVtX2tleXNfcHJlc3NlZCwgMCwgMCwKKwkJCQkJ
IGtleXBhZC0+bWF0cml4X2tleV9zdGF0ZSk7CisKKwkJZ290byBzY2FuOworCX0KKworCWlmIChu
dW1fa2V5c19wcmVzc2VkID09IDEpIHsKKwkJY29sID0gS1BBU19DUChrcGFzKTsKKwkJcm93ID0g
S1BBU19SUChrcGFzKTsKKworCQkvKiBpZiBpbnZhbGlkIHJvdy9jb2wsIHRyZWF0IGFzIG5vIGtl
eSBwcmVzc2VkICovCisJCWlmIChjb2wgPj0ga2V5cGFkLT5tYXRyaXhfa2V5X2NvbHMgfHwKKwkJ
ICAgIHJvdyA+PSBrZXlwYWQtPm1hdHJpeF9rZXlfcm93cykKKwkJCWdvdG8gc2NhbjsKKworCQkv
KiBpZiBOdW1MayBwcmVzc2VkICovCisJCWlmIChjb2wgPT0gMCAmJiByb3cgPT0gMSkKKwkJCWtl
eXBhZC0+bnVtbGNrID0gIWtleXBhZC0+bnVtbGNrOworCisJCWhhbmRsZV9jb25zdGFudF9rZXlw
cmVzcyhrZXlwYWQsIG51bV9rZXlzX3ByZXNzZWQsIGNvbCwgcm93LAorCQkJCQkga2V5cGFkLT5t
YXRyaXhfa2V5X3N0YXRlKTsKKworCQluZXdfc3RhdGVbY29sXSA9ICgxIDw8IHJvdyk7CisKKwkJ
Z290byBzY2FuOworCX0KKworCWlmIChudW1fa2V5c19wcmVzc2VkID4gMSkgeworCQl1aW50MzJf
dCBrcGFzbWtwMCA9IGtleXBhZF9yZWFkbChLUEFTTUtQMCk7CisJCXVpbnQzMl90IGtwYXNta3Ax
ID0ga2V5cGFkX3JlYWRsKEtQQVNNS1AxKTsKKwkJdWludDMyX3Qga3Bhc21rcDIgPSBrZXlwYWRf
cmVhZGwoS1BBU01LUDIpOworCQl1aW50MzJfdCBrcGFzbWtwMyA9IGtleXBhZF9yZWFkbChLUEFT
TUtQMyk7CisKKwkJbmV3X3N0YXRlWzBdID0ga3Bhc21rcDAgJiBLUEFTTUtQX01LQ19NQVNLOwor
CQluZXdfc3RhdGVbMV0gPSAoa3Bhc21rcDAgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJ
bmV3X3N0YXRlWzJdID0ga3Bhc21rcDEgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVb
M10gPSAoa3Bhc21rcDEgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJbmV3X3N0YXRlWzRd
ID0ga3Bhc21rcDIgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbNV0gPSAoa3Bhc21r
cDIgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJbmV3X3N0YXRlWzZdID0ga3Bhc21rcDMg
JiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbN10gPSAoa3Bhc21rcDMgPj4gMTYpICYg
S1BBU01LUF9NS0NfTUFTSzsKKworCQkvKiBpZiBGbiBpcyBwcmVzc2VkLCBhbGwgU0hJRlQgaXMg
aWdub3JlZCwgZXhjZXB0IHdoZW4geworCQkgKiBvciB9IGlzIHByZXNzZWQgKi8KKwkJaWYgKG5l
d19zdGF0ZVs2XSAmIDB4NDApIHsKKwkJCWtleXBhZC0+Zm4gPSAxOworCQkJbmV3X3N0YXRlWzNd
ICY9IH4weDQwOworCQkJbmV3X3N0YXRlWzFdICY9IH4weDgwOworCQl9CisKKwkJaWYgKGtleXBh
ZC0+Zm4gPT0gMSkgeworCQkJLyogaWYgeyBvciB9IHByZXNzZWQgKi8KKwkJCWlmICgobmV3X3N0
YXRlWzRdICYgMHgyMCkgfHwgKG5ld19zdGF0ZVs3XSAmIDB4MjApKSB7CisJCQkJLyogYXMgaWYg
TEVGVFNISUZUIGlzIHByZXNzZWQgKi8KKwkJCQluZXdfc3RhdGVbM10gfD0gMHg0MDsKKwkJCQkv
KiBhcyBpZiBGbiBub3QgcHJlc3NlZCAqLworCQkJCW5ld19zdGF0ZVs2XSAmPSB+MHg0MDsKKwkJ
CX0KKwkJCS8qIGlmIFsgb3IgXSBwcmVzc2VkICovCisJCQlpZiAoKG5ld19zdGF0ZVswXSAmIDB4
MDQpIHx8IChuZXdfc3RhdGVbM10gJiAweDIwKSkKKwkJCQkvKiBhcyBpZiBGbiBub3QgcHJlc3Nl
ZCAqLworCQkJCW5ld19zdGF0ZVs2XSAmPSB+MHg0MDsKKwkJfQorCX0KKworCitzY2FuOgorCS8q
IHJlLWJ1aWxkIGtleWNvZGUgKi8KKwltcnN0X2tleXBhZF9idWlsZF9rZXljb2RlKGtleXBhZCk7
CisKKwlmb3IgKGNvbCA9IDA7IGNvbCA8IGtleXBhZC0+bWF0cml4X2tleV9jb2xzOyBjb2wrKykg
eworCQl1aW50MzJfdCBiaXRzX2NoYW5nZWQ7CisKKwkJYml0c19jaGFuZ2VkID0ga2V5cGFkLT5t
YXRyaXhfa2V5X3N0YXRlW2NvbF0gXiBuZXdfc3RhdGVbY29sXTsKKwkJaWYgKGJpdHNfY2hhbmdl
ZCA9PSAwKQorCQkJY29udGludWU7CisKKwkJZm9yIChyb3cgPSAwOyByb3cgPCBrZXlwYWQtPm1h
dHJpeF9rZXlfcm93czsgcm93KyspIHsKKwkJCWlmICgoYml0c19jaGFuZ2VkICYgKDEgPDwgcm93
KSkgPT0gMCkKKwkJCQljb250aW51ZTsKKworCQkJaW5wdXRfcmVwb3J0X2tleShrZXlwYWQtPmlu
cHV0X2RldiwKKwkJCQlsb29rdXBfbWF0cml4X2tleWNvZGUoa2V5cGFkLCByb3csIGNvbCksCisJ
CQkJbmV3X3N0YXRlW2NvbF0gJiAoMSA8PCByb3cpKTsKKwkJfQorCX0KKwlpbnB1dF9zeW5jKGtl
eXBhZC0+aW5wdXRfZGV2KTsKKwltZW1jcHkoa2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlLCBuZXdf
c3RhdGUsIHNpemVvZihuZXdfc3RhdGUpKTsKK30KKworI2RlZmluZSBERUZBVUxUX0tQUkVDCSgw
eDAwN2YwMDdmKQorCitzdGF0aWMgaW5saW5lIGludCByb3RhcnlfZGVsdGEodWludDMyX3Qga3By
ZWMpCit7CisJaWYgKGtwcmVjICYgS1BSRUNfT0YwKQorCQlyZXR1cm4gKGtwcmVjICYgMHhmZikg
KyAweDdmOworCWVsc2UgaWYgKGtwcmVjICYgS1BSRUNfVUYwKQorCQlyZXR1cm4gKGtwcmVjICYg
MHhmZikgLSAweDdmIC0gMHhmZjsKKwllbHNlCisJCXJldHVybiAoa3ByZWMgJiAweGZmKSAtIDB4
N2Y7Cit9CisKK3N0YXRpYyB2b2lkIHJlcG9ydF9yb3RhcnlfZXZlbnQoc3RydWN0IG1yc3Rfa2V5
cGFkICprZXlwYWQsIGludCByLCBpbnQgZGVsdGEpCit7CisJc3RydWN0IGlucHV0X2RldiAqZGV2
ID0ga2V5cGFkLT5pbnB1dF9kZXY7CisKKwlpZiAoZGVsdGEgPT0gMCkKKwkJcmV0dXJuOworCisJ
aWYgKGtleXBhZC0+cm90YXJ5X3VwX2tleVtyXSAmJiBrZXlwYWQtPnJvdGFyeV9kb3duX2tleVty
XSkgeworCQlpbnQga2V5Y29kZSA9IChkZWx0YSA+IDApID8ga2V5cGFkLT5yb3RhcnlfdXBfa2V5
W3JdIDoKKwkJCQkJICAgIGtleXBhZC0+cm90YXJ5X2Rvd25fa2V5W3JdOworCisJCS8qIHNpbXVs
YXRlIGEgcHJlc3Mtbi1yZWxlYXNlICovCisJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBrZXljb2Rl
LCAxKTsKKwkJaW5wdXRfc3luYyhkZXYpOworCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwga2V5Y29k
ZSwgMCk7CisJCWlucHV0X3N5bmMoZGV2KTsKKwl9IGVsc2UgeworCQlpbnB1dF9yZXBvcnRfcmVs
KGRldiwga2V5cGFkLT5yb3RhcnlfcmVsX2NvZGVbcl0sIGRlbHRhKTsKKwkJaW5wdXRfc3luYyhk
ZXYpOworCX0KK30KKworc3RhdGljIHZvaWQgbXJzdF9rZXlwYWRfc2Nhbl9yb3Rhcnkoc3RydWN0
IG1yc3Rfa2V5cGFkICprZXlwYWQpCit7CisJdW5zaWduZWQgaW50IGtwcmVjOworCisJLyogcmVh
ZCBhbmQgcmVzZXQgdG8gZGVmYXVsdCBjb3VudCB2YWx1ZSAqLworCWtwcmVjID0ga2V5cGFkX3Jl
YWRsKEtQUkVDKTsKKwlrZXlwYWRfd3JpdGVsKEtQUkVDLCBERUZBVUxUX0tQUkVDKTsKKworCWlm
IChrZXlwYWQtPmVuYWJsZV9yb3RhcnkwKQorCQlyZXBvcnRfcm90YXJ5X2V2ZW50KGtleXBhZCwg
MCwgcm90YXJ5X2RlbHRhKGtwcmVjKSk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5MSkK
KwkJcmVwb3J0X3JvdGFyeV9ldmVudChrZXlwYWQsIDEsIHJvdGFyeV9kZWx0YShrcHJlYyA+PiAx
NikpOworfQorCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9zY2FuX2RpcmVjdChzdHJ1Y3QgbXJz
dF9rZXlwYWQgKmtleXBhZCkKK3sKKwl1bnNpZ25lZCBpbnQgbmV3X3N0YXRlOworCXVpbnQzMl90
IGtwZGssIGJpdHNfY2hhbmdlZDsKKwlpbnQgaTsKKworCWtwZGsgPSBrZXlwYWRfcmVhZGwoS1BE
Syk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5MCB8fCBrZXlwYWQtPmVuYWJsZV9yb3Rh
cnkxKQorCQltcnN0X2tleXBhZF9zY2FuX3JvdGFyeShrZXlwYWQpOworCisJaWYgKGtleXBhZC0+
ZGlyZWN0X2tleV9tYXAgPT0gTlVMTCkgeworCQlrZXlwYWQtPmRpcmVjdF9rZXlfc3RhdGUgPSAw
OworCQlyZXR1cm47CisJfQorCisJbmV3X3N0YXRlID0gS1BES19ESyhrcGRrKSAmIGtleXBhZC0+
ZGlyZWN0X2tleV9tYXNrOworCW5ld19zdGF0ZSA9IH5uZXdfc3RhdGU7CisJYml0c19jaGFuZ2Vk
ID0ga2V5cGFkLT5kaXJlY3Rfa2V5X3N0YXRlIF4gbmV3X3N0YXRlOworCisJaWYgKGJpdHNfY2hh
bmdlZCA9PSAwKQorCQlyZXR1cm47CisKKwlmb3IgKGkgPSAwOyBpIDwga2V5cGFkLT5kaXJlY3Rf
a2V5X251bTsgaSsrKSB7CisJCWlmIChiaXRzX2NoYW5nZWQgJiAoMSA8PCBpKSkgeworCQkJaW5w
dXRfcmVwb3J0X2tleShrZXlwYWQtPmlucHV0X2RldiwKKwkJCQkJIGtleXBhZC0+ZGlyZWN0X2tl
eV9tYXBbaV0sCisJCQkJCSAobmV3X3N0YXRlICYgKDEgPDwgaSkpKTsKKwkJfQorCX0KKwlpbnB1
dF9zeW5jKGtleXBhZC0+aW5wdXRfZGV2KTsKKwlrZXlwYWQtPmRpcmVjdF9rZXlfc3RhdGUgPSBu
ZXdfc3RhdGU7CisKK30KKworc3RhdGljIGlycXJldHVybl90IG1yc3Rfa2V5cGFkX2lycV9oYW5k
bGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkKK3sKKwlzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBh
ZCA9IGRldl9pZDsKKwl1bnNpZ25lZCBsb25nIGtwYyA9IGtleXBhZF9yZWFkbChLUEMpOworCisJ
aWYgKGtwYyAmIEtQQ19ESSkKKwkJbXJzdF9rZXlwYWRfc2Nhbl9kaXJlY3Qoa2V5cGFkKTsKKwor
CWlmIChrcGMgJiBLUENfTUkpCisJCW1yc3Rfa2V5cGFkX3NjYW5fbWF0cml4KGtleXBhZCk7CisK
KwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKKyNpZiAwCisjZGVmaW5lCUtFWVBBRF9NQVRSSVhf
R1BJT19JTl9QSU4JMjQKKyNkZWZpbmUJS0VZUEFEX01BVFJJWF9HUElPX09VVF9QSU4JMzIKKyNk
ZWZpbmUgS0VZUEFEX0RJUkVDVF9HUElPX0lOX1BJTgk0MAorc3RhdGljIHZvaWQgbXJzdF9rZXlw
YWRfZ3Bpb19pbml0KHZvaWQpCit7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgTUFYX01B
VFJJWF9LRVlfUk9XUzsgaSsrKSB7CisJCWdwaW9fZGlyZWN0aW9uX2lucHV0KEtFWVBBRF9NQVRS
SVhfR1BJT19JTl9QSU4gKyBpKTsKKwkJZ3Bpb19hbHRfZnVuYyhLRVlQQURfTUFUUklYX0dQSU9f
SU5fUElOICsgaSwgMSk7CisJfQorCisJZm9yIChpID0gMDsgaSA8IE1BWF9NQVRSSVhfS0VZX0NP
TFM7IGkrKykgeworCQkvKiBfX2dwaW9fc2V0X3ZhbHVlKEtFWVBBRF9HUElPX09VVF9QSU4gKyBp
LCAxKTsgKi8KKwkJLyogc2V0IGFjdGlvbiBpcyBleGVjdXRlZCBpbiBncGlvX2RpcmVjdGlvbl9v
dXRwdXQoKSAqLworCQlncGlvX2RpcmVjdGlvbl9vdXRwdXQoS0VZUEFEX01BVFJJWF9HUElPX09V
VF9QSU4gKyBpLCAxKTsKKwkJZ3Bpb19hbHRfZnVuYyhLRVlQQURfTUFUUklYX0dQSU9fT1VUX1BJ
TiArIGksIDEpOworCX0KKworCWZvciAoaSA9IDA7IGkgPCBNQVhfRElSRUNUX0tFWV9OVU07IGkr
KykgeworCQlncGlvX2RpcmVjdGlvbl9pbnB1dChLRVlQQURfRElSRUNUX0dQSU9fSU5fUElOICsg
aSk7CisJCWdwaW9fYWx0X2Z1bmMoS0VZUEFEX0RJUkVDVF9HUElPX0lOX1BJTiArIGksIDEpOwor
CX0KK30KKyNlbmRpZgorCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9jb25maWcoc3RydWN0IG1y
c3Rfa2V5cGFkICprZXlwYWQpCit7CisJdW5zaWduZWQgaW50IG1hc2sgPSAwLCBkaXJlY3Rfa2V5
X251bSA9IDA7CisJdW5zaWduZWQgbG9uZyBrcGMgPSAwOworCisJLyogZW5hYmxlIG1hdHJpeCBr
ZXlzIHdpdGggYXV0b21hdGljIHNjYW4gKi8KKwlpZiAoa2V5cGFkLT5tYXRyaXhfa2V5X3Jvd3Mg
JiYga2V5cGFkLT5tYXRyaXhfa2V5X2NvbHMpIHsKKwkJa3BjIHw9IEtQQ19BU0FDVCB8IEtQQ19N
SUUgfCBLUENfTUUgfCBLUENfTVNfQUxMOworCQlrcGMgfD0gS1BDX01LUk4oa2V5cGFkLT5tYXRy
aXhfa2V5X3Jvd3MpIHwKKwkJICAgICAgIEtQQ19NS0NOKGtleXBhZC0+bWF0cml4X2tleV9jb2xz
KTsKKwl9CisKKwkvKiBlbmFibGUgcm90YXJ5IGtleSwgZGVib3VuY2UgaW50ZXJ2YWwgc2FtZSBh
cyBkaXJlY3Qga2V5cyAqLworCWlmIChrZXlwYWQtPmVuYWJsZV9yb3RhcnkwKSB7CisJCW1hc2sg
fD0gMHgwMzsKKwkJZGlyZWN0X2tleV9udW0gPSAyOworCQlrcGMgfD0gS1BDX1JFRTA7CisJfQor
CisJaWYgKGtleXBhZC0+ZW5hYmxlX3JvdGFyeTEpIHsKKwkJbWFzayB8PSAweDBjOworCQlkaXJl
Y3Rfa2V5X251bSA9IDQ7CisJCWtwYyB8PSBLUENfUkVFMTsKKwl9CisKKwlpZiAoa2V5cGFkLT5k
aXJlY3Rfa2V5X251bSA+IGRpcmVjdF9rZXlfbnVtKQorCQlkaXJlY3Rfa2V5X251bSA9IGtleXBh
ZC0+ZGlyZWN0X2tleV9udW07CisKKwlrZXlwYWQtPmRpcmVjdF9rZXlfbWFzayA9ICgoMiA8PCBk
aXJlY3Rfa2V5X251bSkgLSAxKSAmIH5tYXNrOworCisJLyogZW5hYmxlIGRpcmVjdCBrZXkgKi8K
KwlpZiAoZGlyZWN0X2tleV9udW0pCisJCWtwYyB8PSBLUENfREUgfCBLUENfRElFIHwgS1BDX0RL
TihkaXJlY3Rfa2V5X251bSk7CisKKwlrZXlwYWRfd3JpdGVsKEtQQywga3BjKTsKKwlrZXlwYWRf
d3JpdGVsKEtQUkVDLCBERUZBVUxUX0tQUkVDKTsKKwlrZXlwYWRfd3JpdGVsKEtQS0RJLCBrZXlw
YWQtPmRlYm91bmNlX2ludGVydmFsKTsKK30KKworc3RhdGljIGludCBtcnN0X2tleXBhZF9vcGVu
KHN0cnVjdCBpbnB1dF9kZXYgKmRldikKK3sKKwlzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCA9
IGlucHV0X2dldF9kcnZkYXRhKGRldik7CisKKwkvKiBkZXBlbmQgb24gTW9vcmVzdG93biBHUElP
IGRyaXZlci4uLiovCisJLyogbXJzdF9rZXlwYWRfZ3Bpb19pbml0KCk7ICovCisJbXJzdF9rZXlw
YWRfY29uZmlnKGtleXBhZCk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgbXJzdF9r
ZXlwYWRfY2xvc2Uoc3RydWN0IGlucHV0X2RldiAqZGV2KQoreworCXN0cnVjdCBtcnN0X2tleXBh
ZCAqa2V5cGFkIDsKKwlrZXlwYWQgPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOworfQorCisjaWZk
ZWYgQ09ORklHX1BNCitzdGF0aWMgaW50IG1yc3Rfa2V5cGFkX3N1c3BlbmQoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKK3sKKwkvKiBzdHJ1Y3QgbXJzdF9rZXlwYWQg
KmtleXBhZCA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsgKi8KKworCS8qIGNsa19kaXNhYmxlKGtl
eXBhZC0+Y2xrKTsgKi8KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBtcnN0X2tleXBhZF9y
ZXN1bWUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCit7CisJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlw
YWQgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXRfZGV2
ID0ga2V5cGFkLT5pbnB1dF9kZXY7CisKKwltdXRleF9sb2NrKCZpbnB1dF9kZXYtPm11dGV4KTsK
KworCWlmIChpbnB1dF9kZXYtPnVzZXJzKSB7CisJCS8qIEVuYWJsZSB1bml0IGNsb2NrICovCisJ
CS8qIGNsa19lbmFibGUoa2V5cGFkLT5jbGspOyAqLworCQltcnN0X2tleXBhZF9jb25maWcoa2V5
cGFkKTsKKwl9CisKKwltdXRleF91bmxvY2soJmlucHV0X2Rldi0+bXV0ZXgpOworCisJcmV0dXJu
IDA7Cit9CisjZWxzZQorI2RlZmluZSBtcnN0X2tleXBhZF9zdXNwZW5kCU5VTEwKKyNkZWZpbmUg
bXJzdF9rZXlwYWRfcmVzdW1lCU5VTEwKKyNlbmRpZgorCisKK3N0YXRpYyBpbnQgX19kZXZpbml0
IG1yc3Rfa2V5cGFkX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAorCQkJY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgKmVudCkKK3sKKwlzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZDsKKwlz
dHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXY7CisJaW50IGVycm9yOworCisjaWZuZGVmIE1PRFVM
RQorCXByaW50ayhLRVJOX0lORk8gTVJTVF9LRVlQQURfRFJJVkVSX05BTUUgIlxuIik7CisjZW5k
aWYKKworCWtleXBhZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBtcnN0X2tleXBhZCksIEdGUF9L
RVJORUwpOworCWlmIChrZXlwYWQgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gYWxsb2NhdGUgZHJpdmVyIGRhdGFcbiIpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9
CisKKwllcnJvciA9IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOworCWlmIChlcnJvciB8fCAocGRl
di0+aXJxIDwgMCkpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBk
ZXZpY2UvZ2V0IGlycVxuIik7CisJCWVycm9yID0gLUVOWElPOworCQlnb3RvIGZhaWxlZF9mcmVl
OworCX0KKworCWVycm9yID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7CisJ
aWYgKGVycm9yKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZXF1ZXN0IEkv
TyBtZW1vcnlcbiIpOworCQlnb3RvIGZhaWxlZF9mcmVlOworCX0KKworCWtleXBhZC0+bW1pb19i
YXNlID0gaW9yZW1hcChwY2lfcmVzb3VyY2Vfc3RhcnQocGRldiwgMCksIFwKKwkJcGNpX3Jlc291
cmNlX2xlbihwZGV2LCAwKSk7CisJaWYgKGtleXBhZC0+bW1pb19iYXNlID09IE5VTEwpIHsKKwkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlbWFwIEkvTyBtZW1vcnlcbiIpOworCQll
cnJvciA9IC1FTlhJTzsKKwkJZ290byBmYWlsZWRfZnJlZV9tZW07CisJfQorCisJLyogQ3JlYXRl
IGFuZCByZWdpc3RlciB0aGUgaW5wdXQgZHJpdmVyLiAqLworCWlucHV0X2RldiA9IGlucHV0X2Fs
bG9jYXRlX2RldmljZSgpOworCWlmICghaW5wdXRfZGV2KSB7CisJCWRldl9lcnIoJnBkZXYtPmRl
diwgImZhaWxlZCB0byBhbGxvY2F0ZSBpbnB1dCBkZXZpY2VcbiIpOworCQllcnJvciA9IC1FTk9N
RU07CisJCWdvdG8gZmFpbGVkX2ZyZWVfaW87CisJfQorCisJaW5wdXRfZGV2LT5uYW1lID0gcGNp
X25hbWUocGRldik7CisJaW5wdXRfZGV2LT5pZC5idXN0eXBlID0gQlVTX1BDSTsKKwlpbnB1dF9k
ZXYtPm9wZW4gPSBtcnN0X2tleXBhZF9vcGVuOworCWlucHV0X2Rldi0+Y2xvc2UgPSBtcnN0X2tl
eXBhZF9jbG9zZTsKKwlpbnB1dF9kZXYtPmRldi5wYXJlbnQgPSAmcGRldi0+ZGV2OworCisJaW5w
dXRfZGV2LT5rZXljb2RlID0ga2V5cGFkLT5tYXRyaXhfa2V5Y29kZXM7CisJaW5wdXRfZGV2LT5r
ZXljb2Rlc2l6ZSA9IHNpemVvZih1bnNpZ25lZCBpbnQpOworCWlucHV0X2Rldi0+a2V5Y29kZW1h
eCA9IEFSUkFZX1NJWkUobXJzdF9rZXljb2RlKTsKKworCWtleXBhZC0+aW5wdXRfZGV2ID0gaW5w
dXRfZGV2OworCWtleXBhZC0+Zm4gPSAwOworCWtleXBhZC0+bnVtbGNrID0gMDsKKwlpbnB1dF9z
ZXRfZHJ2ZGF0YShpbnB1dF9kZXYsIGtleXBhZCk7CisKKwlpbnB1dF9kZXYtPmV2Yml0WzBdID0g
QklUX01BU0soRVZfS0VZKSB8IEJJVF9NQVNLKEVWX1JFUCkgfAorCQlCSVRfTUFTSyhFVl9SRUwp
OworCisJbXJzdF9rZXlwYWRfYnVpbGRfa2V5Y29kZShrZXlwYWQpOworCXBjaV9zZXRfZHJ2ZGF0
YShwZGV2LCBrZXlwYWQpOworCisJZXJyb3IgPSByZXF1ZXN0X2lycShwZGV2LT5pcnEsIG1yc3Rf
a2V5cGFkX2lycV9oYW5kbGVyLCBJUlFGX1NIQVJFRCwKKwkJcGNpX25hbWUocGRldiksIGtleXBh
ZCk7CisJaWYgKGVycm9yKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZXF1
ZXN0IElSUVxuIik7CisJCWdvdG8gZmFpbGVkX2ZyZWVfZGV2OworCX0KKworCS8qIFJlZ2lzdGVy
IHRoZSBpbnB1dCBkZXZpY2UgKi8KKwllcnJvciA9IGlucHV0X3JlZ2lzdGVyX2RldmljZShpbnB1
dF9kZXYpOworCWlmIChlcnJvcikgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8g
cmVnaXN0ZXIgaW5wdXQgZGV2aWNlXG4iKTsKKwkJZ290byBmYWlsZWRfZnJlZV9pcnE7CisJfQor
CisJcHJpbnRrKEtFUk5fSU5GTyAiKioqIGtleXBhZCBkcml2ZXIgbG9hZCBzdWNjZXNzZnVsbHkg
KioqXG4iKTsKKwlyZXR1cm4gMDsKKworZmFpbGVkX2ZyZWVfaXJxOgorCWZyZWVfaXJxKHBkZXYt
PmlycSwga2V5cGFkKTsKKwlwY2lfc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CitmYWlsZWRfZnJl
ZV9kZXY6CisJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsKK2ZhaWxlZF9mcmVlX2lvOgor
CWlvdW5tYXAoa2V5cGFkLT5tbWlvX2Jhc2UpOworZmFpbGVkX2ZyZWVfbWVtOgorCXBjaV9yZWxl
YXNlX3JlZ2lvbnMocGRldik7CitmYWlsZWRfZnJlZToKKwlrZnJlZShrZXlwYWQpOworCXJldHVy
biBlcnJvcjsKK30KKworc3RhdGljIHZvaWQgX19kZXZleGl0IG1yc3Rfa2V5cGFkX3JlbW92ZShz
dHJ1Y3QgcGNpX2RldiAqcGRldikKK3sKKwlzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCA9IHBj
aV9nZXRfZHJ2ZGF0YShwZGV2KTsKKworCWZyZWVfaXJxKHBkZXYtPmlycSwga2V5cGFkKTsKKwlp
bnB1dF91bnJlZ2lzdGVyX2RldmljZShrZXlwYWQtPmlucHV0X2Rldik7CisJaW91bm1hcChrZXlw
YWQtPm1taW9fYmFzZSk7CisJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsKKwlwY2lfc2V0X2Ry
dmRhdGEocGRldiwgTlVMTCk7CisJa2ZyZWUoa2V5cGFkKTsKK30KKworCitzdGF0aWMgc3RydWN0
IHBjaV9kcml2ZXIgbXJzdF9rZXlwYWRfZHJpdmVyID0geworCS5uYW1lCQk9IERSVl9OQU1FLAor
CS5pZF90YWJsZQk9IGtleXBhZF9wY2lfdGJsLAorCS5wcm9iZQkJPSBtcnN0X2tleXBhZF9wcm9i
ZSwKKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKG1yc3Rfa2V5cGFkX3JlbW92ZSksCisjaWZkZWYg
Q09ORklHX1BNCisJLnN1c3BlbmQJPSBtcnN0X2tleXBhZF9zdXNwZW5kLAorCS5yZXN1bWUJCT0g
bXJzdF9rZXlwYWRfcmVzdW1lLAorI2VuZGlmIC8qIENPTkZJR19QTSAqLworfTsKKworc3RhdGlj
IGludCBfX2luaXQgbXJzdF9rZXlwYWRfaW5pdCh2b2lkKQoreworI2lmZGVmIE1PRFVMRQorCXBy
aW50ayhLRVJOX0lORk8gTVJTVF9LRVlQQURfRFJJVkVSX05BTUUgIlxuIik7CisjZW5kaWYKKwor
CXJldHVybiBwY2lfcmVnaXN0ZXJfZHJpdmVyKCZtcnN0X2tleXBhZF9kcml2ZXIpOworfQorCitz
dGF0aWMgdm9pZCBfX2V4aXQgbXJzdF9rZXlwYWRfZXhpdCh2b2lkKQoreworCXBjaV91bnJlZ2lz
dGVyX2RyaXZlcigmbXJzdF9rZXlwYWRfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQobXJzdF9r
ZXlwYWRfaW5pdCk7Cittb2R1bGVfZXhpdChtcnN0X2tleXBhZF9leGl0KTsKKworTU9EVUxFX0RF
U0NSSVBUSU9OKCJNUlNUIEtleXBhZCBDb250cm9sbGVyIERyaXZlciIpOworTU9EVUxFX0xJQ0VO
U0UoIkdQTCB2MiIpOwotLSAKMS41LjIuNQoK

--_002_61563CE63B4F854986A895DA7AD3C1771573C36Dpdsmsx502ccrcor_--
