From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: [PATCH 1/1] input: keypad controller driver for Intel low power
 Moorestown platform
Date: Mon, 27 Apr 2009 15:13:54 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C1771595B036@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_61563CE63B4F854986A895DA7AD3C1771595B036pdsmsx502ccrcor_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32897 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZD0HPF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2009 03:15:05 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--_002_61563CE63B4F854986A895DA7AD3C1771595B036pdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



>From 26189161bfd1b436fbdab17188a98003123354a2 Mon Sep 17 00:00:00 2001
From: Zheng Ba <zheng.ba@intel.com>
Date: Mon, 27 Apr 2009 13:35:09 +0800
Subject: [PATCH] Keypad controller driver for Intel low power Moorestown pl=
atform

This driver has dual-support for two styles of keypads: Direct key and Matr=
ix key.
Matrix keypad works like an ordinary keyboard except for some function keys=
 (Fn);
Also, four direct keys are supported: camera shutters (half/full press) and=
 volume up/down buttons.

added: drivers/input/moorestown-kpd.c
modified: drivers/input/Makefile
          drivers/input/Kconfig

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
---
 drivers/input/keyboard/Kconfig          |    7 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/moorestown_kpd.c |  786 +++++++++++++++++++++++++++=
++++
 3 files changed, 794 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/moorestown_kpd.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
index ea2638b..df3749f 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -332,4 +332,11 @@ config KEYBOARD_SH_KEYSC

          To compile this driver as a module, choose M here: the
          module will be called sh_keysc.
+
+config KEYBOARD_MRST
+       tristate "Moorestown keypad support"
+       help
+         Say Y if you want to use the moorestown keypad
+         depends on GPIO_MOORESTOWN
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index 36351e1..e0de269 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX)          +=3D jornada720_kbd=
.o
 obj-$(CONFIG_KEYBOARD_MAPLE)           +=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_BFIN)            +=3D bf54x-keys.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)                +=3D sh_keysc.o
+obj-$(CONFIG_KEYBOARD_MRST)            +=3D moorestown_kpd.o
diff --git a/drivers/input/keyboard/moorestown_kpd.c b/drivers/input/keyboa=
rd/moorestown_kpd.c
new file mode 100644
index 0000000..26e6cb9
--- /dev/null
+++ b/drivers/input/keyboard/moorestown_kpd.c
@@ -0,0 +1,786 @@
+/*
+ * linux/drivers/input/keyboard/mrst_keypad.c
+ *
+ * Driver for the matrix keypad controller on Moorestown platform.
+ *
+ * Copyright (c) 2009 Intel Corporation.
+ * Created:    Sep 18, 2008
+ * Updated:    Apr 24, 2009
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
+
+       /*FIXME IRQ count*/
+       int count;
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
+       keypad->direct_key_num =3D MAX_DIRECT_KEY_NUM;
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
+       if ((keypad->direct_key_map =3D=3D NULL) || (++keypad->count =3D=3D=
 1)) {
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
+/* temporily remove GPIO dependencies here... */
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
+       /*FIXME*/keypad->count =3D 0;
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




--_002_61563CE63B4F854986A895DA7AD3C1771595B036pdsmsx502ccrcor_
Content-Type: application/octet-stream;
	name="Keypad-Moorestown-20090427.patch"
Content-Description: Keypad-Moorestown-20090427.patch
Content-Disposition: attachment;
	filename="Keypad-Moorestown-20090427.patch"; size=24099;
	creation-date="Mon, 27 Apr 2009 13:45:16 GMT";
	modification-date="Mon, 27 Apr 2009 15:12:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNjE4OTE2MWJmZDFiNDM2ZmJkYWIxNzE4OGE5ODAwMzEyMzM1NGEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuZyBCYSA8emhlbmcuYmFAaW50ZWwuY29tPgpEYXRlOiBN
b24sIDI3IEFwciAyMDA5IDEzOjM1OjA5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gS2V5cGFkIGNv
bnRyb2xsZXIgZHJpdmVyIGZvciBJbnRlbCBsb3cgcG93ZXIgTW9vcmVzdG93biBwbGF0Zm9ybQoK
VGhpcyBkcml2ZXIgaGFzIGR1YWwtc3VwcG9ydCBmb3IgdHdvIHN0eWxlcyBvZiBrZXlwYWRzOiBE
aXJlY3Qga2V5IGFuZCBNYXRyaXgga2V5LgpNYXRyaXgga2V5cGFkIHdvcmtzIGxpa2UgYW4gb3Jk
aW5hcnkga2V5Ym9hcmQgZXhjZXB0IGZvciBzb21lIGZ1bmN0aW9uIGtleXMgKEZuKTsKQWxzbywg
Zm91ciBkaXJlY3Qga2V5cyBhcmUgc3VwcG9ydGVkOiBjYW1lcmEgc2h1dHRlcnMgKGhhbGYvZnVs
bCBwcmVzcykgYW5kIHZvbHVtZSB1cC9kb3duIGJ1dHRvbnMuCgphZGRlZDogZHJpdmVycy9pbnB1
dC9tb29yZXN0b3duLWtwZC5jCm1vZGlmaWVkOiBkcml2ZXJzL2lucHV0L01ha2VmaWxlCgkgIGRy
aXZlcnMvaW5wdXQvS2NvbmZpZwoKU2lnbmVkLW9mZi1ieTogWmhlbmcgQmEgPHpoZW5nLmJhQGlu
dGVsLmNvbT4KLS0tCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcgICAgICAgICAgfCAg
ICA3ICsKIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUgICAgICAgICB8ICAgIDEgKwog
ZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tb29yZXN0b3duX2twZC5jIHwgIDc4NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc5NCBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQva2V5Ym9h
cmQvbW9vcmVzdG93bl9rcGQuYwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
S2NvbmZpZyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZwppbmRleCBlYTI2MzhiLi5k
ZjM3NDlmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKKysrIGIv
ZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnCkBAIC0zMzIsNCArMzMyLDExIEBAIGNvbmZp
ZyBLRVlCT0FSRF9TSF9LRVlTQwogCiAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9k
dWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUKIAkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBzaF9rZXlz
Yy4KKworY29uZmlnIEtFWUJPQVJEX01SU1QKKwl0cmlzdGF0ZSAiTW9vcmVzdG93biBrZXlwYWQg
c3VwcG9ydCIKKwloZWxwCisJICBTYXkgWSBpZiB5b3Ugd2FudCB0byB1c2UgdGhlIG1vb3Jlc3Rv
d24ga2V5cGFkCisJICBkZXBlbmRzIG9uIEdQSU9fTU9PUkVTVE9XTgorCiBlbmRpZgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZSBiL2RyaXZlcnMvaW5wdXQva2V5
Ym9hcmQvTWFrZWZpbGUKaW5kZXggMzYzNTFlMS4uZTBkZTI2OSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQorKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01h
a2VmaWxlCkBAIC0yOCwzICsyOCw0IEBAIG9iai0kKENPTkZJR19LRVlCT0FSRF9IUDdYWCkJCSs9
IGpvcm5hZGE3MjBfa2JkLm8KIG9iai0kKENPTkZJR19LRVlCT0FSRF9NQVBMRSkJCSs9IG1hcGxl
X2tleWIubwogb2JqLSQoQ09ORklHX0tFWUJPQVJEX0JGSU4pCQkrPSBiZjU0eC1rZXlzLm8KIG9i
ai0kKENPTkZJR19LRVlCT0FSRF9TSF9LRVlTQykJCSs9IHNoX2tleXNjLm8KK29iai0kKENPTkZJ
R19LRVlCT0FSRF9NUlNUKQkJKz0gbW9vcmVzdG93bl9rcGQubwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9tb29yZXN0b3duX2twZC5jIGIvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9tb29yZXN0b3duX2twZC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjI2
ZTZjYjkKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL21vb3Jlc3Rv
d25fa3BkLmMKQEAgLTAsMCArMSw3ODYgQEAKKy8qCisgKiBsaW51eC9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL21yc3Rfa2V5cGFkLmMKKyAqCisgKiBEcml2ZXIgZm9yIHRoZSBtYXRyaXgga2V5cGFk
IGNvbnRyb2xsZXIgb24gTW9vcmVzdG93biBwbGF0Zm9ybS4KKyAqCisgKiBDb3B5cmlnaHQgKGMp
IDIwMDkgSW50ZWwgQ29ycG9yYXRpb24uCisgKiBDcmVhdGVkOglTZXAgMTgsIDIwMDgKKyAqIFVw
ZGF0ZWQ6CUFwciAyNCwgMjAwOQorICoKKyAqIEJhc2VkIG9uIHB4YTI3eF9rZXlwYWQuYyBieSBS
b2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBsaW51eC5pdD4KKyAqIHB4YTI3eF9rZXlwYWQuYyBp
cyBiYXNlZCBvbiBhIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGJ5IEtldmluIE8nQ29ubm9yCisg
KiA8a2V2aW5fYXRfa2Vjb25ub3IubmV0PiBhbmQgQWxleCBPc2Jvcm5lIDxib2JvZmRvb21AZ21h
aWwuY29tPiBhbmQKKyAqIG9uIHNvbWUgc3VnZ2VzdGlvbnMgYnkgTmljb2xhcyBQaXRyZSA8bmlj
b0BjYW0ub3JnPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1bmRlciB0aGUgdGVybXMgYW5k
IGNvbmRpdGlvbnMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLAorICogdmVyc2lv
biAyLCBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2lsbCBiZSB1c2Vm
dWwsIGJ1dCBXSVRIT1VUCisgKiBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGll
ZCB3YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgb3IKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAq
IG1vcmUgZGV0YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgKiB0aGlzIHByb2dy
YW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwK
KyAqIDUxIEZyYW5rbGluIFN0IC0gRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBV
U0EuCisgKgorICovCisKKyNkZWZpbmUgRFJWX05BTUUJIm1yc3Rfa2V5cGFkIgorI2RlZmluZSBE
UlZfVkVSU0lPTgkiMC4wLjEiCisjZGVmaW5lIE1SU1RfS0VZUEFEX0RSSVZFUl9OQU1FICAgRFJW
X05BTUUgIiAiIERSVl9WRVJTSU9OCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxs
aW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGlu
dXgvaW5wdXQuaD4KKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9l
cnIuaD4KKyNpbmNsdWRlIDxsaW51eC9ncGlvLmg+CisKKy8qCisgKiBLZXlwYWQgQ29udHJvbGxl
ciByZWdpc3RlcnMKKyAqLworI2RlZmluZSBLUEMgICAgICAgICAgICAgMHgwMDAwIC8qIEtleXBh
ZCBDb250cm9sIHJlZ2lzdGVyICovCisjZGVmaW5lIEtQREsgICAgICAgICAgICAweDAwMDQgLyog
S2V5cGFkIERpcmVjdCBLZXkgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BSRUMgICAgICAgICAgIDB4
MDAwOCAvKiBLZXlwYWQgUm90YXJ5IEVuY29kZXIgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BNSyAg
ICAgICAgICAgIDB4MDAwQyAvKiBLZXlwYWQgTWF0cml4IEtleSByZWdpc3RlciAqLworI2RlZmlu
ZSBLUEFTICAgICAgICAgICAgMHgwMDEwIC8qIEtleXBhZCBBdXRvbWF0aWMgU2NhbiByZWdpc3Rl
ciAqLworCisvKiBLZXlwYWQgQXV0b21hdGljIFNjYW4gTXVsdGlwbGUgS2V5IFByZXNzZXIgcmVn
aXN0ZXIgMC0zICovCisjZGVmaW5lIEtQQVNNS1AwICAgICAgICAweDAwMTQKKyNkZWZpbmUgS1BB
U01LUDEgICAgICAgIDB4MDAxOAorI2RlZmluZSBLUEFTTUtQMiAgICAgICAgMHgwMDFDCisjZGVm
aW5lIEtQQVNNS1AzICAgICAgICAweDAwMjAKKyNkZWZpbmUgS1BLREkgICAgICAgICAgIDB4MDAy
NAorCisvKiBiaXQgZGVmaW5pdGlvbnMgKi8KKyNkZWZpbmUgS1BDX01LUk4obikJKCgoKG4pIC0g
MSkgJiAweDcpIDw8IDI2KSAvKiBtYXRyaXgga2V5IHJvdyBudW1iZXIgKi8KKyNkZWZpbmUgS1BD
X01LQ04obikJKCgoKG4pIC0gMSkgJiAweDcpIDw8IDIzKSAvKiBtYXRyaXgga2V5IGNvbCBudW1i
ZXIgKi8KKyNkZWZpbmUgS1BDX0RLTihuKQkoKCgobikgLSAxKSAmIDB4NykgPDwgNikgIC8qIGRp
cmVjdCBrZXkgbnVtYmVyICovCisKKyNkZWZpbmUgS1BDX0FTICAgICAgICAgICgweDEgPDwgMzAp
ICAvKiBBdXRvbWF0aWMgU2NhbiBiaXQgKi8KKyNkZWZpbmUgS1BDX0FTQUNUICAgICAgICgweDEg
PDwgMjkpICAvKiBBdXRvbWF0aWMgU2NhbiBvbiBBY3Rpdml0eSAqLworI2RlZmluZSBLUENfTUkg
ICAgICAgICAgKDB4MSA8PCAyMikgIC8qIE1hdHJpeCBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5l
IEtQQ19JTUtQICAgICAgICAoMHgxIDw8IDIxKSAgLyogSWdub3JlIE11bHRpcGxlIEtleSBQcmVz
cyAqLworCisjZGVmaW5lIEtQQ19NUyhuKQkoMHgxIDw8ICgxMyArIChuKSkpCS8qIE1hdHJpeCBz
Y2FuIGxpbmUgJ24nICovCisjZGVmaW5lIEtQQ19NU19BTEwgICAgICAoMHhmZiA8PCAxMykKKwor
I2RlZmluZSBLUENfTUUgICAgICAgICAgKDB4MSA8PCAxMikgIC8qIE1hdHJpeCBLZXlwYWQgRW5h
YmxlICovCisjZGVmaW5lIEtQQ19NSUUgICAgICAgICAoMHgxIDw8IDExKSAgLyogTWF0cml4IElu
dGVycnVwdCBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX0RLX0RFQl9TRUwJKDB4MSA8PCAgOSkgIC8q
IERpcmVjdCBLZXlwYWQgRGVib3VuY2UgU2VsZWN0ICovCisjZGVmaW5lIEtQQ19ESSAgICAgICAg
ICAoMHgxIDw8ICA1KSAgLyogRGlyZWN0IGtleSBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5lIEtQ
Q19SRV9aRVJPX0RFQiAoMHgxIDw8ICA0KSAgLyogUm90YXJ5IEVuY29kZXIgWmVybyBEZWJvdW5j
ZSAqLworI2RlZmluZSBLUENfUkVFMSAgICAgICAgKDB4MSA8PCAgMykgIC8qIFJvdGFyeSBFbmNv
ZGVyMSBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX1JFRTAgICAgICAgICgweDEgPDwgIDIpICAvKiBS
b3RhcnkgRW5jb2RlcjAgRW5hYmxlICovCisjZGVmaW5lIEtQQ19ERSAgICAgICAgICAoMHgxIDw8
ICAxKSAgLyogRGlyZWN0IEtleXBhZCBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX0RJRSAgICAgICAg
ICgweDEgPDwgIDApICAvKiBEaXJlY3QgS2V5cGFkIGludGVycnVwdCBFbmFibGUgKi8KKworI2Rl
ZmluZSBLUERLX0RLUCAgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUgS1BES19ESyhuKQkoKG4p
ICYgMHhmZikKKworI2RlZmluZSBLUFJFQ19PRjEgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUg
a1BSRUNfVUYxICAgICAgICgweDEgPDwgMzApCisjZGVmaW5lIEtQUkVDX09GMCAgICAgICAoMHgx
IDw8IDE1KQorI2RlZmluZSBLUFJFQ19VRjAgICAgICAgKDB4MSA8PCAxNCkKKworI2RlZmluZSBL
UFJFQ19SRUNPVU5UMChuKQkoKG4pICYgMHhmZikKKyNkZWZpbmUgS1BSRUNfUkVDT1VOVDEobikJ
KCgobikgPj4gMTYpICYgMHhmZikKKworI2RlZmluZSBLUE1LX01LUCAgICAgICAgKDB4MSA8PCAz
MSkKKyNkZWZpbmUgS1BBU19TTyAgICAgICAgICgweDEgPDwgMzEpCisjZGVmaW5lIEtQQVNNS1B4
X1NPICAgICAoMHgxIDw8IDMxKQorCisjZGVmaW5lIEtQQVNfTVVLUChuKQkoKChuKSA+PiAyNikg
JiAweDFmKQorI2RlZmluZSBLUEFTX1JQKG4pCSgoKG4pID4+IDQpICYgMHhmKQorI2RlZmluZSBL
UEFTX0NQKG4pCSgobikgJiAweGYpCisKKyNkZWZpbmUgS1BBU01LUF9NS0NfTUFTSwkoMHhmZikK
KworCitzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQga2V5cGFkX3BjaV90YmxbXSA9IHsKKwl7
MHg4MDg2LCAweDA4MDUsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDAgfSwKKwl7MCx9
Cit9OworTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGtleXBhZF9wY2lfdGJsKTsKKworI2RlZmlu
ZSBrZXlwYWRfcmVhZGwob2ZmKQlyZWFkbChrZXlwYWQtPm1taW9fYmFzZSArIChvZmYpKQorI2Rl
ZmluZSBrZXlwYWRfd3JpdGVsKG9mZiwgdikJd3JpdGVsKCh2KSwga2V5cGFkLT5tbWlvX2Jhc2Ug
KyAob2ZmKSkKKworI2RlZmluZSBNQVhfTUFUUklYX0tFWV9OVU0JKDggKiA4KQorI2RlZmluZSBN
QVhfRElSRUNUX0tFWV9OVU0JKDQpCisKKyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfUk9XUwkoOCkK
KyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfQ09MUwkoOCkKKyNkZWZpbmUgREVCT1VOQ0VfSU5URVJW
QUwJMTAwCisKKyNkZWZpbmUgS0VZX0hBTEZTSFVUVEVSCQlLRVlfUFJPRzEKKyNkZWZpbmUgS0VZ
X0ZVTExTSFVUVEVSCQlLRVlfQ0FNRVJBCisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXJzdF9rZXlj
b2RlW01BWF9NQVRSSVhfS0VZX05VTV0gPSB7CisJS0VZX0YsIEtFWV9ELCBLRVlfRSwgS0VZX0dS
QVZFLCBLRVlfQywgS0VZX1IsIEtFWV80LCBLRVlfViwKKwlLRVlfTlVNTE9DSywgS0VZX0xFRlRD
VFJMLCBLRVlfWiwgS0VZX1csIEtFWV8yLCBLRVlfWCwgS0VZX1MsIEtFWV8zLAorCUtFWV9FUVVB
TCwgS0VZX04sIEtFWV9ILCBLRVlfVSwgS0VZXzcsIEtFWV9NLCBLRVlfSiwgS0VZXzgsCisJS0VZ
XzYsIEtFWV81LCBLRVlfQVBPU1RST1BIRSwgS0VZX0csIEtFWV9ULCBLRVlfU1BBQ0UsIEtFWV9C
LCBLRVlfWSwKKwlLRVlfTUlOVVMsIEtFWV8wLCBLRVlfTEVGVCwgS0VZX1NFTUlDT0xPTiwgS0VZ
X1AsIEtFWV9ET1dOLCBLRVlfVVAsIFwKKwlLRVlfQkFDS1NQQUNFLAorCUtFWV9MLCBLRVlfSywg
S0VZX0ksIEtFWV9TTEFTSCwgS0VZX0NPTU1BLCBLRVlfTywgS0VZXzksIEtFWV9ET1QsCisJS0VZ
X1EsIEtFWV9UQUIsIEtFWV9FU0MsIEtFWV9MRUZUU0hJRlQsIEtFWV9DQVBTTE9DSywgS0VZXzEs
IEtFWV9GTiwgXAorCUtFWV9BLAorCTAsIEtFWV9SSUdIVFNISUZULCBLRVlfRU5URVIsIDAsIEtF
WV9SSUdIVCwgMCwgMCwgMCwKK307CisKKy8qIE51bUxrIGtleSBtYXBwaW5nICovCitzdGF0aWMg
dW5zaWduZWQgaW50IG1yc3Rfa2V5Y29kZV9udW1sY2tbTUFYX01BVFJJWF9LRVlfTlVNXSA9IHsK
KwlLRVlfRiwgS0VZX0QsIEtFWV9FLCBLRVlfR1JBVkUsIEtFWV9DLCBLRVlfUiwgS0VZXzQsIEtF
WV9WLAorCUtFWV9OVU1MT0NLLCBLRVlfTEVGVENUUkwsIEtFWV9aLCBLRVlfVywgS0VZXzIsIEtF
WV9YLCBLRVlfUywgS0VZXzMsCisJS0VZX0VRVUFMLCBLRVlfTiwgS0VZX0gsIEtFWV9LUDQsIEtF
WV9LUDcsIEtFWV9LUDAsIEtFWV9LUDEsIEtFWV9LUDgsCisJS0VZXzYsIEtFWV81LCBLRVlfQVBP
U1RST1BIRSwgS0VZX0csIEtFWV9ULCBLRVlfU1BBQ0UsIEtFWV9CLCBLRVlfWSwKKwlLRVlfTUlO
VVMsIEtFWV9LUFNMQVNILCBLRVlfTEVGVCwgS0VZX0tQTUlOVVMsIEtFWV9LUEFTVEVSSVNLLCBc
CisJS0VZX0RPV04sIEtFWV9VUCwgS0VZX0JBQ0tTUEFDRSwKKwlLRVlfS1AzLCBLRVlfS1AyLCBL
RVlfS1A1LCBLRVlfU0xBU0gsIEtFWV9LUERPVCwgS0VZX0tQNiwgS0VZX0tQOSwgXAorCUtFWV9L
UFBMVVMsCisJS0VZX1EsIEtFWV9UQUIsIEtFWV9FU0MsIEtFWV9MRUZUU0hJRlQsIEtFWV9DQVBT
TE9DSywgS0VZXzEsIEtFWV9GTiwgXAorCUtFWV9BLAorCTAsIEtFWV9SSUdIVFNISUZULCBLRVlf
RU5URVIsIDAsIEtFWV9SSUdIVCwgMCwgMCwgMCwKK307CisKKy8qIEZuIGtleSBtYXBwaW5nICov
CitzdGF0aWMgdW5zaWduZWQgaW50IG1yc3Rfa2V5Y29kZV9mbltNQVhfTUFUUklYX0tFWV9OVU1d
ID0geworCTAsIDAsIDAsIDAsIDAsIDAsIDAsIDAsCisJMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwK
KwlLRVlfTEVGVEJSQUNFLCAwLCAwLCAwLCAwLCAwLCAwLCAwLAorCTAsIDAsIDAsIDAsIDAsIDAs
IDAsIDAsCisJMCwgMCwgS0VZX0hPTUUsIDAsIDAsIEtFWV9QQUdFRE9XTiwgS0VZX1BBR0VVUCwg
MCwKKwkwLCAwLCAwLCBLRVlfUklHSFRCUkFDRSwgS0VZX0xFRlRCUkFDRSwgMCwgMCwgS0VZX1JJ
R0hUQlJBQ0UsCisJMCwgMCwgMCwgS0VZX0xFRlRTSElGVCwgMCwgMCwgS0VZX0ZOLCAwLAorCTAs
IEtFWV9SSUdIVFNISUZULCAwLCAwLCBLRVlfRU5ELCAwLCAwLCAwLAorfTsKKworLyogZGlyZWN0
IGtleSBtYXAgKi8KK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXJzdF9kaXJlY3Rfa2V5Y29kZVtNQVhf
RElSRUNUX0tFWV9OVU1dID0geworCUtFWV9WT0xVTUVVUCwgS0VZX1ZPTFVNRURPV04sIEtFWV9I
QUxGU0hVVFRFUiwgS0VZX0ZVTExTSFVUVEVSLAorfTsKKworc3RydWN0IG1yc3Rfa2V5cGFkIHsK
KworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldjsKKwl2b2lkIF9faW9tZW0gKm1taW9fYmFz
ZTsKKworCXVuc2lnbmVkIGludAltYXRyaXhfa2V5X3Jvd3M7CisJdW5zaWduZWQgaW50CW1hdHJp
eF9rZXlfY29sczsKKwlpbnQJCW1hdHJpeF9rZXlfbWFwX3NpemU7CisKKwkvKiBrZXkgZGVib3Vu
Y2UgaW50ZXJ2YWwgKi8KKwl1bnNpZ25lZCBpbnQJZGVib3VuY2VfaW50ZXJ2YWw7CisKKwkvKiBt
YXRyaXgga2V5IGNvZGUgbWFwICovCisJdW5zaWduZWQgaW50IG1hdHJpeF9rZXljb2Rlc1tNQVhf
TUFUUklYX0tFWV9OVU1dOworCisJLyogc3RhdGUgcm93IGJpdHMgb2YgZWFjaCBjb2x1bW4gc2Nh
biAqLworCXVpbnQzMl90IG1hdHJpeF9rZXlfc3RhdGVbTUFYX01BVFJJWF9LRVlfQ09MU107CisJ
dWludDMyX3QgZGlyZWN0X2tleV9zdGF0ZTsKKworCXVuc2lnbmVkIGludCBkaXJlY3Rfa2V5X21h
c2s7CisKKwlpbnQgZGlyZWN0X2tleV9udW07CisKKwl1bnNpZ25lZCBpbnQgZGlyZWN0X2tleV9t
YXBbTUFYX0RJUkVDVF9LRVlfTlVNXTsKKworCS8qIHJvdGFyeSBlbmNvZGVycyAwICovCisJaW50
IGVuYWJsZV9yb3RhcnkwOworCWludCByb3RhcnkwX3JlbF9jb2RlOworCWludCByb3RhcnkwX3Vw
X2tleTsKKwlpbnQgcm90YXJ5MF9kb3duX2tleTsKKworCS8qIHJvdGFyeSBlbmNvZGVycyAxICov
CisJaW50IGVuYWJsZV9yb3RhcnkxOworCWludCByb3RhcnkxX3JlbF9jb2RlOworCWludCByb3Rh
cnkxX3VwX2tleTsKKwlpbnQgcm90YXJ5MV9kb3duX2tleTsKKworCWludCByb3RhcnlfcmVsX2Nv
ZGVbMl07CisJaW50IHJvdGFyeV91cF9rZXlbMl07CisJaW50IHJvdGFyeV9kb3duX2tleVsyXTsK
KworCS8qIEZuIGtleSAqLworCWludCBmbjsKKworCS8qIE51bWJlciBMb2NrIGtleSAqLworCWlu
dCBudW1sY2s7CisKKwkvKkZJWE1FIElSUSBjb3VudCovCisJaW50IGNvdW50OworfTsKKworc3Rh
dGljIHZvaWQgbXJzdF9rZXlwYWRfYnVpbGRfa2V5Y29kZShzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtl
eXBhZCkKK3sKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXYgPSBrZXlwYWQtPmlucHV0X2Rl
djsKKwl1bnNpZ25lZCBpbnQgKmtleTsKKwlpbnQgaSwgY29kZTsKKworCWtleXBhZC0+bWF0cml4
X2tleV9yb3dzID0gTUFYX01BVFJJWF9LRVlfUk9XUzsKKwlrZXlwYWQtPm1hdHJpeF9rZXlfY29s
cyA9IE1BWF9NQVRSSVhfS0VZX0NPTFM7CisJa2V5cGFkLT5tYXRyaXhfa2V5X21hcF9zaXplID0g
TUFYX01BVFJJWF9LRVlfTlVNOworCWtleXBhZC0+ZGVib3VuY2VfaW50ZXJ2YWwgPSBERUJPVU5D
RV9JTlRFUlZBTDsKKworCS8qIHRocmVlIHNldHMgb2Yga2V5Y29kZSBoZXJlICovCisJaWYgKGtl
eXBhZC0+Zm4pCisJCW1lbWNweShrZXlwYWQtPm1hdHJpeF9rZXljb2RlcywgbXJzdF9rZXljb2Rl
X2ZuLCBcCisJCSAgICAgICBzaXplb2Yoa2V5cGFkLT5tYXRyaXhfa2V5Y29kZXMpKTsKKwllbHNl
IGlmIChrZXlwYWQtPm51bWxjaykKKwkJbWVtY3B5KGtleXBhZC0+bWF0cml4X2tleWNvZGVzLCBt
cnN0X2tleWNvZGVfbnVtbGNrLCBcCisJCSAgICAgICBzaXplb2Yoa2V5cGFkLT5tYXRyaXhfa2V5
Y29kZXMpKTsKKwllbHNlCisJCW1lbWNweShrZXlwYWQtPm1hdHJpeF9rZXljb2RlcywgbXJzdF9r
ZXljb2RlLCBcCisJCSAgICAgICBzaXplb2Yoa2V5cGFkLT5tYXRyaXhfa2V5Y29kZXMpKTsKKwor
CW1lbWNweShrZXlwYWQtPmRpcmVjdF9rZXlfbWFwLCBtcnN0X2RpcmVjdF9rZXljb2RlLCBcCisJ
ICAgICAgIHNpemVvZihrZXlwYWQtPmRpcmVjdF9rZXlfbWFwKSk7CisKKwlrZXkgPSAma2V5cGFk
LT5tYXRyaXhfa2V5Y29kZXNbMF07CisJZm9yIChpID0gMDsgaSA8IE1BWF9NQVRSSVhfS0VZX05V
TTsgaSsrLCBrZXkrKykgeworCQljb2RlID0gKCprZXkpICYgMHhmZmZmZmY7CisJCXNldF9iaXQo
Y29kZSwgaW5wdXRfZGV2LT5rZXliaXQpOworCX0KKworCWtleSA9ICZrZXlwYWQtPmRpcmVjdF9r
ZXlfbWFwWzBdOworCWZvciAoaSA9IDA7IGkgPCBNQVhfRElSRUNUX0tFWV9OVU07IGkrKywga2V5
KyspIHsKKwkJY29kZSA9ICgqa2V5KSAmIDB4ZmZmZmZmOworCQlzZXRfYml0KGNvZGUsIGlucHV0
X2Rldi0+a2V5Yml0KTsKKwl9CisKKwlrZXlwYWQtPmRpcmVjdF9rZXlfbnVtID0gTUFYX0RJUkVD
VF9LRVlfTlVNOworCWtleXBhZC0+ZW5hYmxlX3JvdGFyeTAgPSAwOworCWtleXBhZC0+ZW5hYmxl
X3JvdGFyeTEgPSAwOworCit9CisKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGxvb2t1cF9t
YXRyaXhfa2V5Y29kZSgKKwkJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQsIGludCByb3csIGlu
dCBjb2wpCit7CisJcmV0dXJuIGtleXBhZC0+bWF0cml4X2tleWNvZGVzWyhyb3cgPDwgMykgKyBj
b2xdOworfQorCitzdGF0aWMgdm9pZCBoYW5kbGVfY29uc3RhbnRfa2V5cHJlc3Moc3RydWN0IG1y
c3Rfa2V5cGFkICprZXlwYWQsCisJCQkJICAgICBpbnQgbnVtLCBpbnQgY29sLCBpbnQgcm93LAor
CQkJCSAgICAgdWludDMyX3QgKm9sZF9zdGF0ZSkKK3sKKwlzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYg
PSBrZXlwYWQtPmlucHV0X2RldjsKKwlpbnQgc3RhdGUgPSBvbGRfc3RhdGVbY29sXSAmICgxIDw8
IHJvdyk7CisKKwlzd2l0Y2ggKG51bSkgeworCWNhc2UgMDoKKwkJaWYgKGtleXBhZC0+Zm4pCisJ
CQlrZXlwYWQtPmZuID0gMDsKKwkJLyogTWFudWFsbHkgcmVsZWFzZSBzcGVjaWFsIGtleXMgKEZu
IGNvbWJpbmF0aW9ucykgKi8KKwkJaWYgKCEhdGVzdF9iaXQoS0VZX0xFRlRCUkFDRSwgZGV2LT5r
ZXkpKQorCQkJaW5wdXRfcmVwb3J0X2tleShkZXYsIEtFWV9MRUZUQlJBQ0UsIDApOworCQlpZiAo
ISF0ZXN0X2JpdChLRVlfUklHSFRCUkFDRSwgZGV2LT5rZXkpKQorCQkJaW5wdXRfcmVwb3J0X2tl
eShkZXYsIEtFWV9SSUdIVEJSQUNFLCAwKTsKKwkJaWYgKCEhdGVzdF9iaXQoS0VZX0hPTUUsIGRl
di0+a2V5KSkKKwkJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBLRVlfUklHSFRCUkFDRSwgMCk7CisJ
CWlmICghIXRlc3RfYml0KEtFWV9FTkQsIGRldi0+a2V5KSkKKwkJCWlucHV0X3JlcG9ydF9rZXko
ZGV2LCBLRVlfRU5ELCAwKTsKKwkJaWYgKCEhdGVzdF9iaXQoS0VZX1BBR0VVUCwgZGV2LT5rZXkp
KQorCQkJaW5wdXRfcmVwb3J0X2tleShkZXYsIEtFWV9SSUdIVEJSQUNFLCAwKTsKKwkJaWYgKCEh
dGVzdF9iaXQoS0VZX1BBR0VET1dOLCBkZXYtPmtleSkpCisJCQlpbnB1dF9yZXBvcnRfa2V5KGRl
diwgS0VZX1JJR0hUQlJBQ0UsIDApOworCisJCXJldHVybjsKKworCWNhc2UgMToKKwkJLyogaWYg
Rm4gcHJlc3NlZCAqLworCQlpZiAoY29sID09IDYgJiYgcm93ID09IDYpCisJCQlrZXlwYWQtPmZu
ID0gMTsKKwkJLyoga2V5ICdbJyAqLworCQllbHNlIGlmICgoY29sID09IDAgJiYgcm93ID09IDIp
ICYmIHN0YXRlKSB7CisJCQlrZXlwYWQtPmZuID0gMDsKKwkJCXNldF9iaXQoS0VZX0VRVUFMLCBk
ZXYtPmtleSk7CisJCQlkZXYtPnJlcGVhdF9rZXkgPSBLRVlfRVFVQUw7CisJCX0KKwkJLyoga2V5
ICddJyAqLworCQllbHNlIGlmICgoY29sID09IDMgJiYgcm93ID09IDUpICYmIHN0YXRlKSB7CisJ
CQlrZXlwYWQtPmZuID0gMDsKKwkJCXNldF9iaXQoS0VZX1NMQVNILCBkZXYtPmtleSk7CisJCQlk
ZXYtPnJlcGVhdF9rZXkgPSBLRVlfU0xBU0g7CisJCX0KKwkJLyoga2V5ICd7JyAqLworCQllbHNl
IGlmICgoY29sID09IDQgJiYgcm93ID09IDUpICYmIHN0YXRlKSB7CisJCQlrZXlwYWQtPmZuID0g
MDsKKwkJCXNldF9iaXQoS0VZX0NPTU1BLCBkZXYtPmtleSk7CisJCQlkZXYtPnJlcGVhdF9rZXkg
PSBLRVlfQ09NTUE7CisJCX0KKwkJLyoga2V5ICd9JyAqLworCQllbHNlIGlmICgoY29sID09IDcg
JiYgcm93ID09IDUpICYmIHN0YXRlKSB7CisJCQlrZXlwYWQtPmZuID0gMDsKKwkJCXNldF9iaXQo
S0VZX0RPVCwgZGV2LT5rZXkpOworCQkJZGV2LT5yZXBlYXRfa2V5ID0gS0VZX0RPVDsKKwkJfQor
CisJCXJldHVybjsKKwlkZWZhdWx0OgorCQk7CisJfQorfQorCitzdGF0aWMgdm9pZCBtcnN0X2tl
eXBhZF9zY2FuX21hdHJpeChzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwlpbnQgcm93
LCBjb2wsIG51bV9rZXlzX3ByZXNzZWQgPSAwOworCXVpbnQzMl90IG5ld19zdGF0ZVtNQVhfTUFU
UklYX0tFWV9DT0xTXTsKKwl1aW50MzJfdCBrcGFzID0ga2V5cGFkX3JlYWRsKEtQQVMpOworCisJ
bnVtX2tleXNfcHJlc3NlZCA9IEtQQVNfTVVLUChrcGFzKTsKKworCW1lbXNldChuZXdfc3RhdGUs
IDAsIHNpemVvZihuZXdfc3RhdGUpKTsKKworCWlmIChudW1fa2V5c19wcmVzc2VkID09IDApIHsK
KwkJaGFuZGxlX2NvbnN0YW50X2tleXByZXNzKGtleXBhZCwgbnVtX2tleXNfcHJlc3NlZCwgMCwg
MCwKKwkJCQkJIGtleXBhZC0+bWF0cml4X2tleV9zdGF0ZSk7CisKKwkJZ290byBzY2FuOworCX0K
KworCWlmIChudW1fa2V5c19wcmVzc2VkID09IDEpIHsKKwkJY29sID0gS1BBU19DUChrcGFzKTsK
KwkJcm93ID0gS1BBU19SUChrcGFzKTsKKworCQkvKiBpZiBpbnZhbGlkIHJvdy9jb2wsIHRyZWF0
IGFzIG5vIGtleSBwcmVzc2VkICovCisJCWlmIChjb2wgPj0ga2V5cGFkLT5tYXRyaXhfa2V5X2Nv
bHMgfHwKKwkJICAgIHJvdyA+PSBrZXlwYWQtPm1hdHJpeF9rZXlfcm93cykKKwkJCWdvdG8gc2Nh
bjsKKworCQkvKiBpZiBOdW1MayBwcmVzc2VkICovCisJCWlmIChjb2wgPT0gMCAmJiByb3cgPT0g
MSkKKwkJCWtleXBhZC0+bnVtbGNrID0gIWtleXBhZC0+bnVtbGNrOworCisJCWhhbmRsZV9jb25z
dGFudF9rZXlwcmVzcyhrZXlwYWQsIG51bV9rZXlzX3ByZXNzZWQsIGNvbCwgcm93LAorCQkJCQkg
a2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlKTsKKworCQluZXdfc3RhdGVbY29sXSA9ICgxIDw8IHJv
dyk7CisKKwkJZ290byBzY2FuOworCX0KKworCWlmIChudW1fa2V5c19wcmVzc2VkID4gMSkgewor
CQl1aW50MzJfdCBrcGFzbWtwMCA9IGtleXBhZF9yZWFkbChLUEFTTUtQMCk7CisJCXVpbnQzMl90
IGtwYXNta3AxID0ga2V5cGFkX3JlYWRsKEtQQVNNS1AxKTsKKwkJdWludDMyX3Qga3Bhc21rcDIg
PSBrZXlwYWRfcmVhZGwoS1BBU01LUDIpOworCQl1aW50MzJfdCBrcGFzbWtwMyA9IGtleXBhZF9y
ZWFkbChLUEFTTUtQMyk7CisKKwkJbmV3X3N0YXRlWzBdID0ga3Bhc21rcDAgJiBLUEFTTUtQX01L
Q19NQVNLOworCQluZXdfc3RhdGVbMV0gPSAoa3Bhc21rcDAgPj4gMTYpICYgS1BBU01LUF9NS0Nf
TUFTSzsKKwkJbmV3X3N0YXRlWzJdID0ga3Bhc21rcDEgJiBLUEFTTUtQX01LQ19NQVNLOworCQlu
ZXdfc3RhdGVbM10gPSAoa3Bhc21rcDEgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJbmV3
X3N0YXRlWzRdID0ga3Bhc21rcDIgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbNV0g
PSAoa3Bhc21rcDIgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJbmV3X3N0YXRlWzZdID0g
a3Bhc21rcDMgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbN10gPSAoa3Bhc21rcDMg
Pj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKworCQkvKiBpZiBGbiBpcyBwcmVzc2VkLCBhbGwg
U0hJRlQgaXMgaWdub3JlZCwgZXhjZXB0IHdoZW4geworCQkgKiBvciB9IGlzIHByZXNzZWQgKi8K
KwkJaWYgKG5ld19zdGF0ZVs2XSAmIDB4NDApIHsKKwkJCWtleXBhZC0+Zm4gPSAxOworCQkJbmV3
X3N0YXRlWzNdICY9IH4weDQwOworCQkJbmV3X3N0YXRlWzFdICY9IH4weDgwOworCQl9CisKKwkJ
aWYgKGtleXBhZC0+Zm4gPT0gMSkgeworCQkJLyogaWYgeyBvciB9IHByZXNzZWQgKi8KKwkJCWlm
ICgobmV3X3N0YXRlWzRdICYgMHgyMCkgfHwgKG5ld19zdGF0ZVs3XSAmIDB4MjApKSB7CisJCQkJ
LyogYXMgaWYgTEVGVFNISUZUIGlzIHByZXNzZWQgKi8KKwkJCQluZXdfc3RhdGVbM10gfD0gMHg0
MDsKKwkJCQkvKiBhcyBpZiBGbiBub3QgcHJlc3NlZCAqLworCQkJCW5ld19zdGF0ZVs2XSAmPSB+
MHg0MDsKKwkJCX0KKwkJCS8qIGlmIFsgb3IgXSBwcmVzc2VkICovCisJCQlpZiAoKG5ld19zdGF0
ZVswXSAmIDB4MDQpIHx8IChuZXdfc3RhdGVbM10gJiAweDIwKSkKKwkJCQkvKiBhcyBpZiBGbiBu
b3QgcHJlc3NlZCAqLworCQkJCW5ld19zdGF0ZVs2XSAmPSB+MHg0MDsKKwkJfQorCX0KKworCitz
Y2FuOgorCS8qIHJlLWJ1aWxkIGtleWNvZGUgKi8KKwltcnN0X2tleXBhZF9idWlsZF9rZXljb2Rl
KGtleXBhZCk7CisKKwlmb3IgKGNvbCA9IDA7IGNvbCA8IGtleXBhZC0+bWF0cml4X2tleV9jb2xz
OyBjb2wrKykgeworCQl1aW50MzJfdCBiaXRzX2NoYW5nZWQ7CisKKwkJYml0c19jaGFuZ2VkID0g
a2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlW2NvbF0gXiBuZXdfc3RhdGVbY29sXTsKKwkJaWYgKGJp
dHNfY2hhbmdlZCA9PSAwKQorCQkJY29udGludWU7CisKKwkJZm9yIChyb3cgPSAwOyByb3cgPCBr
ZXlwYWQtPm1hdHJpeF9rZXlfcm93czsgcm93KyspIHsKKwkJCWlmICgoYml0c19jaGFuZ2VkICYg
KDEgPDwgcm93KSkgPT0gMCkKKwkJCQljb250aW51ZTsKKworCQkJaW5wdXRfcmVwb3J0X2tleShr
ZXlwYWQtPmlucHV0X2RldiwKKwkJCQlsb29rdXBfbWF0cml4X2tleWNvZGUoa2V5cGFkLCByb3cs
IGNvbCksCisJCQkJbmV3X3N0YXRlW2NvbF0gJiAoMSA8PCByb3cpKTsKKwkJfQorCX0KKwlpbnB1
dF9zeW5jKGtleXBhZC0+aW5wdXRfZGV2KTsKKwltZW1jcHkoa2V5cGFkLT5tYXRyaXhfa2V5X3N0
YXRlLCBuZXdfc3RhdGUsIHNpemVvZihuZXdfc3RhdGUpKTsKK30KKworI2RlZmluZSBERUZBVUxU
X0tQUkVDCSgweDAwN2YwMDdmKQorCitzdGF0aWMgaW5saW5lIGludCByb3RhcnlfZGVsdGEodWlu
dDMyX3Qga3ByZWMpCit7CisJaWYgKGtwcmVjICYgS1BSRUNfT0YwKQorCQlyZXR1cm4gKGtwcmVj
ICYgMHhmZikgKyAweDdmOworCWVsc2UgaWYgKGtwcmVjICYgS1BSRUNfVUYwKQorCQlyZXR1cm4g
KGtwcmVjICYgMHhmZikgLSAweDdmIC0gMHhmZjsKKwllbHNlCisJCXJldHVybiAoa3ByZWMgJiAw
eGZmKSAtIDB4N2Y7Cit9CisKK3N0YXRpYyB2b2lkIHJlcG9ydF9yb3RhcnlfZXZlbnQoc3RydWN0
IG1yc3Rfa2V5cGFkICprZXlwYWQsIGludCByLCBpbnQgZGVsdGEpCit7CisJc3RydWN0IGlucHV0
X2RldiAqZGV2ID0ga2V5cGFkLT5pbnB1dF9kZXY7CisKKwlpZiAoZGVsdGEgPT0gMCkKKwkJcmV0
dXJuOworCisJaWYgKGtleXBhZC0+cm90YXJ5X3VwX2tleVtyXSAmJiBrZXlwYWQtPnJvdGFyeV9k
b3duX2tleVtyXSkgeworCQlpbnQga2V5Y29kZSA9IChkZWx0YSA+IDApID8ga2V5cGFkLT5yb3Rh
cnlfdXBfa2V5W3JdIDoKKwkJCQkJICAgIGtleXBhZC0+cm90YXJ5X2Rvd25fa2V5W3JdOworCisJ
CS8qIHNpbXVsYXRlIGEgcHJlc3Mtbi1yZWxlYXNlICovCisJCWlucHV0X3JlcG9ydF9rZXkoZGV2
LCBrZXljb2RlLCAxKTsKKwkJaW5wdXRfc3luYyhkZXYpOworCQlpbnB1dF9yZXBvcnRfa2V5KGRl
diwga2V5Y29kZSwgMCk7CisJCWlucHV0X3N5bmMoZGV2KTsKKwl9IGVsc2UgeworCQlpbnB1dF9y
ZXBvcnRfcmVsKGRldiwga2V5cGFkLT5yb3RhcnlfcmVsX2NvZGVbcl0sIGRlbHRhKTsKKwkJaW5w
dXRfc3luYyhkZXYpOworCX0KK30KKworc3RhdGljIHZvaWQgbXJzdF9rZXlwYWRfc2Nhbl9yb3Rh
cnkoc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQpCit7CisJdW5zaWduZWQgaW50IGtwcmVjOwor
CisJLyogcmVhZCBhbmQgcmVzZXQgdG8gZGVmYXVsdCBjb3VudCB2YWx1ZSAqLworCWtwcmVjID0g
a2V5cGFkX3JlYWRsKEtQUkVDKTsKKwlrZXlwYWRfd3JpdGVsKEtQUkVDLCBERUZBVUxUX0tQUkVD
KTsKKworCWlmIChrZXlwYWQtPmVuYWJsZV9yb3RhcnkwKQorCQlyZXBvcnRfcm90YXJ5X2V2ZW50
KGtleXBhZCwgMCwgcm90YXJ5X2RlbHRhKGtwcmVjKSk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVf
cm90YXJ5MSkKKwkJcmVwb3J0X3JvdGFyeV9ldmVudChrZXlwYWQsIDEsIHJvdGFyeV9kZWx0YShr
cHJlYyA+PiAxNikpOworfQorCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9zY2FuX2RpcmVjdChz
dHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwl1bnNpZ25lZCBpbnQgbmV3X3N0YXRlOwor
CXVpbnQzMl90IGtwZGssIGJpdHNfY2hhbmdlZDsKKwlpbnQgaTsKKworCWtwZGsgPSBrZXlwYWRf
cmVhZGwoS1BESyk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5MCB8fCBrZXlwYWQtPmVu
YWJsZV9yb3RhcnkxKQorCQltcnN0X2tleXBhZF9zY2FuX3JvdGFyeShrZXlwYWQpOworCisJaWYg
KChrZXlwYWQtPmRpcmVjdF9rZXlfbWFwID09IE5VTEwpIHx8ICgrK2tleXBhZC0+Y291bnQgPT0g
MSkpIHsKKwkJa2V5cGFkLT5kaXJlY3Rfa2V5X3N0YXRlID0gMDsKKwkJcmV0dXJuOworCX0KKwor
CW5ld19zdGF0ZSA9IEtQREtfREsoa3BkaykgJiBrZXlwYWQtPmRpcmVjdF9rZXlfbWFzazsKKwlu
ZXdfc3RhdGUgPSB+bmV3X3N0YXRlOworCWJpdHNfY2hhbmdlZCA9IGtleXBhZC0+ZGlyZWN0X2tl
eV9zdGF0ZSBeIG5ld19zdGF0ZTsKKworCWlmIChiaXRzX2NoYW5nZWQgPT0gMCkKKwkJcmV0dXJu
OworCisJZm9yIChpID0gMDsgaSA8IGtleXBhZC0+ZGlyZWN0X2tleV9udW07IGkrKykgeworCQlp
ZiAoYml0c19jaGFuZ2VkICYgKDEgPDwgaSkpIHsKKwkJCWlucHV0X3JlcG9ydF9rZXkoa2V5cGFk
LT5pbnB1dF9kZXYsCisJCQkJCSBrZXlwYWQtPmRpcmVjdF9rZXlfbWFwW2ldLAorCQkJCQkgKG5l
d19zdGF0ZSAmICgxIDw8IGkpKSk7CisJCX0KKwl9CisJaW5wdXRfc3luYyhrZXlwYWQtPmlucHV0
X2Rldik7CisJa2V5cGFkLT5kaXJlY3Rfa2V5X3N0YXRlID0gbmV3X3N0YXRlOworCit9CisKK3N0
YXRpYyBpcnFyZXR1cm5fdCBtcnN0X2tleXBhZF9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpCit7CisJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQgPSBkZXZfaWQ7CisJdW5zaWdu
ZWQgbG9uZyBrcGMgPSBrZXlwYWRfcmVhZGwoS1BDKTsKKworCWlmIChrcGMgJiBLUENfREkpCisJ
CW1yc3Rfa2V5cGFkX3NjYW5fZGlyZWN0KGtleXBhZCk7CisKKwlpZiAoa3BjICYgS1BDX01JKQor
CQltcnN0X2tleXBhZF9zY2FuX21hdHJpeChrZXlwYWQpOworCisJcmV0dXJuIElSUV9IQU5ETEVE
OworfQorCisvKiB0ZW1wb3JpbHkgcmVtb3ZlIEdQSU8gZGVwZW5kZW5jaWVzIGhlcmUuLi4gKi8K
KyNpZiAwIAorI2RlZmluZQlLRVlQQURfTUFUUklYX0dQSU9fSU5fUElOCTI0CisjZGVmaW5lCUtF
WVBBRF9NQVRSSVhfR1BJT19PVVRfUElOCTMyCisjZGVmaW5lIEtFWVBBRF9ESVJFQ1RfR1BJT19J
Tl9QSU4JNDAKK3N0YXRpYyB2b2lkIG1yc3Rfa2V5cGFkX2dwaW9faW5pdCh2b2lkKQoreworCWlu
dCBpOworCisJZm9yIChpID0gMDsgaSA8IE1BWF9NQVRSSVhfS0VZX1JPV1M7IGkrKykgeworCQln
cGlvX2RpcmVjdGlvbl9pbnB1dChLRVlQQURfTUFUUklYX0dQSU9fSU5fUElOICsgaSk7CisJCWdw
aW9fYWx0X2Z1bmMoS0VZUEFEX01BVFJJWF9HUElPX0lOX1BJTiArIGksIDEpOworCX0KKworCWZv
ciAoaSA9IDA7IGkgPCBNQVhfTUFUUklYX0tFWV9DT0xTOyBpKyspIHsKKwkJLyogX19ncGlvX3Nl
dF92YWx1ZShLRVlQQURfR1BJT19PVVRfUElOICsgaSwgMSk7ICovCisJCS8qIHNldCBhY3Rpb24g
aXMgZXhlY3V0ZWQgaW4gZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KCkgKi8KKwkJZ3Bpb19kaXJlY3Rp
b25fb3V0cHV0KEtFWVBBRF9NQVRSSVhfR1BJT19PVVRfUElOICsgaSwgMSk7CisJCWdwaW9fYWx0
X2Z1bmMoS0VZUEFEX01BVFJJWF9HUElPX09VVF9QSU4gKyBpLCAxKTsKKwl9CisKKwlmb3IgKGkg
PSAwOyBpIDwgTUFYX0RJUkVDVF9LRVlfTlVNOyBpKyspIHsKKwkJZ3Bpb19kaXJlY3Rpb25faW5w
dXQoS0VZUEFEX0RJUkVDVF9HUElPX0lOX1BJTiArIGkpOworCQlncGlvX2FsdF9mdW5jKEtFWVBB
RF9ESVJFQ1RfR1BJT19JTl9QSU4gKyBpLCAxKTsKKwl9Cit9CisjZW5kaWYKKworc3RhdGljIHZv
aWQgbXJzdF9rZXlwYWRfY29uZmlnKHN0cnVjdCBtcnN0X2tleXBhZCAqa2V5cGFkKQoreworCXVu
c2lnbmVkIGludCBtYXNrID0gMCwgZGlyZWN0X2tleV9udW0gPSAwOworCXVuc2lnbmVkIGxvbmcg
a3BjID0gMDsKKworCS8qIGVuYWJsZSBtYXRyaXgga2V5cyB3aXRoIGF1dG9tYXRpYyBzY2FuICov
CisJaWYgKGtleXBhZC0+bWF0cml4X2tleV9yb3dzICYmIGtleXBhZC0+bWF0cml4X2tleV9jb2xz
KSB7CisJCWtwYyB8PSBLUENfQVNBQ1QgfCBLUENfTUlFIHwgS1BDX01FIHwgS1BDX01TX0FMTDsK
KwkJa3BjIHw9IEtQQ19NS1JOKGtleXBhZC0+bWF0cml4X2tleV9yb3dzKSB8CisJCSAgICAgICBL
UENfTUtDTihrZXlwYWQtPm1hdHJpeF9rZXlfY29scyk7CisJfQorCisJLyogZW5hYmxlIHJvdGFy
eSBrZXksIGRlYm91bmNlIGludGVydmFsIHNhbWUgYXMgZGlyZWN0IGtleXMgKi8KKwlpZiAoa2V5
cGFkLT5lbmFibGVfcm90YXJ5MCkgeworCQltYXNrIHw9IDB4MDM7CisJCWRpcmVjdF9rZXlfbnVt
ID0gMjsKKwkJa3BjIHw9IEtQQ19SRUUwOworCX0KKworCWlmIChrZXlwYWQtPmVuYWJsZV9yb3Rh
cnkxKSB7CisJCW1hc2sgfD0gMHgwYzsKKwkJZGlyZWN0X2tleV9udW0gPSA0OworCQlrcGMgfD0g
S1BDX1JFRTE7CisJfQorCisJaWYgKGtleXBhZC0+ZGlyZWN0X2tleV9udW0gPiBkaXJlY3Rfa2V5
X251bSkKKwkJZGlyZWN0X2tleV9udW0gPSBrZXlwYWQtPmRpcmVjdF9rZXlfbnVtOworCisJa2V5
cGFkLT5kaXJlY3Rfa2V5X21hc2sgPSAoKDIgPDwgZGlyZWN0X2tleV9udW0pIC0gMSkgJiB+bWFz
azsKKworCS8qIGVuYWJsZSBkaXJlY3Qga2V5ICovCisJaWYgKGRpcmVjdF9rZXlfbnVtKQorCQlr
cGMgfD0gS1BDX0RFIHwgS1BDX0RJRSB8IEtQQ19ES04oZGlyZWN0X2tleV9udW0pOworCisJa2V5
cGFkX3dyaXRlbChLUEMsIGtwYyk7CisJa2V5cGFkX3dyaXRlbChLUFJFQywgREVGQVVMVF9LUFJF
Qyk7CisJa2V5cGFkX3dyaXRlbChLUEtESSwga2V5cGFkLT5kZWJvdW5jZV9pbnRlcnZhbCk7Cit9
CisKK3N0YXRpYyBpbnQgbXJzdF9rZXlwYWRfb3BlbihzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpCit7
CisJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQgPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOwor
CisJLyogbXJzdF9rZXlwYWRfZ3Bpb19pbml0KCk7ICovCisJbXJzdF9rZXlwYWRfY29uZmlnKGtl
eXBhZCk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgbXJzdF9rZXlwYWRfY2xvc2Uo
c3RydWN0IGlucHV0X2RldiAqZGV2KQoreworCXN0cnVjdCBtcnN0X2tleXBhZCAqa2V5cGFkIDsK
KwlrZXlwYWQgPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOworfQorCisjaWZkZWYgQ09ORklHX1BN
CitzdGF0aWMgaW50IG1yc3Rfa2V5cGFkX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHBt
X21lc3NhZ2VfdCBzdGF0ZSkKK3sKKwkvKiBzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCA9IHBj
aV9nZXRfZHJ2ZGF0YShwZGV2KTsgKi8KKworCS8qIGNsa19kaXNhYmxlKGtleXBhZC0+Y2xrKTsg
Ki8KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBtcnN0X2tleXBhZF9yZXN1bWUoc3RydWN0
IHBjaV9kZXYgKnBkZXYpCit7CisJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQgPSBwY2lfZ2V0
X2RydmRhdGEocGRldik7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXRfZGV2ID0ga2V5cGFkLT5p
bnB1dF9kZXY7CisKKwltdXRleF9sb2NrKCZpbnB1dF9kZXYtPm11dGV4KTsKKworCWlmIChpbnB1
dF9kZXYtPnVzZXJzKSB7CisJCS8qIEVuYWJsZSB1bml0IGNsb2NrICovCisJCS8qIGNsa19lbmFi
bGUoa2V5cGFkLT5jbGspOyAqLworCQltcnN0X2tleXBhZF9jb25maWcoa2V5cGFkKTsKKwl9CisK
KwltdXRleF91bmxvY2soJmlucHV0X2Rldi0+bXV0ZXgpOworCisJcmV0dXJuIDA7Cit9CisjZWxz
ZQorI2RlZmluZSBtcnN0X2tleXBhZF9zdXNwZW5kCU5VTEwKKyNkZWZpbmUgbXJzdF9rZXlwYWRf
cmVzdW1lCU5VTEwKKyNlbmRpZgorCisKK3N0YXRpYyBpbnQgX19kZXZpbml0IG1yc3Rfa2V5cGFk
X3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAorCQkJY29uc3Qgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgKmVudCkKK3sKKwlzdHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZDsKKwlzdHJ1Y3QgaW5wdXRf
ZGV2ICppbnB1dF9kZXY7CisJaW50IGVycm9yOworCisjaWZuZGVmIE1PRFVMRQorCXByaW50ayhL
RVJOX0lORk8gTVJTVF9LRVlQQURfRFJJVkVSX05BTUUgIlxuIik7CisjZW5kaWYKKworCWtleXBh
ZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBtcnN0X2tleXBhZCksIEdGUF9LRVJORUwpOworCWlm
IChrZXlwYWQgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gYWxs
b2NhdGUgZHJpdmVyIGRhdGFcbiIpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisKKwllcnJvciA9
IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOworCWlmIChlcnJvciB8fCAocGRldi0+aXJxIDwgMCkp
IHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBkZXZpY2UvZ2V0IGly
cVxuIik7CisJCWVycm9yID0gLUVOWElPOworCQlnb3RvIGZhaWxlZF9mcmVlOworCX0KKworCWVy
cm9yID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7CisJaWYgKGVycm9yKSB7
CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZXF1ZXN0IEkvTyBtZW1vcnlcbiIp
OworCQlnb3RvIGZhaWxlZF9mcmVlOworCX0KKworCWtleXBhZC0+bW1pb19iYXNlID0gaW9yZW1h
cChwY2lfcmVzb3VyY2Vfc3RhcnQocGRldiwgMCksIFwKKwkJcGNpX3Jlc291cmNlX2xlbihwZGV2
LCAwKSk7CisJaWYgKGtleXBhZC0+bW1pb19iYXNlID09IE5VTEwpIHsKKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiZmFpbGVkIHRvIHJlbWFwIEkvTyBtZW1vcnlcbiIpOworCQllcnJvciA9IC1FTlhJ
TzsKKwkJZ290byBmYWlsZWRfZnJlZV9tZW07CisJfQorCisJLyogQ3JlYXRlIGFuZCByZWdpc3Rl
ciB0aGUgaW5wdXQgZHJpdmVyLiAqLworCWlucHV0X2RldiA9IGlucHV0X2FsbG9jYXRlX2Rldmlj
ZSgpOworCWlmICghaW5wdXRfZGV2KSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0
byBhbGxvY2F0ZSBpbnB1dCBkZXZpY2VcbiIpOworCQllcnJvciA9IC1FTk9NRU07CisJCWdvdG8g
ZmFpbGVkX2ZyZWVfaW87CisJfQorCisJaW5wdXRfZGV2LT5uYW1lID0gcGNpX25hbWUocGRldik7
CisJaW5wdXRfZGV2LT5pZC5idXN0eXBlID0gQlVTX1BDSTsKKwlpbnB1dF9kZXYtPm9wZW4gPSBt
cnN0X2tleXBhZF9vcGVuOworCWlucHV0X2Rldi0+Y2xvc2UgPSBtcnN0X2tleXBhZF9jbG9zZTsK
KwlpbnB1dF9kZXYtPmRldi5wYXJlbnQgPSAmcGRldi0+ZGV2OworCisJaW5wdXRfZGV2LT5rZXlj
b2RlID0ga2V5cGFkLT5tYXRyaXhfa2V5Y29kZXM7CisJaW5wdXRfZGV2LT5rZXljb2Rlc2l6ZSA9
IHNpemVvZih1bnNpZ25lZCBpbnQpOworCWlucHV0X2Rldi0+a2V5Y29kZW1heCA9IEFSUkFZX1NJ
WkUobXJzdF9rZXljb2RlKTsKKworCWtleXBhZC0+aW5wdXRfZGV2ID0gaW5wdXRfZGV2OworCWtl
eXBhZC0+Zm4gPSAwOworCWtleXBhZC0+bnVtbGNrID0gMDsKKwkvKkZJWE1FKi9rZXlwYWQtPmNv
dW50ID0gMDsKKwlpbnB1dF9zZXRfZHJ2ZGF0YShpbnB1dF9kZXYsIGtleXBhZCk7CisKKwlpbnB1
dF9kZXYtPmV2Yml0WzBdID0gQklUX01BU0soRVZfS0VZKSB8IEJJVF9NQVNLKEVWX1JFUCkgfAor
CQlCSVRfTUFTSyhFVl9SRUwpOworCisJbXJzdF9rZXlwYWRfYnVpbGRfa2V5Y29kZShrZXlwYWQp
OworCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBrZXlwYWQpOworCisJZXJyb3IgPSByZXF1ZXN0X2ly
cShwZGV2LT5pcnEsIG1yc3Rfa2V5cGFkX2lycV9oYW5kbGVyLCBJUlFGX1NIQVJFRCwKKwkJcGNp
X25hbWUocGRldiksIGtleXBhZCk7CisJaWYgKGVycm9yKSB7CisJCWRldl9lcnIoJnBkZXYtPmRl
diwgImZhaWxlZCB0byByZXF1ZXN0IElSUVxuIik7CisJCWdvdG8gZmFpbGVkX2ZyZWVfZGV2Owor
CX0KKworCS8qIFJlZ2lzdGVyIHRoZSBpbnB1dCBkZXZpY2UgKi8KKwllcnJvciA9IGlucHV0X3Jl
Z2lzdGVyX2RldmljZShpbnB1dF9kZXYpOworCWlmIChlcnJvcikgeworCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgaW5wdXQgZGV2aWNlXG4iKTsKKwkJZ290byBmYWls
ZWRfZnJlZV9pcnE7CisJfQorCisJcHJpbnRrKEtFUk5fSU5GTyAiKioqIGtleXBhZCBkcml2ZXIg
bG9hZCBzdWNjZXNzZnVsbHkgKioqXG4iKTsKKwlyZXR1cm4gMDsKKworZmFpbGVkX2ZyZWVfaXJx
OgorCWZyZWVfaXJxKHBkZXYtPmlycSwga2V5cGFkKTsKKwlwY2lfc2V0X2RydmRhdGEocGRldiwg
TlVMTCk7CitmYWlsZWRfZnJlZV9kZXY6CisJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsK
K2ZhaWxlZF9mcmVlX2lvOgorCWlvdW5tYXAoa2V5cGFkLT5tbWlvX2Jhc2UpOworZmFpbGVkX2Zy
ZWVfbWVtOgorCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGRldik7CitmYWlsZWRfZnJlZToKKwlrZnJl
ZShrZXlwYWQpOworCXJldHVybiBlcnJvcjsKK30KKworc3RhdGljIHZvaWQgX19kZXZleGl0IG1y
c3Rfa2V5cGFkX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKK3sKKwlzdHJ1Y3QgbXJzdF9r
ZXlwYWQgKmtleXBhZCA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKKworCWZyZWVfaXJxKHBkZXYt
PmlycSwga2V5cGFkKTsKKwlpbnB1dF91bnJlZ2lzdGVyX2RldmljZShrZXlwYWQtPmlucHV0X2Rl
dik7CisJaW91bm1hcChrZXlwYWQtPm1taW9fYmFzZSk7CisJcGNpX3JlbGVhc2VfcmVnaW9ucyhw
ZGV2KTsKKwlwY2lfc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisJa2ZyZWUoa2V5cGFkKTsKK30K
KworCitzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgbXJzdF9rZXlwYWRfZHJpdmVyID0geworCS5u
YW1lCQk9IERSVl9OQU1FLAorCS5pZF90YWJsZQk9IGtleXBhZF9wY2lfdGJsLAorCS5wcm9iZQkJ
PSBtcnN0X2tleXBhZF9wcm9iZSwKKwkucmVtb3ZlCQk9IF9fZGV2ZXhpdF9wKG1yc3Rfa2V5cGFk
X3JlbW92ZSksCisjaWZkZWYgQ09ORklHX1BNCisJLnN1c3BlbmQJPSBtcnN0X2tleXBhZF9zdXNw
ZW5kLAorCS5yZXN1bWUJCT0gbXJzdF9rZXlwYWRfcmVzdW1lLAorI2VuZGlmIC8qIENPTkZJR19Q
TSAqLworfTsKKworc3RhdGljIGludCBfX2luaXQgbXJzdF9rZXlwYWRfaW5pdCh2b2lkKQorewor
I2lmZGVmIE1PRFVMRQorCXByaW50ayhLRVJOX0lORk8gTVJTVF9LRVlQQURfRFJJVkVSX05BTUUg
IlxuIik7CisjZW5kaWYKKworCXJldHVybiBwY2lfcmVnaXN0ZXJfZHJpdmVyKCZtcnN0X2tleXBh
ZF9kcml2ZXIpOworfQorCitzdGF0aWMgdm9pZCBfX2V4aXQgbXJzdF9rZXlwYWRfZXhpdCh2b2lk
KQoreworCXBjaV91bnJlZ2lzdGVyX2RyaXZlcigmbXJzdF9rZXlwYWRfZHJpdmVyKTsKK30KKwor
bW9kdWxlX2luaXQobXJzdF9rZXlwYWRfaW5pdCk7Cittb2R1bGVfZXhpdChtcnN0X2tleXBhZF9l
eGl0KTsKKworTU9EVUxFX0RFU0NSSVBUSU9OKCJNUlNUIEtleXBhZCBDb250cm9sbGVyIERyaXZl
ciIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwotLSAKMS41LjIuNQoK

--_002_61563CE63B4F854986A895DA7AD3C1771595B036pdsmsx502ccrcor_--
