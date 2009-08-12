From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: RE: FW: [PATCH 1/1] input: keypad controller driver for Intel low
	power Moorestown platform
Date: Wed, 12 Aug 2009 15:54:48 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709DB43A5F9@pdsmsx502.ccr.corp.intel.com>
References: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com>
 <20090507164516.GA6450@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_61563CE63B4F854986A895DA7AD3C17709DB43A5F9pdsmsx502ccrc_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61292 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZHLHzk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2009 03:55:40 -0400
In-Reply-To: <20090507164516.GA6450@dtor-d630.eng.vmware.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Ba, Zheng" <zheng.ba@intel.com>

--_002_61563CE63B4F854986A895DA7AD3C17709DB43A5F9pdsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Attached please find the modified patch with your comments inline. Please h=
elp review, thanks!

Thanks,
Zheng



****************************Patch starts from here*************************=
***************
>From 285ba6565a98598e24f5cca73c0a8a46690ea7cd Mon Sep 17 00:00:00 2001
From: Zheng Ba <zheng.ba@intel.com>
Date: Wed, 12 Aug 2009 15:37:17 +0800
Subject: [PATCH] Keypad controller driver for Intel low power Moorestown pl=
atform

This driver has dual-support for two styles of keypads: Direct keypad and
Matrix keypad. The Matrix keypad is 8x8 and works like a normal keyboard ex=
ecpt for some
function keys (Fn). The Direct keypad contains 4 direct keys: camera shutte=
rs
(half/full presses) and volume up/down buttons.

added: drivers/input/mrst_keypad.c
modified: include/linux/input.h
          drivers/input/keyboard/Kconfig
          drivers/input/keyboard/Makefile

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
---
 drivers/input/keyboard/Kconfig       |    7 +
 drivers/input/keyboard/Makefile      |    1 +
 drivers/input/keyboard/mrst_keypad.c |  785 ++++++++++++++++++++++++++++++=
++++
 include/linux/input.h                |    1 +
 4 files changed, 794 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mrst_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
index a6b989a..e49b182 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -361,4 +361,11 @@ config KEYBOARD_XTKBD
          To compile this driver as a module, choose M here: the
          module will be called xtkbd.

+config KEYBOARD_MRST
+       tristate "MRST keypad support"
+       help
+         Say Y if you want to use the mrst keypad
+
+         To compile this driver as a module, choose M here: the
+         module will be called mrst_keypad.
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index b5b5eae..f788256 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_KEYBOARD_LM8323)         +=3D lm8323.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)          +=3D locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)           +=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)          +=3D matrix_keypad.o
+obj-$(CONFIG_KEYBOARD_MRST)            +=3D mrst_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)          +=3D newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)            +=3D omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)          +=3D pxa27x_keypad.o
diff --git a/drivers/input/keyboard/mrst_keypad.c b/drivers/input/keyboard/=
mrst_keypad.c
new file mode 100644
index 0000000..40b994f
--- /dev/null
+++ b/drivers/input/keyboard/mrst_keypad.c
@@ -0,0 +1,785 @@
+/*
+ * linux/drivers/input/keyboard/mrst_keypad.c
+ *
+ * Driver for the matrix keypad controller on Moorestown platform.
+ *
+ * Copyright (c) 2009 Intel Corporation.
+ * Created:    Sep 18, 2008
+ * Updated:    Aug 12, 2009
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
+#define MAX_KEY_NUM            (MAX_MATRIX_KEY_NUM*3 + MAX_DIRECT_KEY_NUM)
+
+#define MAX_MATRIX_KEY_ROWS    (8)
+#define MAX_MATRIX_KEY_COLS    (8)
+#define DEBOUNCE_INTERVAL      100
+
+#define KEY_HALFSHUTTER                KEY_CAMERA_FOCUS
+#define KEY_FULLSHUTTER                KEY_CAMERA
+
+static unsigned int mrst_keycode[MAX_KEY_NUM] =3D {
+       /* matrix keypad */
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3=
,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_U, KEY_7, KEY_M, KEY_J, KEY_8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y=
,
+       KEY_MINUS, KEY_0, KEY_LEFT, KEY_SEMICOLON, KEY_P, KEY_DOWN, KEY_UP,=
\
+           KEY_BACKSPACE,
+       KEY_L, KEY_K, KEY_I, KEY_SLASH, KEY_COMMA, KEY_O, KEY_9, KEY_DOT,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN=
, \
+           KEY_A,
+       0, KEY_RIGHTSHIFT, KEY_ENTER, 0, KEY_RIGHT, 0, 0, 0,
+
+       /* matrix keypad with NumLk key pressed... */
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3=
,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_KP4, KEY_KP7, KEY_KP0, KEY_KP1, KEY_KP=
8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y=
,
+       KEY_MINUS, KEY_KPSLASH, KEY_LEFT, KEY_KPMINUS, KEY_KPASTERISK, \
+           KEY_DOWN, KEY_UP, KEY_BACKSPACE,
+       KEY_KP3, KEY_KP2, KEY_KP5, KEY_SLASH, KEY_KPDOT, KEY_KP6, KEY_KP9, =
\
+           KEY_KPPLUS,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN=
, \
+           KEY_A,
+       0, KEY_RIGHTSHIFT, KEY_ENTER, 0, KEY_RIGHT, 0, 0, 0,
+
+       /* matrix keypad with Fn key pressed... */
+       0, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, 0, 0, 0, 0, 0, 0,
+       KEY_LEFTBRACE, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, 0, 0, 0, 0, 0, 0,
+       0, 0, KEY_HOME, 0, 0, KEY_PAGEDOWN, KEY_PAGEUP, 0,
+       0, 0, 0, KEY_RIGHTBRACE, KEY_LEFTBRACE, 0, 0, KEY_RIGHTBRACE,
+       0, 0, 0, KEY_LEFTSHIFT, 0, 0, KEY_FN, 0,
+       0, KEY_RIGHTSHIFT, 0, 0, KEY_END, 0, 0, 0,
+
+       /* direct volume/camera keys... */
+       KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_HALFSHUTTER, KEY_FULLSHUTTER,
+};
+
+struct mrst_keypad {
+       struct input_dev *input_dev;
+       void __iomem *mmio_base;
+
+       unsigned int    matrix_key_rows;
+       unsigned int    matrix_key_cols;
+       int             matrix_key_map_size;
+       int             direct_key_num;
+
+       /* key debounce interval */
+       unsigned int    debounce_interval;
+
+       unsigned int mrst_matrix[MAX_KEY_NUM];
+
+       /* matrix key code map */
+       unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
+       unsigned int matrix_keycodes_numlck[MAX_MATRIX_KEY_NUM];
+       unsigned int matrix_keycodes_fn[MAX_MATRIX_KEY_NUM];
+
+       /* direct key code map */
+       unsigned int direct_key_map[MAX_DIRECT_KEY_NUM];
+
+       /* state row bits of each column scan */
+       uint32_t matrix_key_state[MAX_MATRIX_KEY_COLS];
+       uint32_t direct_key_state;
+
+       unsigned int direct_key_mask;
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
+       bool fn;
+
+       /* Number Lock key */
+       bool numlck;
+
+       /* keycode look-up flag */
+       int flag;
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
+       memcpy(keypad->mrst_matrix, mrst_keycode,
+              sizeof(keypad->mrst_matrix));
+       memcpy(keypad->matrix_keycodes, &mrst_keycode[0],
+              sizeof(keypad->matrix_keycodes));
+       memcpy(keypad->matrix_keycodes_numlck,
+              &mrst_keycode[MAX_MATRIX_KEY_NUM],
+              sizeof(keypad->matrix_keycodes_numlck));
+       memcpy(keypad->matrix_keycodes_fn,
+              &mrst_keycode[MAX_MATRIX_KEY_NUM * 2],
+              sizeof(keypad->matrix_keycodes_fn));
+       memcpy(keypad->direct_key_map, &mrst_keycode[MAX_MATRIX_KEY_NUM * 3=
],
+              sizeof(keypad->direct_key_map));
+
+       key =3D &keypad->mrst_matrix[0];
+       for (i =3D 0; i < MAX_KEY_NUM; i++, key++) {
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
+               struct mrst_keypad *keypad, int row, int col, int flag)
+{
+       /* choose the correct keymap page... */
+       switch (flag) {
+       case 0:
+               return keypad->matrix_keycodes[(row << 3) + col];
+       case 1:
+               return keypad->matrix_keycodes_numlck[(row << 3) + col];
+       case 2:
+               return keypad->matrix_keycodes_fn[(row << 3) + col];
+       default:
+               /* this should never happen... */
+               return 0;
+       }
+}
+
+static void handle_sticky_keys(struct mrst_keypad *keypad,
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
+               /* release sticky keys (Fn combinations) */
+               input_report_key(dev, KEY_LEFTBRACE, 0);
+               input_report_key(dev, KEY_RIGHTBRACE, 0);
+               input_report_key(dev, KEY_RIGHTBRACE, 0);
+               input_report_key(dev, KEY_END, 0);
+               input_report_key(dev, KEY_RIGHTBRACE, 0);
+               input_report_key(dev, KEY_RIGHTBRACE, 0);
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
+               handle_sticky_keys(keypad, num_keys_pressed, 0, 0,
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
+                       keypad->flag =3D keypad->numlck =3D !keypad->numlck=
;
+
+               /* if Fn pressed */
+               if (col =3D=3D 6 && row =3D=3D 6)
+                       keypad->flag =3D 2;
+
+               handle_sticky_keys(keypad, num_keys_pressed, col, row,
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
+                       keypad->flag =3D 2;
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
+                               lookup_matrix_keycode(keypad, row, col,
+                                                     keypad->flag),
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
+#define        KEYPAD_MATRIX_GPIO_IN_PIN       24
+#define        KEYPAD_MATRIX_GPIO_OUT_PIN      32
+#define KEYPAD_DIRECT_GPIO_IN_PIN      40
+static int mrst_keypad_gpio_init(void)
+{
+       int i, err, cnt =3D 0;
+       int pins =3D KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
+           MAX_MATRIX_KEY_COLS + MAX_DIRECT_KEY_NUM;
+
+       for (i =3D KEYPAD_MATRIX_GPIO_IN_PIN; i < pins; i++, cnt++) {
+               err =3D gpio_request(i, NULL);
+               if (err) {
+                       printk(KERN_ERR "GPIO pin %d failed to request.\n",=
 i);
+                       goto err_request;
+               }
+       }
+
+       for (i =3D 0; i < MAX_MATRIX_KEY_ROWS; i++)
+               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
+
+       for (i =3D 0; i < MAX_MATRIX_KEY_COLS; i++)
+               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
+
+       for (i =3D 0; i < MAX_DIRECT_KEY_NUM; i++)
+               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
+
+       return 0;
+
+err_request:
+       /* free requested pins... */
+       for (i =3D KEYPAD_MATRIX_GPIO_IN_PIN + cnt - 1;
+            i >=3D KEYPAD_MATRIX_GPIO_IN_PIN; i--)
+               gpio_free(i);
+       return err;
+}
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
+       int err;
+
+       err =3D mrst_keypad_gpio_init();
+       if (err)
+               return err;
+       mrst_keypad_config(keypad);
+
+       return 0;
+}
+
+static void mrst_keypad_close(struct input_dev *dev)
+{
+}
+
+#ifdef CONFIG_PM
+static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+       return 0;
+}
+
+static int mrst_keypad_resume(struct pci_dev *pdev)
+{
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
+       input_dev->keycode =3D keypad->mrst_matrix;
+       input_dev->keycodesize =3D sizeof(keypad->mrst_matrix[0]);
+       input_dev->keycodemax =3D ARRAY_SIZE(keypad->mrst_matrix);
+
+       keypad->input_dev =3D input_dev;
+       keypad->fn =3D 0;
+       keypad->numlck =3D 0;
+       keypad->flag =3D 0;
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
+               DRV_NAME, keypad);
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
+       int i;
+       int pins =3D KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
+           MAX_MATRIX_KEY_COLS + MAX_DIRECT_KEY_NUM;
+
+       for (i =3D pins - 1; i > KEYPAD_MATRIX_GPIO_IN_PIN; i--)
+               gpio_free(i);
+
+       free_irq(pdev->irq, keypad);
+
+       input_unregister_device(keypad->input_dev);
+
+       iounmap(keypad->mmio_base);
+
+       pci_release_regions(pdev);
+       pci_set_drvdata(pdev, NULL);
+
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
+MODULE_AUTHOR("Zheng Ba <zheng.ba@intel.com>");
diff --git a/include/linux/input.h b/include/linux/input.h
index 8b3bc3e..7e178b5 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -543,6 +543,7 @@ struct input_absinfo {
 #define KEY_FRAMEFORWARD       0x1b5
 #define KEY_CONTEXT_MENU       0x1b6   /* GenDesc - system context menu */
 #define KEY_MEDIA_REPEAT       0x1b7   /* Consumer - transport control */
+#define KEY_CAMERA_FOCUS       0x1b8

 #define KEY_DEL_EOL            0x1c0
 #define KEY_DEL_EOS            0x1c1
--
1.6.0.6


-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
Sent: Friday, May 08, 2009 12:45 AM
To: Ba, Zheng
Cc: linux-input@vger.kernel.org
Subject: Re: FW: [PATCH 1/1] input: keypad controller driver for Intel low =
power Moorestown platform

Hi Zheng,

On Wed, May 06, 2009 at 12:00:35PM +0800, Ba, Zheng wrote:
> Hi Dmitry,
>
> It is Zheng Ba from Intel and I submitted below keypad driver patch
> last week but got no feedback from the community yet.  I just wanted
> to know if the patch was missing accidentally by you and please kindly
> take a look at this which will be of great help for us to integrate
> Moorestown platform based drivers to upstream Linux.
>

Umm... I usually look on the mailing list after I manage to clear my
INBOX :) so it takes me much longer to get there, sorry...

>
>           To compile this driver as a module, choose M here: the
>           module will be called sh_keysc.
> +
> +config KEYBOARD_MRST
> +       tristate "Moorestown keypad support"
> +       help
> +         Say Y if you want to use the moorestown keypad
> +         depends on GPIO_MOORESTOWN
> +

Can we have the customary "To compile this driver as a module...",
please?

Hmm, I wonder if somebody need to add MODULENAME to Kconfig and then
have tools print this line automatically for us.

> +
> +#define KEY_HALFSHUTTER                KEY_PROG1
> +#define KEY_FULLSHUTTER                KEY_CAMERA

We had discussion with Kim Kyuwon requesting the new key definition for
half-shutter. Please add KEY_CAMERA_FOCUS/0x1b8 to input.h and use it.

> +
> +static unsigned int mrst_keycode[MAX_MATRIX_KEY_NUM] =3D {
...
> +/* NumLk key mapping */
> +static unsigned int mrst_keycode_numlck[MAX_MATRIX_KEY_NUM] =3D {
...
> +/* Fn key mapping */
> +static unsigned int mrst_keycode_fn[MAX_MATRIX_KEY_NUM] =3D {
...
> +/* direct key map */
> +static unsigned int mrst_direct_keycode[MAX_DIRECT_KEY_NUM] =3D {
> +       KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_HALFSHUTTER, KEY_FULLSHUTTER,
> +};
> +

Having 4 separate key code maps will not allow changing them all form
userspace with EVIOCSKEYCODE... Why don't you combine them all together
(opne array split in 4 "pages")?

> +
> +       int rotary_rel_code[2];
> +       int rotary_up_key[2];
> +       int rotary_down_key[2];
> +
> +       /* Fn key */
> +       int fn;

bool?

> +
> +       /* Number Lock key */
> +       int numlck;

Here too?

> +
> +       /*FIXME IRQ count*/
> +       int count;
> +};
> +
> +static void mrst_keypad_build_keycode(struct mrst_keypad *keypad)
> +{
> +       struct input_dev *input_dev =3D keypad->input_dev;
> +       unsigned int *key;
> +       int i, code;
> +
> +       keypad->matrix_key_rows =3D MAX_MATRIX_KEY_ROWS;
> +       keypad->matrix_key_cols =3D MAX_MATRIX_KEY_COLS;
> +       keypad->matrix_key_map_size =3D MAX_MATRIX_KEY_NUM;
> +       keypad->debounce_interval =3D DEBOUNCE_INTERVAL;
> +
> +       /* three sets of keycode here */
> +       if (keypad->fn)
> +               memcpy(keypad->matrix_keycodes, mrst_keycode_fn, \

You don't need escaping newlines here...

> +                      sizeof(keypad->matrix_keycodes));
> +       else if (keypad->numlck)
> +               memcpy(keypad->matrix_keycodes, mrst_keycode_numlck, \
> +                      sizeof(keypad->matrix_keycodes));
> +       else
> +               memcpy(keypad->matrix_keycodes, mrst_keycode, \
> +                      sizeof(keypad->matrix_keycodes));
> +
> +       memcpy(keypad->direct_key_map, mrst_direct_keycode, \
> +              sizeof(keypad->direct_key_map));
> +
> +       key =3D &keypad->matrix_keycodes[0];
> +       for (i =3D 0; i < MAX_MATRIX_KEY_NUM; i++, key++) {
> +               code =3D (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       key =3D &keypad->direct_key_map[0];
> +       for (i =3D 0; i < MAX_DIRECT_KEY_NUM; i++, key++) {
> +               code =3D (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       keypad->direct_key_num =3D MAX_DIRECT_KEY_NUM;
> +       keypad->enable_rotary0 =3D 0;
> +       keypad->enable_rotary1 =3D 0;
> +
> +}
> +
> +static inline unsigned int lookup_matrix_keycode(
> +               struct mrst_keypad *keypad, int row, int col)
> +{
> +       return keypad->matrix_keycodes[(row << 3) + col];
> +}
> +
> +static void handle_constant_keypress(struct mrst_keypad *keypad,

'Constant'? as in 'persistent' ot 'sticky'?

> +                                    int num, int col, int row,
> +                                    uint32_t *old_state)
> +{
> +       struct input_dev *dev =3D keypad->input_dev;
> +       int state =3D old_state[col] & (1 << row);
> +
> +       switch (num) {
> +       case 0:
> +               if (keypad->fn)
> +                       keypad->fn =3D 0;
> +               /* Manually release special keys (Fn combinations) */
> +               if (!!test_bit(KEY_LEFTBRACE, dev->key))

Why double negation? Also, just release them, input core will not
propagate even if key is not pressed.

> +                       input_report_key(dev, KEY_LEFTBRACE, 0);
> +               if (!!test_bit(KEY_RIGHTBRACE, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_HOME, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_END, dev->key))
> +                       input_report_key(dev, KEY_END, 0);
> +               if (!!test_bit(KEY_PAGEUP, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +               if (!!test_bit(KEY_PAGEDOWN, dev->key))
> +                       input_report_key(dev, KEY_RIGHTBRACE, 0);
> +
> +               return;
> +
> +       case 1:
> +               /* if Fn pressed */
> +               if (col =3D=3D 6 && row =3D=3D 6)
> +                       keypad->fn =3D 1;
> +               /* key '[' */
> +               else if ((col =3D=3D 0 && row =3D=3D 2) && state) {
> +                       keypad->fn =3D 0;
> +                       set_bit(KEY_EQUAL, dev->key);
> +                       dev->repeat_key =3D KEY_EQUAL;

And what if I remapped the key?

> +               }
> +               /* key ']' */
> +               else if ((col =3D=3D 3 && row =3D=3D 5) && state) {
> +                       keypad->fn =3D 0;
> +                       set_bit(KEY_SLASH, dev->key);
> +                       dev->repeat_key =3D KEY_SLASH;
> +               }
> +               /* key '{' */
> +               else if ((col =3D=3D 4 && row =3D=3D 5) && state) {
> +                       keypad->fn =3D 0;
> +                       set_bit(KEY_COMMA, dev->key);
> +                       dev->repeat_key =3D KEY_COMMA;
> +               }
> +               /* key '}' */
> +               else if ((col =3D=3D 7 && row =3D=3D 5) && state) {
> +                       keypad->fn =3D 0;
> +                       set_bit(KEY_DOT, dev->key);
> +                       dev->repeat_key =3D KEY_DOT;
> +               }
> +
> +               return;
> +       default:
> +               ;
> +       }
> +}
> +
> +static void mrst_keypad_scan_matrix(struct mrst_keypad *keypad)
> +{
> +       int row, col, num_keys_pressed =3D 0;
> +       uint32_t new_state[MAX_MATRIX_KEY_COLS];
> +       uint32_t kpas =3D keypad_readl(KPAS);
> +
> +       num_keys_pressed =3D KPAS_MUKP(kpas);
> +
> +       memset(new_state, 0, sizeof(new_state));
> +
> +       if (num_keys_pressed =3D=3D 0) {
> +               handle_constant_keypress(keypad, num_keys_pressed, 0, 0,
> +                                        keypad->matrix_key_state);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed =3D=3D 1) {
> +               col =3D KPAS_CP(kpas);
> +               row =3D KPAS_RP(kpas);
> +
> +               /* if invalid row/col, treat as no key pressed */
> +               if (col >=3D keypad->matrix_key_cols ||
> +                   row >=3D keypad->matrix_key_rows)
> +                       goto scan;
> +
> +               /* if NumLk pressed */
> +               if (col =3D=3D 0 && row =3D=3D 1)
> +                       keypad->numlck =3D !keypad->numlck;
> +
> +               handle_constant_keypress(keypad, num_keys_pressed, col, r=
ow,
> +                                        keypad->matrix_key_state);
> +
> +               new_state[col] =3D (1 << row);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed > 1) {
> +               uint32_t kpasmkp0 =3D keypad_readl(KPASMKP0);
> +               uint32_t kpasmkp1 =3D keypad_readl(KPASMKP1);
> +               uint32_t kpasmkp2 =3D keypad_readl(KPASMKP2);
> +               uint32_t kpasmkp3 =3D keypad_readl(KPASMKP3);
> +
> +               new_state[0] =3D kpasmkp0 & KPASMKP_MKC_MASK;
> +               new_state[1] =3D (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[2] =3D kpasmkp1 & KPASMKP_MKC_MASK;
> +               new_state[3] =3D (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[4] =3D kpasmkp2 & KPASMKP_MKC_MASK;
> +               new_state[5] =3D (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[6] =3D kpasmkp3 & KPASMKP_MKC_MASK;
> +               new_state[7] =3D (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
> +
> +               /* if Fn is pressed, all SHIFT is ignored, except when {
> +                * or } is pressed */
> +               if (new_state[6] & 0x40) {
> +                       keypad->fn =3D 1;
> +                       new_state[3] &=3D ~0x40;
> +                       new_state[1] &=3D ~0x80;
> +               }
> +
> +               if (keypad->fn =3D=3D 1) {
> +                       /* if { or } pressed */
> +                       if ((new_state[4] & 0x20) || (new_state[7] & 0x20=
)) {
> +                               /* as if LEFTSHIFT is pressed */
> +                               new_state[3] |=3D 0x40;
> +                               /* as if Fn not pressed */
> +                               new_state[6] &=3D ~0x40;
> +                       }
> +                       /* if [ or ] pressed */
> +                       if ((new_state[0] & 0x04) || (new_state[3] & 0x20=
))
> +                               /* as if Fn not pressed */
> +                               new_state[6] &=3D ~0x40;
> +               }
> +       }
> +
> +
> +scan:
> +       /* re-build keycode */
> +       mrst_keypad_build_keycode(keypad);

No, let's not do it. Like I said, have single keymap and when you look
up the code selec the proper "page" there.

> +
> +       for (col =3D 0; col < keypad->matrix_key_cols; col++) {
> +               uint32_t bits_changed;
> +
> +               bits_changed =3D keypad->matrix_key_state[col] ^ new_stat=
e[col];
> +               if (bits_changed =3D=3D 0)
> +                       continue;
> +
> +               for (row =3D 0; row < keypad->matrix_key_rows; row++) {
> +                       if ((bits_changed & (1 << row)) =3D=3D 0)
> +                               continue;
> +
> +                       input_report_key(keypad->input_dev,
> +                               lookup_matrix_keycode(keypad, row, col),
> +                               new_state[col] & (1 << row));
> +               }
> +       }
> +       input_sync(keypad->input_dev);
> +       memcpy(keypad->matrix_key_state, new_state, sizeof(new_state));
> +}
> +
> +#define DEFAULT_KPREC  (0x007f007f)
> +
> +static inline int rotary_delta(uint32_t kprec)
> +{
> +       if (kprec & KPREC_OF0)
> +               return (kprec & 0xff) + 0x7f;
> +       else if (kprec & KPREC_UF0)
> +               return (kprec & 0xff) - 0x7f - 0xff;
> +       else
> +               return (kprec & 0xff) - 0x7f;
> +}
> +
> +static void report_rotary_event(struct mrst_keypad *keypad, int r, int d=
elta)
> +{
> +       struct input_dev *dev =3D keypad->input_dev;
> +
> +       if (delta =3D=3D 0)
> +               return;
> +
> +       if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
> +               int keycode =3D (delta > 0) ? keypad->rotary_up_key[r] :
> +                                           keypad->rotary_down_key[r];
> +
> +               /* simulate a press-n-release */
> +               input_report_key(dev, keycode, 1);
> +               input_sync(dev);
> +               input_report_key(dev, keycode, 0);
> +               input_sync(dev);
> +       } else {
> +               input_report_rel(dev, keypad->rotary_rel_code[r], delta);
> +               input_sync(dev);
> +       }
> +}
> +
> +static void mrst_keypad_scan_rotary(struct mrst_keypad *keypad)
> +{
> +       unsigned int kprec;
> +
> +       /* read and reset to default count value */
> +       kprec =3D keypad_readl(KPREC);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +
> +       if (keypad->enable_rotary0)
> +               report_rotary_event(keypad, 0, rotary_delta(kprec));
> +
> +       if (keypad->enable_rotary1)
> +               report_rotary_event(keypad, 1, rotary_delta(kprec >> 16))=
;
> +}
> +
> +static void mrst_keypad_scan_direct(struct mrst_keypad *keypad)
> +{
> +       unsigned int new_state;
> +       uint32_t kpdk, bits_changed;
> +       int i;
> +
> +       kpdk =3D keypad_readl(KPDK);
> +
> +       if (keypad->enable_rotary0 || keypad->enable_rotary1)
> +               mrst_keypad_scan_rotary(keypad);
> +
> +       if ((keypad->direct_key_map =3D=3D NULL) || (++keypad->count =3D=
=3D 1)) {
> +               keypad->direct_key_state =3D 0;
> +               return;
> +       }
> +
> +       new_state =3D KPDK_DK(kpdk) & keypad->direct_key_mask;
> +       new_state =3D ~new_state;
> +       bits_changed =3D keypad->direct_key_state ^ new_state;
> +
> +       if (bits_changed =3D=3D 0)
> +               return;
> +
> +       for (i =3D 0; i < keypad->direct_key_num; i++) {
> +               if (bits_changed & (1 << i)) {
> +                       input_report_key(keypad->input_dev,
> +                                        keypad->direct_key_map[i],
> +                                        (new_state & (1 << i)));
> +               }
> +       }
> +       input_sync(keypad->input_dev);
> +       keypad->direct_key_state =3D new_state;
> +
> +}
> +
> +static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
> +{
> +       struct mrst_keypad *keypad =3D dev_id;
> +       unsigned long kpc =3D keypad_readl(KPC);
> +
> +       if (kpc & KPC_DI)
> +               mrst_keypad_scan_direct(keypad);
> +
> +       if (kpc & KPC_MI)
> +               mrst_keypad_scan_matrix(keypad);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* temporily remove GPIO dependencies here... */
> +#if 0
> +#define        KEYPAD_MATRIX_GPIO_IN_PIN       24
> +#define        KEYPAD_MATRIX_GPIO_OUT_PIN      32
> +#define KEYPAD_DIRECT_GPIO_IN_PIN      40
> +static void mrst_keypad_gpio_init(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < MAX_MATRIX_KEY_ROWS; i++) {
> +               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_IN_PIN + i, 1);
> +       }
> +
> +       for (i =3D 0; i < MAX_MATRIX_KEY_COLS; i++) {
> +               /* __gpio_set_value(KEYPAD_GPIO_OUT_PIN + i, 1); */
> +               /* set action is executed in gpio_direction_output() */
> +               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +       }
> +
> +       for (i =3D 0; i < MAX_DIRECT_KEY_NUM; i++) {
> +               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_DIRECT_GPIO_IN_PIN + i, 1);
> +       }
> +}

If it is not needed/ready for mainline lets drop it.

> +#endif
> +
> +static void mrst_keypad_config(struct mrst_keypad *keypad)
> +{
> +       unsigned int mask =3D 0, direct_key_num =3D 0;
> +       unsigned long kpc =3D 0;
> +
> +       /* enable matrix keys with automatic scan */
> +       if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
> +               kpc |=3D KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
> +               kpc |=3D KPC_MKRN(keypad->matrix_key_rows) |
> +                      KPC_MKCN(keypad->matrix_key_cols);
> +       }
> +
> +       /* enable rotary key, debounce interval same as direct keys */
> +       if (keypad->enable_rotary0) {
> +               mask |=3D 0x03;
> +               direct_key_num =3D 2;
> +               kpc |=3D KPC_REE0;
> +       }
> +
> +       if (keypad->enable_rotary1) {
> +               mask |=3D 0x0c;
> +               direct_key_num =3D 4;
> +               kpc |=3D KPC_REE1;
> +       }
> +
> +       if (keypad->direct_key_num > direct_key_num)
> +               direct_key_num =3D keypad->direct_key_num;
> +
> +       keypad->direct_key_mask =3D ((2 << direct_key_num) - 1) & ~mask;
> +
> +       /* enable direct key */
> +       if (direct_key_num)
> +               kpc |=3D KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
> +
> +       keypad_writel(KPC, kpc);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +       keypad_writel(KPKDI, keypad->debounce_interval);
> +}
> +
> +static int mrst_keypad_open(struct input_dev *dev)
> +{
> +       struct mrst_keypad *keypad =3D input_get_drvdata(dev);
> +
> +       /* mrst_keypad_gpio_init(); */
> +       mrst_keypad_config(keypad);
> +
> +       return 0;
> +}
> +
> +static void mrst_keypad_close(struct input_dev *dev)
> +{
> +       struct mrst_keypad *keypad ;
> +       keypad =3D input_get_drvdata(dev);

And..?


> +}
> +
> +#ifdef CONFIG_PM
> +static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +       /* struct mrst_keypad *keypad =3D pci_get_drvdata(pdev); */
> +
> +       /* clk_disable(keypad->clk); */

If stopping clock is not needed why do you have this fucntion at all?

> +       return 0;
> +}
> +
> +static int mrst_keypad_resume(struct pci_dev *pdev)
> +{
> +       struct mrst_keypad *keypad =3D pci_get_drvdata(pdev);
> +       struct input_dev *input_dev =3D keypad->input_dev;
> +
> +       mutex_lock(&input_dev->mutex);
> +
> +       if (input_dev->users) {
> +               /* Enable unit clock */
> +               /* clk_enable(keypad->clk); */
> +               mrst_keypad_config(keypad);
> +       }
> +
> +       mutex_unlock(&input_dev->mutex);
> +
> +       return 0;
> +}
> +#else
> +#define mrst_keypad_suspend    NULL
> +#define mrst_keypad_resume     NULL
> +#endif
> +
> +
> +static int __devinit mrst_keypad_probe(struct pci_dev *pdev,
> +                       const struct pci_device_id *ent)
> +{
> +       struct mrst_keypad *keypad;
> +       struct input_dev *input_dev;
> +       int error;
> +
> +#ifndef MODULE
> +       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
> +#endif

Just drop it.

> +
> +       keypad =3D kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
> +       if (keypad =3D=3D NULL) {
> +               dev_err(&pdev->dev, "failed to allocate driver data\n");
> +               return -ENOMEM;
> +       }
> +
> +       error =3D pci_enable_device(pdev);
> +       if (error || (pdev->irq < 0)) {
> +               dev_err(&pdev->dev, "failed to enable device/get irq\n");
> +               error =3D -ENXIO;
> +               goto failed_free;
> +       }
> +
> +       error =3D pci_request_regions(pdev, DRV_NAME);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request I/O memory\n");
> +               goto failed_free;
> +       }
> +
> +       keypad->mmio_base =3D ioremap(pci_resource_start(pdev, 0), \
> +               pci_resource_len(pdev, 0));
> +       if (keypad->mmio_base =3D=3D NULL) {
> +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +               error =3D -ENXIO;
> +               goto failed_free_mem;
> +       }
> +
> +       /* Create and register the input driver. */
> +       input_dev =3D input_allocate_device();
> +       if (!input_dev) {
> +               dev_err(&pdev->dev, "failed to allocate input device\n");
> +               error =3D -ENOMEM;
> +               goto failed_free_io;
> +       }
> +
> +       input_dev->name =3D pci_name(pdev);
> +       input_dev->id.bustype =3D BUS_PCI;
> +       input_dev->open =3D mrst_keypad_open;
> +       input_dev->close =3D mrst_keypad_close;
> +       input_dev->dev.parent =3D &pdev->dev;
> +
> +       input_dev->keycode =3D keypad->matrix_keycodes;
> +       input_dev->keycodesize =3D sizeof(unsigned int);

sizeof(keypad->matrix_keycodes[0]) is safer.

> +       input_dev->keycodemax =3D ARRAY_SIZE(mrst_keycode);

ARRAY_SIZE(keypad->matrix_keycodes);

> +
> +       keypad->input_dev =3D input_dev;
> +       keypad->fn =3D 0;
> +       keypad->numlck =3D 0;
> +       /*FIXME*/keypad->count =3D 0;
> +       input_set_drvdata(input_dev, keypad);
> +
> +       input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +               BIT_MASK(EV_REL);
> +
> +       mrst_keypad_build_keycode(keypad);
> +       pci_set_drvdata(pdev, keypad);
> +
> +       error =3D request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SH=
ARED,
> +               pci_name(pdev), keypad);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request IRQ\n");
> +               goto failed_free_dev;
> +       }
> +
> +       /* Register the input device */
> +       error =3D input_register_device(input_dev);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to register input device\n");
> +               goto failed_free_irq;
> +       }
> +
> +       printk(KERN_INFO "*** keypad driver load successfully ***\n");

Drop it as weel, input core prints a message when a new device is
registered.

> +       return 0;
> +
> +failed_free_irq:
> +       free_irq(pdev->irq, keypad);
> +       pci_set_drvdata(pdev, NULL);
> +failed_free_dev:
> +       input_free_device(input_dev);
> +failed_free_io:
> +       iounmap(keypad->mmio_base);
> +failed_free_mem:
> +       pci_release_regions(pdev);
> +failed_free:
> +       kfree(keypad);
> +       return error;
> +}
> +
> +static void __devexit mrst_keypad_remove(struct pci_dev *pdev)
> +{
> +       struct mrst_keypad *keypad =3D pci_get_drvdata(pdev);
> +
> +       free_irq(pdev->irq, keypad);
> +       input_unregister_device(keypad->input_dev);
> +       iounmap(keypad->mmio_base);
> +       pci_release_regions(pdev);
> +       pci_set_drvdata(pdev, NULL);
> +       kfree(keypad);
> +}
> +
> +
> +static struct pci_driver mrst_keypad_driver =3D {
> +       .name           =3D DRV_NAME,
> +       .id_table       =3D keypad_pci_tbl,
> +       .probe          =3D mrst_keypad_probe,
> +       .remove         =3D __devexit_p(mrst_keypad_remove),
> +#ifdef CONFIG_PM
> +       .suspend        =3D mrst_keypad_suspend,
> +       .resume         =3D mrst_keypad_resume,
> +#endif /* CONFIG_PM */
> +};
> +
> +static int __init mrst_keypad_init(void)
> +{
> +#ifdef MODULE
> +       printk(KERN_INFO MRST_KEYPAD_DRIVER_NAME "\n");
> +#endif

Please just drop the message, boot is already noisy enough.

> +
> +       return pci_register_driver(&mrst_keypad_driver);
> +}
> +
> +static void __exit mrst_keypad_exit(void)
> +{
> +       pci_unregister_driver(&mrst_keypad_driver);
> +}
> +
> +module_init(mrst_keypad_init);
> +module_exit(mrst_keypad_exit);
> +
> +MODULE_DESCRIPTION("MRST Keypad Controller Driver");
> +MODULE_LICENSE("GPL v2");

MODULE_AUTHOR()?

I have not looked at the driver in much detail as I really want to see
how it will look like after combining the keymaps together. Please do
that and I will review it again. Thanks!

--
Dmitry

--_002_61563CE63B4F854986A895DA7AD3C17709DB43A5F9pdsmsx502ccrc_
Content-Type: application/octet-stream;
	name="Keypad-controller-driver-for-Intel-low-power-MRST.patch"
Content-Description: Keypad-controller-driver-for-Intel-low-power-MRST.patch
Content-Disposition: attachment;
	filename="Keypad-controller-driver-for-Intel-low-power-MRST.patch";
	size=24784; creation-date="Wed, 12 Aug 2009 15:47:46 GMT";
	modification-date="Wed, 12 Aug 2009 15:42:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyODViYTY1NjVhOTg1OThlMjRmNWNjYTczYzBhOGE0NjY5MGVhN2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuZyBCYSA8emhlbmcuYmFAaW50ZWwuY29tPgpEYXRlOiBX
ZWQsIDEyIEF1ZyAyMDA5IDE1OjM3OjE3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gS2V5cGFkIGNv
bnRyb2xsZXIgZHJpdmVyIGZvciBJbnRlbCBsb3cgcG93ZXIgTW9vcmVzdG93biBwbGF0Zm9ybQoK
VGhpcyBkcml2ZXIgaGFzIGR1YWwtc3VwcG9ydCBmb3IgdHdvIHN0eWxlcyBvZiBrZXlwYWRzOiBE
aXJlY3Qga2V5cGFkIGFuZApNYXRyaXgga2V5cGFkLiBUaGUgTWF0cml4IGtleXBhZCBpcyA4eDgg
YW5kIHdvcmtzIGxpa2UgYSBub3JtYWwga2V5Ym9hcmQgZXhlY3B0IGZvciBzb21lCmZ1bmN0aW9u
IGtleXMgKEZuKS4gVGhlIERpcmVjdCBrZXlwYWQgY29udGFpbnMgNCBkaXJlY3Qga2V5czogY2Ft
ZXJhIHNodXR0ZXJzCihoYWxmL2Z1bGwgcHJlc3NlcykgYW5kIHZvbHVtZSB1cC9kb3duIGJ1dHRv
bnMuCgphZGRlZDogZHJpdmVycy9pbnB1dC9tcnN0X2tleXBhZC5jCm1vZGlmaWVkOiBpbmNsdWRl
L2xpbnV4L2lucHV0LmgKCSAgZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnCgkgIGRyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUKClNpZ25lZC1vZmYtYnk6IFpoZW5nIEJhIDx6aGVu
Zy5iYUBpbnRlbC5jb20+Ci0tLQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnICAgICAg
IHwgICAgNyArCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlICAgICAgfCAgICAxICsK
IGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXJzdF9rZXlwYWQuYyB8ICA3ODUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9pbnB1dC5oICAgICAgICAgICAg
ICAgIHwgICAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDc5NCBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXJzdF9r
ZXlwYWQuYwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZyBiL2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZwppbmRleCBhNmI5ODlhLi5lNDliMTgyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKKysrIGIvZHJpdmVycy9pbnB1
dC9rZXlib2FyZC9LY29uZmlnCkBAIC0zNjEsNCArMzYxLDExIEBAIGNvbmZpZyBLRVlCT0FSRF9Y
VEtCRAogCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVy
ZTogdGhlCiAJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgeHRrYmQuCiAKK2NvbmZpZyBLRVlCT0FS
RF9NUlNUCisJdHJpc3RhdGUgIk1SU1Qga2V5cGFkIHN1cHBvcnQiCisJaGVscAorCSAgU2F5IFkg
aWYgeW91IHdhbnQgdG8gdXNlIHRoZSBtcnN0IGtleXBhZAorCisJICBUbyBjb21waWxlIHRoaXMg
ZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUKKwkgIG1vZHVsZSB3aWxsIGJl
IGNhbGxlZCBtcnN0X2tleXBhZC4KIGVuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL01ha2VmaWxlIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQppbmRleCBi
NWI1ZWFlLi5mNzg4MjU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2Vm
aWxlCisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUKQEAgLTIxLDYgKzIxLDcg
QEAgb2JqLSQoQ09ORklHX0tFWUJPQVJEX0xNODMyMykJCSs9IGxtODMyMy5vCiBvYmotJChDT05G
SUdfS0VZQk9BUkRfTE9DT01PKQkJKz0gbG9jb21va2JkLm8KIG9iai0kKENPTkZJR19LRVlCT0FS
RF9NQVBMRSkJCSs9IG1hcGxlX2tleWIubwogb2JqLSQoQ09ORklHX0tFWUJPQVJEX01BVFJJWCkJ
CSs9IG1hdHJpeF9rZXlwYWQubworb2JqLSQoQ09ORklHX0tFWUJPQVJEX01SU1QpCQkrPSBtcnN0
X2tleXBhZC5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfTkVXVE9OKQkJKz0gbmV3dG9ua2JkLm8K
IG9iai0kKENPTkZJR19LRVlCT0FSRF9PTUFQKQkJKz0gb21hcC1rZXlwYWQubwogb2JqLSQoQ09O
RklHX0tFWUJPQVJEX1BYQTI3eCkJCSs9IHB4YTI3eF9rZXlwYWQubwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9tcnN0X2tleXBhZC5jIGIvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9tcnN0X2tleXBhZC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjQwYjk5
NGYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL21yc3Rfa2V5cGFk
LmMKQEAgLTAsMCArMSw3ODUgQEAKKy8qCisgKiBsaW51eC9kcml2ZXJzL2lucHV0L2tleWJvYXJk
L21yc3Rfa2V5cGFkLmMKKyAqCisgKiBEcml2ZXIgZm9yIHRoZSBtYXRyaXgga2V5cGFkIGNvbnRy
b2xsZXIgb24gTW9vcmVzdG93biBwbGF0Zm9ybS4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMDkg
SW50ZWwgQ29ycG9yYXRpb24uCisgKiBDcmVhdGVkOglTZXAgMTgsIDIwMDgKKyAqIFVwZGF0ZWQ6
CUF1ZyAxMiwgMjAwOQorICoKKyAqIEJhc2VkIG9uIHB4YTI3eF9rZXlwYWQuYyBieSBSb2RvbGZv
IEdpb21ldHRpIDxnaW9tZXR0aUBsaW51eC5pdD4KKyAqIHB4YTI3eF9rZXlwYWQuYyBpcyBiYXNl
ZCBvbiBhIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIGJ5IEtldmluIE8nQ29ubm9yCisgKiA8a2V2
aW5fYXRfa2Vjb25ub3IubmV0PiBhbmQgQWxleCBPc2Jvcm5lIDxib2JvZmRvb21AZ21haWwuY29t
PiBhbmQKKyAqIG9uIHNvbWUgc3VnZ2VzdGlvbnMgYnkgTmljb2xhcyBQaXRyZSA8bmljb0BjYW0u
b3JnPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1bmRlciB0aGUgdGVybXMgYW5kIGNvbmRp
dGlvbnMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLAorICogdmVyc2lvbiAyLCBh
cyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlz
IHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1
dCBXSVRIT1VUCisgKiBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJy
YW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgb3IKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQ
VVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAqIG1vcmUg
ZGV0YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgKiB0aGlzIHByb2dyYW07IGlm
IG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyAqIDUx
IEZyYW5rbGluIFN0IC0gRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCisg
KgorICovCisKKyNkZWZpbmUgRFJWX05BTUUJIm1yc3Rfa2V5cGFkIgorI2RlZmluZSBEUlZfVkVS
U0lPTgkiMC4wLjEiCisjZGVmaW5lIE1SU1RfS0VZUEFEX0RSSVZFUl9OQU1FICAgRFJWX05BTUUg
IiAiIERSVl9WRVJTSU9OCisKKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxsaW51eC9p
bml0Lmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvaW5w
dXQuaD4KKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4K
KyNpbmNsdWRlIDxsaW51eC9ncGlvLmg+CisKKy8qCisgKiBLZXlwYWQgQ29udHJvbGxlciByZWdp
c3RlcnMKKyAqLworI2RlZmluZSBLUEMgICAgICAgICAgICAgMHgwMDAwIC8qIEtleXBhZCBDb250
cm9sIHJlZ2lzdGVyICovCisjZGVmaW5lIEtQREsgICAgICAgICAgICAweDAwMDQgLyogS2V5cGFk
IERpcmVjdCBLZXkgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BSRUMgICAgICAgICAgIDB4MDAwOCAv
KiBLZXlwYWQgUm90YXJ5IEVuY29kZXIgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgS1BNSyAgICAgICAg
ICAgIDB4MDAwQyAvKiBLZXlwYWQgTWF0cml4IEtleSByZWdpc3RlciAqLworI2RlZmluZSBLUEFT
ICAgICAgICAgICAgMHgwMDEwIC8qIEtleXBhZCBBdXRvbWF0aWMgU2NhbiByZWdpc3RlciAqLwor
CisvKiBLZXlwYWQgQXV0b21hdGljIFNjYW4gTXVsdGlwbGUgS2V5IFByZXNzZXIgcmVnaXN0ZXIg
MC0zICovCisjZGVmaW5lIEtQQVNNS1AwICAgICAgICAweDAwMTQKKyNkZWZpbmUgS1BBU01LUDEg
ICAgICAgIDB4MDAxOAorI2RlZmluZSBLUEFTTUtQMiAgICAgICAgMHgwMDFDCisjZGVmaW5lIEtQ
QVNNS1AzICAgICAgICAweDAwMjAKKyNkZWZpbmUgS1BLREkgICAgICAgICAgIDB4MDAyNAorCisv
KiBiaXQgZGVmaW5pdGlvbnMgKi8KKyNkZWZpbmUgS1BDX01LUk4obikJKCgoKG4pIC0gMSkgJiAw
eDcpIDw8IDI2KSAvKiBtYXRyaXgga2V5IHJvdyBudW1iZXIgKi8KKyNkZWZpbmUgS1BDX01LQ04o
bikJKCgoKG4pIC0gMSkgJiAweDcpIDw8IDIzKSAvKiBtYXRyaXgga2V5IGNvbCBudW1iZXIgKi8K
KyNkZWZpbmUgS1BDX0RLTihuKQkoKCgobikgLSAxKSAmIDB4NykgPDwgNikgIC8qIGRpcmVjdCBr
ZXkgbnVtYmVyICovCisKKyNkZWZpbmUgS1BDX0FTICAgICAgICAgICgweDEgPDwgMzApICAvKiBB
dXRvbWF0aWMgU2NhbiBiaXQgKi8KKyNkZWZpbmUgS1BDX0FTQUNUICAgICAgICgweDEgPDwgMjkp
ICAvKiBBdXRvbWF0aWMgU2NhbiBvbiBBY3Rpdml0eSAqLworI2RlZmluZSBLUENfTUkgICAgICAg
ICAgKDB4MSA8PCAyMikgIC8qIE1hdHJpeCBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5lIEtQQ19J
TUtQICAgICAgICAoMHgxIDw8IDIxKSAgLyogSWdub3JlIE11bHRpcGxlIEtleSBQcmVzcyAqLwor
CisjZGVmaW5lIEtQQ19NUyhuKQkoMHgxIDw8ICgxMyArIChuKSkpCS8qIE1hdHJpeCBzY2FuIGxp
bmUgJ24nICovCisjZGVmaW5lIEtQQ19NU19BTEwgICAgICAoMHhmZiA8PCAxMykKKworI2RlZmlu
ZSBLUENfTUUgICAgICAgICAgKDB4MSA8PCAxMikgIC8qIE1hdHJpeCBLZXlwYWQgRW5hYmxlICov
CisjZGVmaW5lIEtQQ19NSUUgICAgICAgICAoMHgxIDw8IDExKSAgLyogTWF0cml4IEludGVycnVw
dCBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX0RLX0RFQl9TRUwJKDB4MSA8PCAgOSkgIC8qIERpcmVj
dCBLZXlwYWQgRGVib3VuY2UgU2VsZWN0ICovCisjZGVmaW5lIEtQQ19ESSAgICAgICAgICAoMHgx
IDw8ICA1KSAgLyogRGlyZWN0IGtleSBpbnRlcnJ1cHQgYml0ICovCisjZGVmaW5lIEtQQ19SRV9a
RVJPX0RFQiAoMHgxIDw8ICA0KSAgLyogUm90YXJ5IEVuY29kZXIgWmVybyBEZWJvdW5jZSAqLwor
I2RlZmluZSBLUENfUkVFMSAgICAgICAgKDB4MSA8PCAgMykgIC8qIFJvdGFyeSBFbmNvZGVyMSBF
bmFibGUgKi8KKyNkZWZpbmUgS1BDX1JFRTAgICAgICAgICgweDEgPDwgIDIpICAvKiBSb3Rhcnkg
RW5jb2RlcjAgRW5hYmxlICovCisjZGVmaW5lIEtQQ19ERSAgICAgICAgICAoMHgxIDw8ICAxKSAg
LyogRGlyZWN0IEtleXBhZCBFbmFibGUgKi8KKyNkZWZpbmUgS1BDX0RJRSAgICAgICAgICgweDEg
PDwgIDApICAvKiBEaXJlY3QgS2V5cGFkIGludGVycnVwdCBFbmFibGUgKi8KKworI2RlZmluZSBL
UERLX0RLUCAgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUgS1BES19ESyhuKQkoKG4pICYgMHhm
ZikKKworI2RlZmluZSBLUFJFQ19PRjEgICAgICAgKDB4MSA8PCAzMSkKKyNkZWZpbmUga1BSRUNf
VUYxICAgICAgICgweDEgPDwgMzApCisjZGVmaW5lIEtQUkVDX09GMCAgICAgICAoMHgxIDw8IDE1
KQorI2RlZmluZSBLUFJFQ19VRjAgICAgICAgKDB4MSA8PCAxNCkKKworI2RlZmluZSBLUFJFQ19S
RUNPVU5UMChuKQkoKG4pICYgMHhmZikKKyNkZWZpbmUgS1BSRUNfUkVDT1VOVDEobikJKCgobikg
Pj4gMTYpICYgMHhmZikKKworI2RlZmluZSBLUE1LX01LUCAgICAgICAgKDB4MSA8PCAzMSkKKyNk
ZWZpbmUgS1BBU19TTyAgICAgICAgICgweDEgPDwgMzEpCisjZGVmaW5lIEtQQVNNS1B4X1NPICAg
ICAoMHgxIDw8IDMxKQorCisjZGVmaW5lIEtQQVNfTVVLUChuKQkoKChuKSA+PiAyNikgJiAweDFm
KQorI2RlZmluZSBLUEFTX1JQKG4pCSgoKG4pID4+IDQpICYgMHhmKQorI2RlZmluZSBLUEFTX0NQ
KG4pCSgobikgJiAweGYpCisKKyNkZWZpbmUgS1BBU01LUF9NS0NfTUFTSwkoMHhmZikKKworCitz
dGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQga2V5cGFkX3BjaV90YmxbXSA9IHsKKwl7MHg4MDg2
LCAweDA4MDUsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDAgfSwKKwl7MCx9Cit9Owor
TU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGtleXBhZF9wY2lfdGJsKTsKKworI2RlZmluZSBrZXlw
YWRfcmVhZGwob2ZmKQlyZWFkbChrZXlwYWQtPm1taW9fYmFzZSArIChvZmYpKQorI2RlZmluZSBr
ZXlwYWRfd3JpdGVsKG9mZiwgdikJd3JpdGVsKCh2KSwga2V5cGFkLT5tbWlvX2Jhc2UgKyAob2Zm
KSkKKworI2RlZmluZSBNQVhfTUFUUklYX0tFWV9OVU0JKDggKiA4KQorI2RlZmluZSBNQVhfRElS
RUNUX0tFWV9OVU0JKDQpCisjZGVmaW5lIE1BWF9LRVlfTlVNCQkoTUFYX01BVFJJWF9LRVlfTlVN
KjMgKyBNQVhfRElSRUNUX0tFWV9OVU0pCisKKyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfUk9XUwko
OCkKKyNkZWZpbmUgTUFYX01BVFJJWF9LRVlfQ09MUwkoOCkKKyNkZWZpbmUgREVCT1VOQ0VfSU5U
RVJWQUwJMTAwCisKKyNkZWZpbmUgS0VZX0hBTEZTSFVUVEVSCQlLRVlfQ0FNRVJBX0ZPQ1VTCisj
ZGVmaW5lIEtFWV9GVUxMU0hVVFRFUgkJS0VZX0NBTUVSQQorCitzdGF0aWMgdW5zaWduZWQgaW50
IG1yc3Rfa2V5Y29kZVtNQVhfS0VZX05VTV0gPSB7CisJLyogbWF0cml4IGtleXBhZCAqLworCUtF
WV9GLCBLRVlfRCwgS0VZX0UsIEtFWV9HUkFWRSwgS0VZX0MsIEtFWV9SLCBLRVlfNCwgS0VZX1Ys
CisJS0VZX05VTUxPQ0ssIEtFWV9MRUZUQ1RSTCwgS0VZX1osIEtFWV9XLCBLRVlfMiwgS0VZX1gs
IEtFWV9TLCBLRVlfMywKKwlLRVlfRVFVQUwsIEtFWV9OLCBLRVlfSCwgS0VZX1UsIEtFWV83LCBL
RVlfTSwgS0VZX0osIEtFWV84LAorCUtFWV82LCBLRVlfNSwgS0VZX0FQT1NUUk9QSEUsIEtFWV9H
LCBLRVlfVCwgS0VZX1NQQUNFLCBLRVlfQiwgS0VZX1ksCisJS0VZX01JTlVTLCBLRVlfMCwgS0VZ
X0xFRlQsIEtFWV9TRU1JQ09MT04sIEtFWV9QLCBLRVlfRE9XTiwgS0VZX1VQLFwKKwkgICAgS0VZ
X0JBQ0tTUEFDRSwKKwlLRVlfTCwgS0VZX0ssIEtFWV9JLCBLRVlfU0xBU0gsIEtFWV9DT01NQSwg
S0VZX08sIEtFWV85LCBLRVlfRE9ULAorCUtFWV9RLCBLRVlfVEFCLCBLRVlfRVNDLCBLRVlfTEVG
VFNISUZULCBLRVlfQ0FQU0xPQ0ssIEtFWV8xLCBLRVlfRk4sIFwKKwkgICAgS0VZX0EsCisJMCwg
S0VZX1JJR0hUU0hJRlQsIEtFWV9FTlRFUiwgMCwgS0VZX1JJR0hULCAwLCAwLCAwLAorCisJLyog
bWF0cml4IGtleXBhZCB3aXRoIE51bUxrIGtleSBwcmVzc2VkLi4uICovCisJS0VZX0YsIEtFWV9E
LCBLRVlfRSwgS0VZX0dSQVZFLCBLRVlfQywgS0VZX1IsIEtFWV80LCBLRVlfViwKKwlLRVlfTlVN
TE9DSywgS0VZX0xFRlRDVFJMLCBLRVlfWiwgS0VZX1csIEtFWV8yLCBLRVlfWCwgS0VZX1MsIEtF
WV8zLAorCUtFWV9FUVVBTCwgS0VZX04sIEtFWV9ILCBLRVlfS1A0LCBLRVlfS1A3LCBLRVlfS1Aw
LCBLRVlfS1AxLCBLRVlfS1A4LAorCUtFWV82LCBLRVlfNSwgS0VZX0FQT1NUUk9QSEUsIEtFWV9H
LCBLRVlfVCwgS0VZX1NQQUNFLCBLRVlfQiwgS0VZX1ksCisJS0VZX01JTlVTLCBLRVlfS1BTTEFT
SCwgS0VZX0xFRlQsIEtFWV9LUE1JTlVTLCBLRVlfS1BBU1RFUklTSywgXAorCSAgICBLRVlfRE9X
TiwgS0VZX1VQLCBLRVlfQkFDS1NQQUNFLAorCUtFWV9LUDMsIEtFWV9LUDIsIEtFWV9LUDUsIEtF
WV9TTEFTSCwgS0VZX0tQRE9ULCBLRVlfS1A2LCBLRVlfS1A5LCBcCisJICAgIEtFWV9LUFBMVVMs
CisJS0VZX1EsIEtFWV9UQUIsIEtFWV9FU0MsIEtFWV9MRUZUU0hJRlQsIEtFWV9DQVBTTE9DSywg
S0VZXzEsIEtFWV9GTiwgXAorCSAgICBLRVlfQSwKKwkwLCBLRVlfUklHSFRTSElGVCwgS0VZX0VO
VEVSLCAwLCBLRVlfUklHSFQsIDAsIDAsIDAsCisKKwkvKiBtYXRyaXgga2V5cGFkIHdpdGggRm4g
a2V5IHByZXNzZWQuLi4gKi8KKwkwLCAwLCAwLCAwLCAwLCAwLCAwLCAwLAorCTAsIDAsIDAsIDAs
IDAsIDAsIDAsIDAsCisJS0VZX0xFRlRCUkFDRSwgMCwgMCwgMCwgMCwgMCwgMCwgMCwKKwkwLCAw
LCAwLCAwLCAwLCAwLCAwLCAwLAorCTAsIDAsIEtFWV9IT01FLCAwLCAwLCBLRVlfUEFHRURPV04s
IEtFWV9QQUdFVVAsIDAsCisJMCwgMCwgMCwgS0VZX1JJR0hUQlJBQ0UsIEtFWV9MRUZUQlJBQ0Us
IDAsIDAsIEtFWV9SSUdIVEJSQUNFLAorCTAsIDAsIDAsIEtFWV9MRUZUU0hJRlQsIDAsIDAsIEtF
WV9GTiwgMCwKKwkwLCBLRVlfUklHSFRTSElGVCwgMCwgMCwgS0VZX0VORCwgMCwgMCwgMCwKKwor
CS8qIGRpcmVjdCB2b2x1bWUvY2FtZXJhIGtleXMuLi4gKi8KKwlLRVlfVk9MVU1FVVAsIEtFWV9W
T0xVTUVET1dOLCBLRVlfSEFMRlNIVVRURVIsIEtFWV9GVUxMU0hVVFRFUiwKK307CisKK3N0cnVj
dCBtcnN0X2tleXBhZCB7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXRfZGV2OworCXZvaWQgX19p
b21lbSAqbW1pb19iYXNlOworCisJdW5zaWduZWQgaW50CW1hdHJpeF9rZXlfcm93czsKKwl1bnNp
Z25lZCBpbnQJbWF0cml4X2tleV9jb2xzOworCWludAkJbWF0cml4X2tleV9tYXBfc2l6ZTsKKwlp
bnQJCWRpcmVjdF9rZXlfbnVtOworCisJLyoga2V5IGRlYm91bmNlIGludGVydmFsICovCisJdW5z
aWduZWQgaW50CWRlYm91bmNlX2ludGVydmFsOworCisJdW5zaWduZWQgaW50IG1yc3RfbWF0cml4
W01BWF9LRVlfTlVNXTsKKworCS8qIG1hdHJpeCBrZXkgY29kZSBtYXAgKi8KKwl1bnNpZ25lZCBp
bnQgbWF0cml4X2tleWNvZGVzW01BWF9NQVRSSVhfS0VZX05VTV07CisJdW5zaWduZWQgaW50IG1h
dHJpeF9rZXljb2Rlc19udW1sY2tbTUFYX01BVFJJWF9LRVlfTlVNXTsKKwl1bnNpZ25lZCBpbnQg
bWF0cml4X2tleWNvZGVzX2ZuW01BWF9NQVRSSVhfS0VZX05VTV07CisKKwkvKiBkaXJlY3Qga2V5
IGNvZGUgbWFwICovCisJdW5zaWduZWQgaW50IGRpcmVjdF9rZXlfbWFwW01BWF9ESVJFQ1RfS0VZ
X05VTV07CisKKwkvKiBzdGF0ZSByb3cgYml0cyBvZiBlYWNoIGNvbHVtbiBzY2FuICovCisJdWlu
dDMyX3QgbWF0cml4X2tleV9zdGF0ZVtNQVhfTUFUUklYX0tFWV9DT0xTXTsKKwl1aW50MzJfdCBk
aXJlY3Rfa2V5X3N0YXRlOworCisJdW5zaWduZWQgaW50IGRpcmVjdF9rZXlfbWFzazsKKworCS8q
IHJvdGFyeSBlbmNvZGVycyAwICovCisJaW50IGVuYWJsZV9yb3RhcnkwOworCWludCByb3Rhcnkw
X3JlbF9jb2RlOworCWludCByb3RhcnkwX3VwX2tleTsKKwlpbnQgcm90YXJ5MF9kb3duX2tleTsK
KworCS8qIHJvdGFyeSBlbmNvZGVycyAxICovCisJaW50IGVuYWJsZV9yb3RhcnkxOworCWludCBy
b3RhcnkxX3JlbF9jb2RlOworCWludCByb3RhcnkxX3VwX2tleTsKKwlpbnQgcm90YXJ5MV9kb3du
X2tleTsKKworCWludCByb3RhcnlfcmVsX2NvZGVbMl07CisJaW50IHJvdGFyeV91cF9rZXlbMl07
CisJaW50IHJvdGFyeV9kb3duX2tleVsyXTsKKworCS8qIEZuIGtleSAqLworCWJvb2wgZm47CisK
KwkvKiBOdW1iZXIgTG9jayBrZXkgKi8KKwlib29sIG51bWxjazsKKworCS8qIGtleWNvZGUgbG9v
ay11cCBmbGFnICovCisJaW50IGZsYWc7CisKKwkvKkZJWE1FIElSUSBjb3VudCovCisJaW50IGNv
dW50OworfTsKKworc3RhdGljIHZvaWQgbXJzdF9rZXlwYWRfYnVpbGRfa2V5Y29kZShzdHJ1Y3Qg
bXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXYgPSBr
ZXlwYWQtPmlucHV0X2RldjsKKwl1bnNpZ25lZCBpbnQgKmtleTsKKwlpbnQgaSwgY29kZTsKKwor
CWtleXBhZC0+bWF0cml4X2tleV9yb3dzID0gTUFYX01BVFJJWF9LRVlfUk9XUzsKKwlrZXlwYWQt
Pm1hdHJpeF9rZXlfY29scyA9IE1BWF9NQVRSSVhfS0VZX0NPTFM7CisJa2V5cGFkLT5tYXRyaXhf
a2V5X21hcF9zaXplID0gTUFYX01BVFJJWF9LRVlfTlVNOworCWtleXBhZC0+ZGVib3VuY2VfaW50
ZXJ2YWwgPSBERUJPVU5DRV9JTlRFUlZBTDsKKworCW1lbWNweShrZXlwYWQtPm1yc3RfbWF0cml4
LCBtcnN0X2tleWNvZGUsCisJICAgICAgIHNpemVvZihrZXlwYWQtPm1yc3RfbWF0cml4KSk7CisJ
bWVtY3B5KGtleXBhZC0+bWF0cml4X2tleWNvZGVzLCAmbXJzdF9rZXljb2RlWzBdLAorCSAgICAg
ICBzaXplb2Yoa2V5cGFkLT5tYXRyaXhfa2V5Y29kZXMpKTsKKwltZW1jcHkoa2V5cGFkLT5tYXRy
aXhfa2V5Y29kZXNfbnVtbGNrLAorCSAgICAgICAmbXJzdF9rZXljb2RlW01BWF9NQVRSSVhfS0VZ
X05VTV0sCisJICAgICAgIHNpemVvZihrZXlwYWQtPm1hdHJpeF9rZXljb2Rlc19udW1sY2spKTsK
KwltZW1jcHkoa2V5cGFkLT5tYXRyaXhfa2V5Y29kZXNfZm4sCisJICAgICAgICZtcnN0X2tleWNv
ZGVbTUFYX01BVFJJWF9LRVlfTlVNICogMl0sCisJICAgICAgIHNpemVvZihrZXlwYWQtPm1hdHJp
eF9rZXljb2Rlc19mbikpOworCW1lbWNweShrZXlwYWQtPmRpcmVjdF9rZXlfbWFwLCAmbXJzdF9r
ZXljb2RlW01BWF9NQVRSSVhfS0VZX05VTSAqIDNdLAorCSAgICAgICBzaXplb2Yoa2V5cGFkLT5k
aXJlY3Rfa2V5X21hcCkpOworCisJa2V5ID0gJmtleXBhZC0+bXJzdF9tYXRyaXhbMF07CisJZm9y
IChpID0gMDsgaSA8IE1BWF9LRVlfTlVNOyBpKyssIGtleSsrKSB7CisJCWNvZGUgPSAoKmtleSkg
JiAweGZmZmZmZjsKKwkJc2V0X2JpdChjb2RlLCBpbnB1dF9kZXYtPmtleWJpdCk7CisJfQorCisJ
a2V5cGFkLT5kaXJlY3Rfa2V5X251bSA9IE1BWF9ESVJFQ1RfS0VZX05VTTsKKwlrZXlwYWQtPmVu
YWJsZV9yb3RhcnkwID0gMDsKKwlrZXlwYWQtPmVuYWJsZV9yb3RhcnkxID0gMDsKKworfQorCitz
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBsb29rdXBfbWF0cml4X2tleWNvZGUoCisJCXN0cnVj
dCBtcnN0X2tleXBhZCAqa2V5cGFkLCBpbnQgcm93LCBpbnQgY29sLCBpbnQgZmxhZykKK3sKKwkv
KiBjaG9vc2UgdGhlIGNvcnJlY3Qga2V5bWFwIHBhZ2UuLi4gKi8KKwlzd2l0Y2ggKGZsYWcpIHsK
KwljYXNlIDA6CisJCXJldHVybiBrZXlwYWQtPm1hdHJpeF9rZXljb2Rlc1socm93IDw8IDMpICsg
Y29sXTsKKwljYXNlIDE6CisJCXJldHVybiBrZXlwYWQtPm1hdHJpeF9rZXljb2Rlc19udW1sY2tb
KHJvdyA8PCAzKSArIGNvbF07CisJY2FzZSAyOgorCQlyZXR1cm4ga2V5cGFkLT5tYXRyaXhfa2V5
Y29kZXNfZm5bKHJvdyA8PCAzKSArIGNvbF07CisJZGVmYXVsdDoKKwkJLyogdGhpcyBzaG91bGQg
bmV2ZXIgaGFwcGVuLi4uICovCisJCXJldHVybiAwOworCX0KK30KKworc3RhdGljIHZvaWQgaGFu
ZGxlX3N0aWNreV9rZXlzKHN0cnVjdCBtcnN0X2tleXBhZCAqa2V5cGFkLAorCQkJCSAgICAgaW50
IG51bSwgaW50IGNvbCwgaW50IHJvdywKKwkJCQkgICAgIHVpbnQzMl90ICpvbGRfc3RhdGUpCit7
CisJc3RydWN0IGlucHV0X2RldiAqZGV2ID0ga2V5cGFkLT5pbnB1dF9kZXY7CisJaW50IHN0YXRl
ID0gb2xkX3N0YXRlW2NvbF0gJiAoMSA8PCByb3cpOworCisJc3dpdGNoIChudW0pIHsKKwljYXNl
IDA6CisJCWlmIChrZXlwYWQtPmZuKQorCQkJa2V5cGFkLT5mbiA9IDA7CisJCS8qIHJlbGVhc2Ug
c3RpY2t5IGtleXMgKEZuIGNvbWJpbmF0aW9ucykgKi8KKwkJaW5wdXRfcmVwb3J0X2tleShkZXYs
IEtFWV9MRUZUQlJBQ0UsIDApOworCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwgS0VZX1JJR0hUQlJB
Q0UsIDApOworCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwgS0VZX1JJR0hUQlJBQ0UsIDApOworCQlp
bnB1dF9yZXBvcnRfa2V5KGRldiwgS0VZX0VORCwgMCk7CisJCWlucHV0X3JlcG9ydF9rZXkoZGV2
LCBLRVlfUklHSFRCUkFDRSwgMCk7CisJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBLRVlfUklHSFRC
UkFDRSwgMCk7CisKKwkJcmV0dXJuOworCisJY2FzZSAxOgorCQkvKiBpZiBGbiBwcmVzc2VkICov
CisJCWlmIChjb2wgPT0gNiAmJiByb3cgPT0gNikKKwkJCWtleXBhZC0+Zm4gPSAxOworCQkvKiBr
ZXkgJ1snICovCisJCWVsc2UgaWYgKChjb2wgPT0gMCAmJiByb3cgPT0gMikgJiYgc3RhdGUpIHsK
KwkJCWtleXBhZC0+Zm4gPSAwOworCQkJc2V0X2JpdChLRVlfRVFVQUwsIGRldi0+a2V5KTsKKwkJ
CWRldi0+cmVwZWF0X2tleSA9IEtFWV9FUVVBTDsKKwkJfQorCQkvKiBrZXkgJ10nICovCisJCWVs
c2UgaWYgKChjb2wgPT0gMyAmJiByb3cgPT0gNSkgJiYgc3RhdGUpIHsKKwkJCWtleXBhZC0+Zm4g
PSAwOworCQkJc2V0X2JpdChLRVlfU0xBU0gsIGRldi0+a2V5KTsKKwkJCWRldi0+cmVwZWF0X2tl
eSA9IEtFWV9TTEFTSDsKKwkJfQorCQkvKiBrZXkgJ3snICovCisJCWVsc2UgaWYgKChjb2wgPT0g
NCAmJiByb3cgPT0gNSkgJiYgc3RhdGUpIHsKKwkJCWtleXBhZC0+Zm4gPSAwOworCQkJc2V0X2Jp
dChLRVlfQ09NTUEsIGRldi0+a2V5KTsKKwkJCWRldi0+cmVwZWF0X2tleSA9IEtFWV9DT01NQTsK
KwkJfQorCQkvKiBrZXkgJ30nICovCisJCWVsc2UgaWYgKChjb2wgPT0gNyAmJiByb3cgPT0gNSkg
JiYgc3RhdGUpIHsKKwkJCWtleXBhZC0+Zm4gPSAwOworCQkJc2V0X2JpdChLRVlfRE9ULCBkZXYt
PmtleSk7CisJCQlkZXYtPnJlcGVhdF9rZXkgPSBLRVlfRE9UOworCQl9CisKKwkJcmV0dXJuOwor
CWRlZmF1bHQ6CisJCTsKKwl9Cit9CisKK3N0YXRpYyB2b2lkIG1yc3Rfa2V5cGFkX3NjYW5fbWF0
cml4KHN0cnVjdCBtcnN0X2tleXBhZCAqa2V5cGFkKQoreworCWludCByb3csIGNvbCwgbnVtX2tl
eXNfcHJlc3NlZCA9IDA7CisJdWludDMyX3QgbmV3X3N0YXRlW01BWF9NQVRSSVhfS0VZX0NPTFNd
OworCXVpbnQzMl90IGtwYXMgPSBrZXlwYWRfcmVhZGwoS1BBUyk7CisKKwludW1fa2V5c19wcmVz
c2VkID0gS1BBU19NVUtQKGtwYXMpOworCisJbWVtc2V0KG5ld19zdGF0ZSwgMCwgc2l6ZW9mKG5l
d19zdGF0ZSkpOworCisJaWYgKG51bV9rZXlzX3ByZXNzZWQgPT0gMCkgeworCQloYW5kbGVfc3Rp
Y2t5X2tleXMoa2V5cGFkLCBudW1fa2V5c19wcmVzc2VkLCAwLCAwLAorCQkJCQkga2V5cGFkLT5t
YXRyaXhfa2V5X3N0YXRlKTsKKworCQlnb3RvIHNjYW47CisJfQorCisJaWYgKG51bV9rZXlzX3By
ZXNzZWQgPT0gMSkgeworCQljb2wgPSBLUEFTX0NQKGtwYXMpOworCQlyb3cgPSBLUEFTX1JQKGtw
YXMpOworCisJCS8qIGlmIGludmFsaWQgcm93L2NvbCwgdHJlYXQgYXMgbm8ga2V5IHByZXNzZWQg
Ki8KKwkJaWYgKGNvbCA+PSBrZXlwYWQtPm1hdHJpeF9rZXlfY29scyB8fAorCQkgICAgcm93ID49
IGtleXBhZC0+bWF0cml4X2tleV9yb3dzKQorCQkJZ290byBzY2FuOworCisJCS8qIGlmIE51bUxr
IHByZXNzZWQgKi8KKwkJaWYgKGNvbCA9PSAwICYmIHJvdyA9PSAxKQorCQkJa2V5cGFkLT5mbGFn
ID0ga2V5cGFkLT5udW1sY2sgPSAha2V5cGFkLT5udW1sY2s7CisKKwkJLyogaWYgRm4gcHJlc3Nl
ZCAqLworCQlpZiAoY29sID09IDYgJiYgcm93ID09IDYpCisJCQlrZXlwYWQtPmZsYWcgPSAyOwor
CisJCWhhbmRsZV9zdGlja3lfa2V5cyhrZXlwYWQsIG51bV9rZXlzX3ByZXNzZWQsIGNvbCwgcm93
LAorCQkJCQkga2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlKTsKKworCQluZXdfc3RhdGVbY29sXSA9
ICgxIDw8IHJvdyk7CisKKwkJZ290byBzY2FuOworCX0KKworCWlmIChudW1fa2V5c19wcmVzc2Vk
ID4gMSkgeworCQl1aW50MzJfdCBrcGFzbWtwMCA9IGtleXBhZF9yZWFkbChLUEFTTUtQMCk7CisJ
CXVpbnQzMl90IGtwYXNta3AxID0ga2V5cGFkX3JlYWRsKEtQQVNNS1AxKTsKKwkJdWludDMyX3Qg
a3Bhc21rcDIgPSBrZXlwYWRfcmVhZGwoS1BBU01LUDIpOworCQl1aW50MzJfdCBrcGFzbWtwMyA9
IGtleXBhZF9yZWFkbChLUEFTTUtQMyk7CisKKwkJbmV3X3N0YXRlWzBdID0ga3Bhc21rcDAgJiBL
UEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbMV0gPSAoa3Bhc21rcDAgPj4gMTYpICYgS1BB
U01LUF9NS0NfTUFTSzsKKwkJbmV3X3N0YXRlWzJdID0ga3Bhc21rcDEgJiBLUEFTTUtQX01LQ19N
QVNLOworCQluZXdfc3RhdGVbM10gPSAoa3Bhc21rcDEgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFT
SzsKKwkJbmV3X3N0YXRlWzRdID0ga3Bhc21rcDIgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdf
c3RhdGVbNV0gPSAoa3Bhc21rcDIgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKwkJbmV3X3N0
YXRlWzZdID0ga3Bhc21rcDMgJiBLUEFTTUtQX01LQ19NQVNLOworCQluZXdfc3RhdGVbN10gPSAo
a3Bhc21rcDMgPj4gMTYpICYgS1BBU01LUF9NS0NfTUFTSzsKKworCQkvKiBpZiBGbiBpcyBwcmVz
c2VkLCBhbGwgU0hJRlQgaXMgaWdub3JlZCwgZXhjZXB0IHdoZW4geworCQkgKiBvciB9IGlzIHBy
ZXNzZWQgKi8KKwkJaWYgKG5ld19zdGF0ZVs2XSAmIDB4NDApIHsKKwkJCWtleXBhZC0+Zm4gPSAx
OworCQkJa2V5cGFkLT5mbGFnID0gMjsKKwkJCW5ld19zdGF0ZVszXSAmPSB+MHg0MDsKKwkJCW5l
d19zdGF0ZVsxXSAmPSB+MHg4MDsKKwkJfQorCisJCWlmIChrZXlwYWQtPmZuID09IDEpIHsKKwkJ
CS8qIGlmIHsgb3IgfSBwcmVzc2VkICovCisJCQlpZiAoKG5ld19zdGF0ZVs0XSAmIDB4MjApIHx8
IChuZXdfc3RhdGVbN10gJiAweDIwKSkgeworCQkJCS8qIGFzIGlmIExFRlRTSElGVCBpcyBwcmVz
c2VkICovCisJCQkJbmV3X3N0YXRlWzNdIHw9IDB4NDA7CisJCQkJLyogYXMgaWYgRm4gbm90IHBy
ZXNzZWQgKi8KKwkJCQluZXdfc3RhdGVbNl0gJj0gfjB4NDA7CisJCQl9CisJCQkvKiBpZiBbIG9y
IF0gcHJlc3NlZCAqLworCQkJaWYgKChuZXdfc3RhdGVbMF0gJiAweDA0KSB8fCAobmV3X3N0YXRl
WzNdICYgMHgyMCkpCisJCQkJLyogYXMgaWYgRm4gbm90IHByZXNzZWQgKi8KKwkJCQluZXdfc3Rh
dGVbNl0gJj0gfjB4NDA7CisJCX0KKwl9CisKKworc2NhbjoKKwlmb3IgKGNvbCA9IDA7IGNvbCA8
IGtleXBhZC0+bWF0cml4X2tleV9jb2xzOyBjb2wrKykgeworCQl1aW50MzJfdCBiaXRzX2NoYW5n
ZWQ7CisKKwkJYml0c19jaGFuZ2VkID0ga2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlW2NvbF0gXiBu
ZXdfc3RhdGVbY29sXTsKKwkJaWYgKGJpdHNfY2hhbmdlZCA9PSAwKQorCQkJY29udGludWU7CisK
KwkJZm9yIChyb3cgPSAwOyByb3cgPCBrZXlwYWQtPm1hdHJpeF9rZXlfcm93czsgcm93KyspIHsK
KwkJCWlmICgoYml0c19jaGFuZ2VkICYgKDEgPDwgcm93KSkgPT0gMCkKKwkJCQljb250aW51ZTsK
KworCQkJaW5wdXRfcmVwb3J0X2tleShrZXlwYWQtPmlucHV0X2RldiwKKwkJCQlsb29rdXBfbWF0
cml4X2tleWNvZGUoa2V5cGFkLCByb3csIGNvbCwKKwkJCQkJCSAgICAgIGtleXBhZC0+ZmxhZyks
CisJCQkJbmV3X3N0YXRlW2NvbF0gJiAoMSA8PCByb3cpKTsKKwkJfQorCX0KKwlpbnB1dF9zeW5j
KGtleXBhZC0+aW5wdXRfZGV2KTsKKwltZW1jcHkoa2V5cGFkLT5tYXRyaXhfa2V5X3N0YXRlLCBu
ZXdfc3RhdGUsIHNpemVvZihuZXdfc3RhdGUpKTsKK30KKworI2RlZmluZSBERUZBVUxUX0tQUkVD
CSgweDAwN2YwMDdmKQorCitzdGF0aWMgaW5saW5lIGludCByb3RhcnlfZGVsdGEodWludDMyX3Qg
a3ByZWMpCit7CisJaWYgKGtwcmVjICYgS1BSRUNfT0YwKQorCQlyZXR1cm4gKGtwcmVjICYgMHhm
ZikgKyAweDdmOworCWVsc2UgaWYgKGtwcmVjICYgS1BSRUNfVUYwKQorCQlyZXR1cm4gKGtwcmVj
ICYgMHhmZikgLSAweDdmIC0gMHhmZjsKKwllbHNlCisJCXJldHVybiAoa3ByZWMgJiAweGZmKSAt
IDB4N2Y7Cit9CisKK3N0YXRpYyB2b2lkIHJlcG9ydF9yb3RhcnlfZXZlbnQoc3RydWN0IG1yc3Rf
a2V5cGFkICprZXlwYWQsIGludCByLCBpbnQgZGVsdGEpCit7CisJc3RydWN0IGlucHV0X2RldiAq
ZGV2ID0ga2V5cGFkLT5pbnB1dF9kZXY7CisKKwlpZiAoZGVsdGEgPT0gMCkKKwkJcmV0dXJuOwor
CisJaWYgKGtleXBhZC0+cm90YXJ5X3VwX2tleVtyXSAmJiBrZXlwYWQtPnJvdGFyeV9kb3duX2tl
eVtyXSkgeworCQlpbnQga2V5Y29kZSA9IChkZWx0YSA+IDApID8ga2V5cGFkLT5yb3RhcnlfdXBf
a2V5W3JdIDoKKwkJCQkJICAgIGtleXBhZC0+cm90YXJ5X2Rvd25fa2V5W3JdOworCisJCS8qIHNp
bXVsYXRlIGEgcHJlc3Mtbi1yZWxlYXNlICovCisJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBrZXlj
b2RlLCAxKTsKKwkJaW5wdXRfc3luYyhkZXYpOworCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwga2V5
Y29kZSwgMCk7CisJCWlucHV0X3N5bmMoZGV2KTsKKwl9IGVsc2UgeworCQlpbnB1dF9yZXBvcnRf
cmVsKGRldiwga2V5cGFkLT5yb3RhcnlfcmVsX2NvZGVbcl0sIGRlbHRhKTsKKwkJaW5wdXRfc3lu
YyhkZXYpOworCX0KK30KKworc3RhdGljIHZvaWQgbXJzdF9rZXlwYWRfc2Nhbl9yb3Rhcnkoc3Ry
dWN0IG1yc3Rfa2V5cGFkICprZXlwYWQpCit7CisJdW5zaWduZWQgaW50IGtwcmVjOworCisJLyog
cmVhZCBhbmQgcmVzZXQgdG8gZGVmYXVsdCBjb3VudCB2YWx1ZSAqLworCWtwcmVjID0ga2V5cGFk
X3JlYWRsKEtQUkVDKTsKKwlrZXlwYWRfd3JpdGVsKEtQUkVDLCBERUZBVUxUX0tQUkVDKTsKKwor
CWlmIChrZXlwYWQtPmVuYWJsZV9yb3RhcnkwKQorCQlyZXBvcnRfcm90YXJ5X2V2ZW50KGtleXBh
ZCwgMCwgcm90YXJ5X2RlbHRhKGtwcmVjKSk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5
MSkKKwkJcmVwb3J0X3JvdGFyeV9ldmVudChrZXlwYWQsIDEsIHJvdGFyeV9kZWx0YShrcHJlYyA+
PiAxNikpOworfQorCitzdGF0aWMgdm9pZCBtcnN0X2tleXBhZF9zY2FuX2RpcmVjdChzdHJ1Y3Qg
bXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwl1bnNpZ25lZCBpbnQgbmV3X3N0YXRlOworCXVpbnQz
Ml90IGtwZGssIGJpdHNfY2hhbmdlZDsKKwlpbnQgaTsKKworCWtwZGsgPSBrZXlwYWRfcmVhZGwo
S1BESyk7CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5MCB8fCBrZXlwYWQtPmVuYWJsZV9y
b3RhcnkxKQorCQltcnN0X2tleXBhZF9zY2FuX3JvdGFyeShrZXlwYWQpOworCisJaWYgKChrZXlw
YWQtPmRpcmVjdF9rZXlfbWFwID09IE5VTEwpIHx8ICgrK2tleXBhZC0+Y291bnQgPT0gMSkpIHsK
KwkJa2V5cGFkLT5kaXJlY3Rfa2V5X3N0YXRlID0gMDsKKwkJcmV0dXJuOworCX0KKworCW5ld19z
dGF0ZSA9IEtQREtfREsoa3BkaykgJiBrZXlwYWQtPmRpcmVjdF9rZXlfbWFzazsKKwluZXdfc3Rh
dGUgPSB+bmV3X3N0YXRlOworCWJpdHNfY2hhbmdlZCA9IGtleXBhZC0+ZGlyZWN0X2tleV9zdGF0
ZSBeIG5ld19zdGF0ZTsKKworCWlmIChiaXRzX2NoYW5nZWQgPT0gMCkKKwkJcmV0dXJuOworCisJ
Zm9yIChpID0gMDsgaSA8IGtleXBhZC0+ZGlyZWN0X2tleV9udW07IGkrKykgeworCQlpZiAoYml0
c19jaGFuZ2VkICYgKDEgPDwgaSkpIHsKKwkJCWlucHV0X3JlcG9ydF9rZXkoa2V5cGFkLT5pbnB1
dF9kZXYsCisJCQkJCSBrZXlwYWQtPmRpcmVjdF9rZXlfbWFwW2ldLAorCQkJCQkgKG5ld19zdGF0
ZSAmICgxIDw8IGkpKSk7CisJCX0KKwl9CisJaW5wdXRfc3luYyhrZXlwYWQtPmlucHV0X2Rldik7
CisJa2V5cGFkLT5kaXJlY3Rfa2V5X3N0YXRlID0gbmV3X3N0YXRlOworCit9CisKK3N0YXRpYyBp
cnFyZXR1cm5fdCBtcnN0X2tleXBhZF9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZfaWQp
Cit7CisJc3RydWN0IG1yc3Rfa2V5cGFkICprZXlwYWQgPSBkZXZfaWQ7CisJdW5zaWduZWQgbG9u
ZyBrcGMgPSBrZXlwYWRfcmVhZGwoS1BDKTsKKworCWlmIChrcGMgJiBLUENfREkpCisJCW1yc3Rf
a2V5cGFkX3NjYW5fZGlyZWN0KGtleXBhZCk7CisKKwlpZiAoa3BjICYgS1BDX01JKQorCQltcnN0
X2tleXBhZF9zY2FuX21hdHJpeChrZXlwYWQpOworCisJcmV0dXJuIElSUV9IQU5ETEVEOworfQor
CisjZGVmaW5lCUtFWVBBRF9NQVRSSVhfR1BJT19JTl9QSU4JMjQKKyNkZWZpbmUJS0VZUEFEX01B
VFJJWF9HUElPX09VVF9QSU4JMzIKKyNkZWZpbmUgS0VZUEFEX0RJUkVDVF9HUElPX0lOX1BJTgk0
MAorc3RhdGljIGludCBtcnN0X2tleXBhZF9ncGlvX2luaXQodm9pZCkKK3sKKwlpbnQgaSwgZXJy
LCBjbnQgPSAwOworCWludCBwaW5zID0gS0VZUEFEX01BVFJJWF9HUElPX0lOX1BJTiArIE1BWF9N
QVRSSVhfS0VZX1JPV1MgKworCSAgICBNQVhfTUFUUklYX0tFWV9DT0xTICsgTUFYX0RJUkVDVF9L
RVlfTlVNOworCisJZm9yIChpID0gS0VZUEFEX01BVFJJWF9HUElPX0lOX1BJTjsgaSA8IHBpbnM7
IGkrKywgY250KyspIHsKKwkJZXJyID0gZ3Bpb19yZXF1ZXN0KGksIE5VTEwpOworCQlpZiAoZXJy
KSB7CisJCQlwcmludGsoS0VSTl9FUlIgIkdQSU8gcGluICVkIGZhaWxlZCB0byByZXF1ZXN0Llxu
IiwgaSk7CisJCQlnb3RvIGVycl9yZXF1ZXN0OworCQl9CisJfQorCisJZm9yIChpID0gMDsgaSA8
IE1BWF9NQVRSSVhfS0VZX1JPV1M7IGkrKykKKwkJZ3Bpb19kaXJlY3Rpb25faW5wdXQoS0VZUEFE
X01BVFJJWF9HUElPX0lOX1BJTiArIGkpOworCisJZm9yIChpID0gMDsgaSA8IE1BWF9NQVRSSVhf
S0VZX0NPTFM7IGkrKykKKwkJZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KEtFWVBBRF9NQVRSSVhfR1BJ
T19PVVRfUElOICsgaSwgMSk7CisKKwlmb3IgKGkgPSAwOyBpIDwgTUFYX0RJUkVDVF9LRVlfTlVN
OyBpKyspCisJCWdwaW9fZGlyZWN0aW9uX2lucHV0KEtFWVBBRF9ESVJFQ1RfR1BJT19JTl9QSU4g
KyBpKTsKKworCXJldHVybiAwOworCitlcnJfcmVxdWVzdDoKKwkvKiBmcmVlIHJlcXVlc3RlZCBw
aW5zLi4uICovCisJZm9yIChpID0gS0VZUEFEX01BVFJJWF9HUElPX0lOX1BJTiArIGNudCAtIDE7
CisJICAgICBpID49IEtFWVBBRF9NQVRSSVhfR1BJT19JTl9QSU47IGktLSkKKwkJZ3Bpb19mcmVl
KGkpOworCXJldHVybiBlcnI7Cit9CisKK3N0YXRpYyB2b2lkIG1yc3Rfa2V5cGFkX2NvbmZpZyhz
dHJ1Y3QgbXJzdF9rZXlwYWQgKmtleXBhZCkKK3sKKwl1bnNpZ25lZCBpbnQgbWFzayA9IDAsIGRp
cmVjdF9rZXlfbnVtID0gMDsKKwl1bnNpZ25lZCBsb25nIGtwYyA9IDA7CisKKwkvKiBlbmFibGUg
bWF0cml4IGtleXMgd2l0aCBhdXRvbWF0aWMgc2NhbiAqLworCWlmIChrZXlwYWQtPm1hdHJpeF9r
ZXlfcm93cyAmJiBrZXlwYWQtPm1hdHJpeF9rZXlfY29scykgeworCQlrcGMgfD0gS1BDX0FTQUNU
IHwgS1BDX01JRSB8IEtQQ19NRSB8IEtQQ19NU19BTEw7CisJCWtwYyB8PSBLUENfTUtSTihrZXlw
YWQtPm1hdHJpeF9rZXlfcm93cykgfAorCQkgICAgICAgS1BDX01LQ04oa2V5cGFkLT5tYXRyaXhf
a2V5X2NvbHMpOworCX0KKworCS8qIGVuYWJsZSByb3Rhcnkga2V5LCBkZWJvdW5jZSBpbnRlcnZh
bCBzYW1lIGFzIGRpcmVjdCBrZXlzICovCisJaWYgKGtleXBhZC0+ZW5hYmxlX3JvdGFyeTApIHsK
KwkJbWFzayB8PSAweDAzOworCQlkaXJlY3Rfa2V5X251bSA9IDI7CisJCWtwYyB8PSBLUENfUkVF
MDsKKwl9CisKKwlpZiAoa2V5cGFkLT5lbmFibGVfcm90YXJ5MSkgeworCQltYXNrIHw9IDB4MGM7
CisJCWRpcmVjdF9rZXlfbnVtID0gNDsKKwkJa3BjIHw9IEtQQ19SRUUxOworCX0KKworCWlmIChr
ZXlwYWQtPmRpcmVjdF9rZXlfbnVtID4gZGlyZWN0X2tleV9udW0pCisJCWRpcmVjdF9rZXlfbnVt
ID0ga2V5cGFkLT5kaXJlY3Rfa2V5X251bTsKKworCWtleXBhZC0+ZGlyZWN0X2tleV9tYXNrID0g
KCgyIDw8IGRpcmVjdF9rZXlfbnVtKSAtIDEpICYgfm1hc2s7CisKKwkvKiBlbmFibGUgZGlyZWN0
IGtleSAqLworCWlmIChkaXJlY3Rfa2V5X251bSkKKwkJa3BjIHw9IEtQQ19ERSB8IEtQQ19ESUUg
fCBLUENfREtOKGRpcmVjdF9rZXlfbnVtKTsKKworCWtleXBhZF93cml0ZWwoS1BDLCBrcGMpOwor
CWtleXBhZF93cml0ZWwoS1BSRUMsIERFRkFVTFRfS1BSRUMpOworCWtleXBhZF93cml0ZWwoS1BL
REksIGtleXBhZC0+ZGVib3VuY2VfaW50ZXJ2YWwpOworfQorCitzdGF0aWMgaW50IG1yc3Rfa2V5
cGFkX29wZW4oc3RydWN0IGlucHV0X2RldiAqZGV2KQoreworCXN0cnVjdCBtcnN0X2tleXBhZCAq
a2V5cGFkID0gaW5wdXRfZ2V0X2RydmRhdGEoZGV2KTsKKwlpbnQgZXJyOworCisJZXJyID0gbXJz
dF9rZXlwYWRfZ3Bpb19pbml0KCk7CisJaWYgKGVycikKKwkJcmV0dXJuIGVycjsKKwltcnN0X2tl
eXBhZF9jb25maWcoa2V5cGFkKTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBtcnN0
X2tleXBhZF9jbG9zZShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpCit7Cit9CisKKyNpZmRlZiBDT05G
SUdfUE0KK3N0YXRpYyBpbnQgbXJzdF9rZXlwYWRfc3VzcGVuZChzdHJ1Y3QgcGNpX2RldiAqcGRl
diwgcG1fbWVzc2FnZV90IHN0YXRlKQoreworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IG1y
c3Rfa2V5cGFkX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKK3sKKwlyZXR1cm4gMDsKK30K
KyNlbHNlCisjZGVmaW5lIG1yc3Rfa2V5cGFkX3N1c3BlbmQJTlVMTAorI2RlZmluZSBtcnN0X2tl
eXBhZF9yZXN1bWUJTlVMTAorI2VuZGlmCisKKworc3RhdGljIGludCBfX2RldmluaXQgbXJzdF9r
ZXlwYWRfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCisJCQljb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCAqZW50KQoreworCXN0cnVjdCBtcnN0X2tleXBhZCAqa2V5cGFkOworCXN0cnVjdCBp
bnB1dF9kZXYgKmlucHV0X2RldjsKKwlpbnQgZXJyb3I7CisKKwlrZXlwYWQgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgbXJzdF9rZXlwYWQpLCBHRlBfS0VSTkVMKTsKKwlpZiAoa2V5cGFkID09IE5V
TEwpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIGRyaXZlciBk
YXRhXG4iKTsKKwkJcmV0dXJuIC1FTk9NRU07CisJfQorCisJZXJyb3IgPSBwY2lfZW5hYmxlX2Rl
dmljZShwZGV2KTsKKwlpZiAoZXJyb3IgfHwgKHBkZXYtPmlycSA8IDApKSB7CisJCWRldl9lcnIo
JnBkZXYtPmRldiwgImZhaWxlZCB0byBlbmFibGUgZGV2aWNlL2dldCBpcnFcbiIpOworCQllcnJv
ciA9IC1FTlhJTzsKKwkJZ290byBmYWlsZWRfZnJlZTsKKwl9CisKKwllcnJvciA9IHBjaV9yZXF1
ZXN0X3JlZ2lvbnMocGRldiwgRFJWX05BTUUpOworCWlmIChlcnJvcikgeworCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBJL08gbWVtb3J5XG4iKTsKKwkJZ290byBmYWls
ZWRfZnJlZTsKKwl9CisKKwlrZXlwYWQtPm1taW9fYmFzZSA9IGlvcmVtYXAocGNpX3Jlc291cmNl
X3N0YXJ0KHBkZXYsIDApLCBcCisJCXBjaV9yZXNvdXJjZV9sZW4ocGRldiwgMCkpOworCWlmIChr
ZXlwYWQtPm1taW9fYmFzZSA9PSBOVUxMKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxl
ZCB0byByZW1hcCBJL08gbWVtb3J5XG4iKTsKKwkJZXJyb3IgPSAtRU5YSU87CisJCWdvdG8gZmFp
bGVkX2ZyZWVfbWVtOworCX0KKworCS8qIENyZWF0ZSBhbmQgcmVnaXN0ZXIgdGhlIGlucHV0IGRy
aXZlci4gKi8KKwlpbnB1dF9kZXYgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKwlpZiAoIWlu
cHV0X2RldikgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gYWxsb2NhdGUgaW5w
dXQgZGV2aWNlXG4iKTsKKwkJZXJyb3IgPSAtRU5PTUVNOworCQlnb3RvIGZhaWxlZF9mcmVlX2lv
OworCX0KKworCWlucHV0X2Rldi0+bmFtZSA9IHBjaV9uYW1lKHBkZXYpOworCWlucHV0X2Rldi0+
aWQuYnVzdHlwZSA9IEJVU19QQ0k7CisJaW5wdXRfZGV2LT5vcGVuID0gbXJzdF9rZXlwYWRfb3Bl
bjsKKwlpbnB1dF9kZXYtPmNsb3NlID0gbXJzdF9rZXlwYWRfY2xvc2U7CisJaW5wdXRfZGV2LT5k
ZXYucGFyZW50ID0gJnBkZXYtPmRldjsKKworCWlucHV0X2Rldi0+a2V5Y29kZSA9IGtleXBhZC0+
bXJzdF9tYXRyaXg7CisJaW5wdXRfZGV2LT5rZXljb2Rlc2l6ZSA9IHNpemVvZihrZXlwYWQtPm1y
c3RfbWF0cml4WzBdKTsKKwlpbnB1dF9kZXYtPmtleWNvZGVtYXggPSBBUlJBWV9TSVpFKGtleXBh
ZC0+bXJzdF9tYXRyaXgpOworCisJa2V5cGFkLT5pbnB1dF9kZXYgPSBpbnB1dF9kZXY7CisJa2V5
cGFkLT5mbiA9IDA7CisJa2V5cGFkLT5udW1sY2sgPSAwOworCWtleXBhZC0+ZmxhZyA9IDA7CisJ
LypGSVhNRSova2V5cGFkLT5jb3VudCA9IDA7CisJaW5wdXRfc2V0X2RydmRhdGEoaW5wdXRfZGV2
LCBrZXlwYWQpOworCisJaW5wdXRfZGV2LT5ldmJpdFswXSA9IEJJVF9NQVNLKEVWX0tFWSkgfCBC
SVRfTUFTSyhFVl9SRVApIHwKKwkJQklUX01BU0soRVZfUkVMKTsKKworCW1yc3Rfa2V5cGFkX2J1
aWxkX2tleWNvZGUoa2V5cGFkKTsKKwlwY2lfc2V0X2RydmRhdGEocGRldiwga2V5cGFkKTsKKwor
CWVycm9yID0gcmVxdWVzdF9pcnEocGRldi0+aXJxLCBtcnN0X2tleXBhZF9pcnFfaGFuZGxlciwg
SVJRRl9TSEFSRUQsCisJCURSVl9OQU1FLCBrZXlwYWQpOworCWlmIChlcnJvcikgeworCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBJUlFcbiIpOworCQlnb3RvIGZhaWxl
ZF9mcmVlX2RldjsKKwl9CisKKwkvKiBSZWdpc3RlciB0aGUgaW5wdXQgZGV2aWNlICovCisJZXJy
b3IgPSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2UoaW5wdXRfZGV2KTsKKwlpZiAoZXJyb3IpIHsKKwkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGlucHV0IGRldmljZVxuIik7
CisJCWdvdG8gZmFpbGVkX2ZyZWVfaXJxOworCX0KKworCXJldHVybiAwOworCitmYWlsZWRfZnJl
ZV9pcnE6CisJZnJlZV9pcnEocGRldi0+aXJxLCBrZXlwYWQpOworCXBjaV9zZXRfZHJ2ZGF0YShw
ZGV2LCBOVUxMKTsKK2ZhaWxlZF9mcmVlX2RldjoKKwlpbnB1dF9mcmVlX2RldmljZShpbnB1dF9k
ZXYpOworZmFpbGVkX2ZyZWVfaW86CisJaW91bm1hcChrZXlwYWQtPm1taW9fYmFzZSk7CitmYWls
ZWRfZnJlZV9tZW06CisJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsKK2ZhaWxlZF9mcmVlOgor
CWtmcmVlKGtleXBhZCk7CisJcmV0dXJuIGVycm9yOworfQorCitzdGF0aWMgdm9pZCBfX2RldmV4
aXQgbXJzdF9rZXlwYWRfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworCXN0cnVjdCBt
cnN0X2tleXBhZCAqa2V5cGFkID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOworCWludCBpOworCWlu
dCBwaW5zID0gS0VZUEFEX01BVFJJWF9HUElPX0lOX1BJTiArIE1BWF9NQVRSSVhfS0VZX1JPV1Mg
KworCSAgICBNQVhfTUFUUklYX0tFWV9DT0xTICsgTUFYX0RJUkVDVF9LRVlfTlVNOworCisJZm9y
IChpID0gcGlucyAtIDE7IGkgPiBLRVlQQURfTUFUUklYX0dQSU9fSU5fUElOOyBpLS0pCisJCWdw
aW9fZnJlZShpKTsKKworCWZyZWVfaXJxKHBkZXYtPmlycSwga2V5cGFkKTsKKworCWlucHV0X3Vu
cmVnaXN0ZXJfZGV2aWNlKGtleXBhZC0+aW5wdXRfZGV2KTsKKworCWlvdW5tYXAoa2V5cGFkLT5t
bWlvX2Jhc2UpOworCisJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsKKwlwY2lfc2V0X2RydmRh
dGEocGRldiwgTlVMTCk7CisKKwlrZnJlZShrZXlwYWQpOworfQorCisKK3N0YXRpYyBzdHJ1Y3Qg
cGNpX2RyaXZlciBtcnN0X2tleXBhZF9kcml2ZXIgPSB7CisJLm5hbWUJCT0gRFJWX05BTUUsCisJ
LmlkX3RhYmxlCT0ga2V5cGFkX3BjaV90YmwsCisJLnByb2JlCQk9IG1yc3Rfa2V5cGFkX3Byb2Jl
LAorCS5yZW1vdmUJCT0gX19kZXZleGl0X3AobXJzdF9rZXlwYWRfcmVtb3ZlKSwKKyNpZmRlZiBD
T05GSUdfUE0KKwkuc3VzcGVuZAk9IG1yc3Rfa2V5cGFkX3N1c3BlbmQsCisJLnJlc3VtZQkJPSBt
cnN0X2tleXBhZF9yZXN1bWUsCisjZW5kaWYgLyogQ09ORklHX1BNICovCit9OworCitzdGF0aWMg
aW50IF9faW5pdCBtcnN0X2tleXBhZF9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBjaV9yZWdpc3Rl
cl9kcml2ZXIoJm1yc3Rfa2V5cGFkX2RyaXZlcik7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBt
cnN0X2tleXBhZF9leGl0KHZvaWQpCit7CisJcGNpX3VucmVnaXN0ZXJfZHJpdmVyKCZtcnN0X2tl
eXBhZF9kcml2ZXIpOworfQorCittb2R1bGVfaW5pdChtcnN0X2tleXBhZF9pbml0KTsKK21vZHVs
ZV9leGl0KG1yc3Rfa2V5cGFkX2V4aXQpOworCitNT0RVTEVfREVTQ1JJUFRJT04oIk1SU1QgS2V5
cGFkIENvbnRyb2xsZXIgRHJpdmVyIik7CitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CitNT0RV
TEVfQVVUSE9SKCJaaGVuZyBCYSA8emhlbmcuYmFAaW50ZWwuY29tPiIpOwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9pbnB1dC5oIGIvaW5jbHVkZS9saW51eC9pbnB1dC5oCmluZGV4IDhiM2Jj
M2UuLjdlMTc4YjUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW5wdXQuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2lucHV0LmgKQEAgLTU0Myw2ICs1NDMsNyBAQCBzdHJ1Y3QgaW5wdXRfYWJzaW5m
byB7CiAjZGVmaW5lIEtFWV9GUkFNRUZPUldBUkQJMHgxYjUKICNkZWZpbmUgS0VZX0NPTlRFWFRf
TUVOVQkweDFiNgkvKiBHZW5EZXNjIC0gc3lzdGVtIGNvbnRleHQgbWVudSAqLwogI2RlZmluZSBL
RVlfTUVESUFfUkVQRUFUCTB4MWI3CS8qIENvbnN1bWVyIC0gdHJhbnNwb3J0IGNvbnRyb2wgKi8K
KyNkZWZpbmUgS0VZX0NBTUVSQV9GT0NVUwkweDFiOAogCiAjZGVmaW5lIEtFWV9ERUxfRU9MCQkw
eDFjMAogI2RlZmluZSBLRVlfREVMX0VPUwkJMHgxYzEKLS0gCjEuNi4wLjYKCg==

--_002_61563CE63B4F854986A895DA7AD3C17709DB43A5F9pdsmsx502ccrc_--
