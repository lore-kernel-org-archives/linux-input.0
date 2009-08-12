From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: RE: FW: [PATCH 1/1] input: keypad controller driver for Intel low
	power Moorestown platform
Date: Wed, 12 Aug 2009 16:45:08 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709DB43A635@pdsmsx502.ccr.corp.intel.com>
References: <61563CE63B4F854986A895DA7AD3C177159F83C1@pdsmsx502.ccr.corp.intel.com>
 <20090507164516.GA6450@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26790 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbZHLIp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2009 04:45:56 -0400
In-Reply-To: <20090507164516.GA6450@dtor-d630.eng.vmware.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Ba, Zheng" <zheng.ba@intel.com>

Hi Dmitry,

Here's the second version with changes inline per your comments, please help review. Thanks!

Thanks,
Zheng


>From 285ba6565a98598e24f5cca73c0a8a46690ea7cd Mon Sep 17 00:00:00 2001
From: Zheng Ba <zheng.ba@intel.com>
Date: Wed, 12 Aug 2009 15:37:17 +0800
Subject: [PATCH] Keypad controller driver for Intel low power Moorestown platform

This driver has dual-support for two styles of keypads: Direct keypad and
Matrix keypad. The Matrix keypad is 8x8 and works like a normal keyboard execpt for some
function keys (Fn). The Direct keypad contains 4 direct keys: camera shutters
(half/full presses) and volume up/down buttons.

added: drivers/input/mrst_keypad.c
modified: include/linux/input.h
          drivers/input/keyboard/Kconfig
          drivers/input/keyboard/Makefile

Signed-off-by: Zheng Ba <zheng.ba@intel.com>
---
 drivers/input/keyboard/Kconfig       |    7 +
 drivers/input/keyboard/Makefile      |    1 +
 drivers/input/keyboard/mrst_keypad.c |  785 ++++++++++++++++++++++++++++++++++
 include/linux/input.h                |    1 +
 4 files changed, 794 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mrst_keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
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
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..f788256 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_KEYBOARD_LM8323)         += lm8323.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)          += locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)           += maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)          += matrix_keypad.o
+obj-$(CONFIG_KEYBOARD_MRST)            += mrst_keypad.o
 obj-$(CONFIG_KEYBOARD_NEWTON)          += newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)            += omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)          += pxa27x_keypad.o
diff --git a/drivers/input/keyboard/mrst_keypad.c b/drivers/input/keyboard/mrst_keypad.c
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
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
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
+#define KPC_MKRN(n)    ((((n) - 1) & 0x7) << 26) /* matrix key row number */
+#define KPC_MKCN(n)    ((((n) - 1) & 0x7) << 23) /* matrix key col number */
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
+static struct pci_device_id keypad_pci_tbl[] = {
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
+static unsigned int mrst_keycode[MAX_KEY_NUM] = {
+       /* matrix keypad */
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_U, KEY_7, KEY_M, KEY_J, KEY_8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y,
+       KEY_MINUS, KEY_0, KEY_LEFT, KEY_SEMICOLON, KEY_P, KEY_DOWN, KEY_UP,\
+           KEY_BACKSPACE,
+       KEY_L, KEY_K, KEY_I, KEY_SLASH, KEY_COMMA, KEY_O, KEY_9, KEY_DOT,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN, \
+           KEY_A,
+       0, KEY_RIGHTSHIFT, KEY_ENTER, 0, KEY_RIGHT, 0, 0, 0,
+
+       /* matrix keypad with NumLk key pressed... */
+       KEY_F, KEY_D, KEY_E, KEY_GRAVE, KEY_C, KEY_R, KEY_4, KEY_V,
+       KEY_NUMLOCK, KEY_LEFTCTRL, KEY_Z, KEY_W, KEY_2, KEY_X, KEY_S, KEY_3,
+       KEY_EQUAL, KEY_N, KEY_H, KEY_KP4, KEY_KP7, KEY_KP0, KEY_KP1, KEY_KP8,
+       KEY_6, KEY_5, KEY_APOSTROPHE, KEY_G, KEY_T, KEY_SPACE, KEY_B, KEY_Y,
+       KEY_MINUS, KEY_KPSLASH, KEY_LEFT, KEY_KPMINUS, KEY_KPASTERISK, \
+           KEY_DOWN, KEY_UP, KEY_BACKSPACE,
+       KEY_KP3, KEY_KP2, KEY_KP5, KEY_SLASH, KEY_KPDOT, KEY_KP6, KEY_KP9, \
+           KEY_KPPLUS,
+       KEY_Q, KEY_TAB, KEY_ESC, KEY_LEFTSHIFT, KEY_CAPSLOCK, KEY_1, KEY_FN, \
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
+       struct input_dev *input_dev = keypad->input_dev;
+       unsigned int *key;
+       int i, code;
+
+       keypad->matrix_key_rows = MAX_MATRIX_KEY_ROWS;
+       keypad->matrix_key_cols = MAX_MATRIX_KEY_COLS;
+       keypad->matrix_key_map_size = MAX_MATRIX_KEY_NUM;
+       keypad->debounce_interval = DEBOUNCE_INTERVAL;
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
+       memcpy(keypad->direct_key_map, &mrst_keycode[MAX_MATRIX_KEY_NUM * 3],
+              sizeof(keypad->direct_key_map));
+
+       key = &keypad->mrst_matrix[0];
+       for (i = 0; i < MAX_KEY_NUM; i++, key++) {
+               code = (*key) & 0xffffff;
+               set_bit(code, input_dev->keybit);
+       }
+
+       keypad->direct_key_num = MAX_DIRECT_KEY_NUM;
+       keypad->enable_rotary0 = 0;
+       keypad->enable_rotary1 = 0;
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
+       struct input_dev *dev = keypad->input_dev;
+       int state = old_state[col] & (1 << row);
+
+       switch (num) {
+       case 0:
+               if (keypad->fn)
+                       keypad->fn = 0;
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
+               if (col == 6 && row == 6)
+                       keypad->fn = 1;
+               /* key '[' */
+               else if ((col == 0 && row == 2) && state) {
+                       keypad->fn = 0;
+                       set_bit(KEY_EQUAL, dev->key);
+                       dev->repeat_key = KEY_EQUAL;
+               }
+               /* key ']' */
+               else if ((col == 3 && row == 5) && state) {
+                       keypad->fn = 0;
+                       set_bit(KEY_SLASH, dev->key);
+                       dev->repeat_key = KEY_SLASH;
+               }
+               /* key '{' */
+               else if ((col == 4 && row == 5) && state) {
+                       keypad->fn = 0;
+                       set_bit(KEY_COMMA, dev->key);
+                       dev->repeat_key = KEY_COMMA;
+               }
+               /* key '}' */
+               else if ((col == 7 && row == 5) && state) {
+                       keypad->fn = 0;
+                       set_bit(KEY_DOT, dev->key);
+                       dev->repeat_key = KEY_DOT;
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
+       int row, col, num_keys_pressed = 0;
+       uint32_t new_state[MAX_MATRIX_KEY_COLS];
+       uint32_t kpas = keypad_readl(KPAS);
+
+       num_keys_pressed = KPAS_MUKP(kpas);
+
+       memset(new_state, 0, sizeof(new_state));
+
+       if (num_keys_pressed == 0) {
+               handle_sticky_keys(keypad, num_keys_pressed, 0, 0,
+                                        keypad->matrix_key_state);
+
+               goto scan;
+       }
+
+       if (num_keys_pressed == 1) {
+               col = KPAS_CP(kpas);
+               row = KPAS_RP(kpas);
+
+               /* if invalid row/col, treat as no key pressed */
+               if (col >= keypad->matrix_key_cols ||
+                   row >= keypad->matrix_key_rows)
+                       goto scan;
+
+               /* if NumLk pressed */
+               if (col == 0 && row == 1)
+                       keypad->flag = keypad->numlck = !keypad->numlck;
+
+               /* if Fn pressed */
+               if (col == 6 && row == 6)
+                       keypad->flag = 2;
+
+               handle_sticky_keys(keypad, num_keys_pressed, col, row,
+                                        keypad->matrix_key_state);
+
+               new_state[col] = (1 << row);
+
+               goto scan;
+       }
+
+       if (num_keys_pressed > 1) {
+               uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
+               uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
+               uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
+               uint32_t kpasmkp3 = keypad_readl(KPASMKP3);
+
+               new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
+               new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
+               new_state[2] = kpasmkp1 & KPASMKP_MKC_MASK;
+               new_state[3] = (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
+               new_state[4] = kpasmkp2 & KPASMKP_MKC_MASK;
+               new_state[5] = (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
+               new_state[6] = kpasmkp3 & KPASMKP_MKC_MASK;
+               new_state[7] = (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
+
+               /* if Fn is pressed, all SHIFT is ignored, except when {
+                * or } is pressed */
+               if (new_state[6] & 0x40) {
+                       keypad->fn = 1;
+                       keypad->flag = 2;
+                       new_state[3] &= ~0x40;
+                       new_state[1] &= ~0x80;
+               }
+
+               if (keypad->fn == 1) {
+                       /* if { or } pressed */
+                       if ((new_state[4] & 0x20) || (new_state[7] & 0x20)) {
+                               /* as if LEFTSHIFT is pressed */
+                               new_state[3] |= 0x40;
+                               /* as if Fn not pressed */
+                               new_state[6] &= ~0x40;
+                       }
+                       /* if [ or ] pressed */
+                       if ((new_state[0] & 0x04) || (new_state[3] & 0x20))
+                               /* as if Fn not pressed */
+                               new_state[6] &= ~0x40;
+               }
+       }
+
+
+scan:
+       for (col = 0; col < keypad->matrix_key_cols; col++) {
+               uint32_t bits_changed;
+
+               bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
+               if (bits_changed == 0)
+                       continue;
+
+               for (row = 0; row < keypad->matrix_key_rows; row++) {
+                       if ((bits_changed & (1 << row)) == 0)
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
+static void report_rotary_event(struct mrst_keypad *keypad, int r, int delta)
+{
+       struct input_dev *dev = keypad->input_dev;
+
+       if (delta == 0)
+               return;
+
+       if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
+               int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
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
+       kprec = keypad_readl(KPREC);
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
+       kpdk = keypad_readl(KPDK);
+
+       if (keypad->enable_rotary0 || keypad->enable_rotary1)
+               mrst_keypad_scan_rotary(keypad);
+
+       if ((keypad->direct_key_map == NULL) || (++keypad->count == 1)) {
+               keypad->direct_key_state = 0;
+               return;
+       }
+
+       new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
+       new_state = ~new_state;
+       bits_changed = keypad->direct_key_state ^ new_state;
+
+       if (bits_changed == 0)
+               return;
+
+       for (i = 0; i < keypad->direct_key_num; i++) {
+               if (bits_changed & (1 << i)) {
+                       input_report_key(keypad->input_dev,
+                                        keypad->direct_key_map[i],
+                                        (new_state & (1 << i)));
+               }
+       }
+       input_sync(keypad->input_dev);
+       keypad->direct_key_state = new_state;
+
+}
+
+static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
+{
+       struct mrst_keypad *keypad = dev_id;
+       unsigned long kpc = keypad_readl(KPC);
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
+       int i, err, cnt = 0;
+       int pins = KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
+           MAX_MATRIX_KEY_COLS + MAX_DIRECT_KEY_NUM;
+
+       for (i = KEYPAD_MATRIX_GPIO_IN_PIN; i < pins; i++, cnt++) {
+               err = gpio_request(i, NULL);
+               if (err) {
+                       printk(KERN_ERR "GPIO pin %d failed to request.\n", i);
+                       goto err_request;
+               }
+       }
+
+       for (i = 0; i < MAX_MATRIX_KEY_ROWS; i++)
+               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
+
+       for (i = 0; i < MAX_MATRIX_KEY_COLS; i++)
+               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
+
+       for (i = 0; i < MAX_DIRECT_KEY_NUM; i++)
+               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
+
+       return 0;
+
+err_request:
+       /* free requested pins... */
+       for (i = KEYPAD_MATRIX_GPIO_IN_PIN + cnt - 1;
+            i >= KEYPAD_MATRIX_GPIO_IN_PIN; i--)
+               gpio_free(i);
+       return err;
+}
+
+static void mrst_keypad_config(struct mrst_keypad *keypad)
+{
+       unsigned int mask = 0, direct_key_num = 0;
+       unsigned long kpc = 0;
+
+       /* enable matrix keys with automatic scan */
+       if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
+               kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
+               kpc |= KPC_MKRN(keypad->matrix_key_rows) |
+                      KPC_MKCN(keypad->matrix_key_cols);
+       }
+
+       /* enable rotary key, debounce interval same as direct keys */
+       if (keypad->enable_rotary0) {
+               mask |= 0x03;
+               direct_key_num = 2;
+               kpc |= KPC_REE0;
+       }
+
+       if (keypad->enable_rotary1) {
+               mask |= 0x0c;
+               direct_key_num = 4;
+               kpc |= KPC_REE1;
+       }
+
+       if (keypad->direct_key_num > direct_key_num)
+               direct_key_num = keypad->direct_key_num;
+
+       keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
+
+       /* enable direct key */
+       if (direct_key_num)
+               kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
+
+       keypad_writel(KPC, kpc);
+       keypad_writel(KPREC, DEFAULT_KPREC);
+       keypad_writel(KPKDI, keypad->debounce_interval);
+}
+
+static int mrst_keypad_open(struct input_dev *dev)
+{
+       struct mrst_keypad *keypad = input_get_drvdata(dev);
+       int err;
+
+       err = mrst_keypad_gpio_init();
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
+       keypad = kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
+       if (keypad == NULL) {
+               dev_err(&pdev->dev, "failed to allocate driver data\n");
+               return -ENOMEM;
+       }
+
+       error = pci_enable_device(pdev);
+       if (error || (pdev->irq < 0)) {
+               dev_err(&pdev->dev, "failed to enable device/get irq\n");
+               error = -ENXIO;
+               goto failed_free;
+       }
+
+       error = pci_request_regions(pdev, DRV_NAME);
+       if (error) {
+               dev_err(&pdev->dev, "failed to request I/O memory\n");
+               goto failed_free;
+       }
+
+       keypad->mmio_base = ioremap(pci_resource_start(pdev, 0), \
+               pci_resource_len(pdev, 0));
+       if (keypad->mmio_base == NULL) {
+               dev_err(&pdev->dev, "failed to remap I/O memory\n");
+               error = -ENXIO;
+               goto failed_free_mem;
+       }
+
+       /* Create and register the input driver. */
+       input_dev = input_allocate_device();
+       if (!input_dev) {
+               dev_err(&pdev->dev, "failed to allocate input device\n");
+               error = -ENOMEM;
+               goto failed_free_io;
+       }
+
+       input_dev->name = pci_name(pdev);
+       input_dev->id.bustype = BUS_PCI;
+       input_dev->open = mrst_keypad_open;
+       input_dev->close = mrst_keypad_close;
+       input_dev->dev.parent = &pdev->dev;
+
+       input_dev->keycode = keypad->mrst_matrix;
+       input_dev->keycodesize = sizeof(keypad->mrst_matrix[0]);
+       input_dev->keycodemax = ARRAY_SIZE(keypad->mrst_matrix);
+
+       keypad->input_dev = input_dev;
+       keypad->fn = 0;
+       keypad->numlck = 0;
+       keypad->flag = 0;
+       /*FIXME*/keypad->count = 0;
+       input_set_drvdata(input_dev, keypad);
+
+       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
+               BIT_MASK(EV_REL);
+
+       mrst_keypad_build_keycode(keypad);
+       pci_set_drvdata(pdev, keypad);
+
+       error = request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHARED,
+               DRV_NAME, keypad);
+       if (error) {
+               dev_err(&pdev->dev, "failed to request IRQ\n");
+               goto failed_free_dev;
+       }
+
+       /* Register the input device */
+       error = input_register_device(input_dev);
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
+       struct mrst_keypad *keypad = pci_get_drvdata(pdev);
+       int i;
+       int pins = KEYPAD_MATRIX_GPIO_IN_PIN + MAX_MATRIX_KEY_ROWS +
+           MAX_MATRIX_KEY_COLS + MAX_DIRECT_KEY_NUM;
+
+       for (i = pins - 1; i > KEYPAD_MATRIX_GPIO_IN_PIN; i--)
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
+static struct pci_driver mrst_keypad_driver = {
+       .name           = DRV_NAME,
+       .id_table       = keypad_pci_tbl,
+       .probe          = mrst_keypad_probe,
+       .remove         = __devexit_p(mrst_keypad_remove),
+#ifdef CONFIG_PM
+       .suspend        = mrst_keypad_suspend,
+       .resume         = mrst_keypad_resume,
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
Subject: Re: FW: [PATCH 1/1] input: keypad controller driver for Intel low power Moorestown platform

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
> +static unsigned int mrst_keycode[MAX_MATRIX_KEY_NUM] = {
...
> +/* NumLk key mapping */
> +static unsigned int mrst_keycode_numlck[MAX_MATRIX_KEY_NUM] = {
...
> +/* Fn key mapping */
> +static unsigned int mrst_keycode_fn[MAX_MATRIX_KEY_NUM] = {
...
> +/* direct key map */
> +static unsigned int mrst_direct_keycode[MAX_DIRECT_KEY_NUM] = {
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
> +       struct input_dev *input_dev = keypad->input_dev;
> +       unsigned int *key;
> +       int i, code;
> +
> +       keypad->matrix_key_rows = MAX_MATRIX_KEY_ROWS;
> +       keypad->matrix_key_cols = MAX_MATRIX_KEY_COLS;
> +       keypad->matrix_key_map_size = MAX_MATRIX_KEY_NUM;
> +       keypad->debounce_interval = DEBOUNCE_INTERVAL;
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
> +       key = &keypad->matrix_keycodes[0];
> +       for (i = 0; i < MAX_MATRIX_KEY_NUM; i++, key++) {
> +               code = (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       key = &keypad->direct_key_map[0];
> +       for (i = 0; i < MAX_DIRECT_KEY_NUM; i++, key++) {
> +               code = (*key) & 0xffffff;
> +               set_bit(code, input_dev->keybit);
> +       }
> +
> +       keypad->direct_key_num = MAX_DIRECT_KEY_NUM;
> +       keypad->enable_rotary0 = 0;
> +       keypad->enable_rotary1 = 0;
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
> +       struct input_dev *dev = keypad->input_dev;
> +       int state = old_state[col] & (1 << row);
> +
> +       switch (num) {
> +       case 0:
> +               if (keypad->fn)
> +                       keypad->fn = 0;
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
> +               if (col == 6 && row == 6)
> +                       keypad->fn = 1;
> +               /* key '[' */
> +               else if ((col == 0 && row == 2) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_EQUAL, dev->key);
> +                       dev->repeat_key = KEY_EQUAL;

And what if I remapped the key?

> +               }
> +               /* key ']' */
> +               else if ((col == 3 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_SLASH, dev->key);
> +                       dev->repeat_key = KEY_SLASH;
> +               }
> +               /* key '{' */
> +               else if ((col == 4 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_COMMA, dev->key);
> +                       dev->repeat_key = KEY_COMMA;
> +               }
> +               /* key '}' */
> +               else if ((col == 7 && row == 5) && state) {
> +                       keypad->fn = 0;
> +                       set_bit(KEY_DOT, dev->key);
> +                       dev->repeat_key = KEY_DOT;
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
> +       int row, col, num_keys_pressed = 0;
> +       uint32_t new_state[MAX_MATRIX_KEY_COLS];
> +       uint32_t kpas = keypad_readl(KPAS);
> +
> +       num_keys_pressed = KPAS_MUKP(kpas);
> +
> +       memset(new_state, 0, sizeof(new_state));
> +
> +       if (num_keys_pressed == 0) {
> +               handle_constant_keypress(keypad, num_keys_pressed, 0, 0,
> +                                        keypad->matrix_key_state);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed == 1) {
> +               col = KPAS_CP(kpas);
> +               row = KPAS_RP(kpas);
> +
> +               /* if invalid row/col, treat as no key pressed */
> +               if (col >= keypad->matrix_key_cols ||
> +                   row >= keypad->matrix_key_rows)
> +                       goto scan;
> +
> +               /* if NumLk pressed */
> +               if (col == 0 && row == 1)
> +                       keypad->numlck = !keypad->numlck;
> +
> +               handle_constant_keypress(keypad, num_keys_pressed, col, row,
> +                                        keypad->matrix_key_state);
> +
> +               new_state[col] = (1 << row);
> +
> +               goto scan;
> +       }
> +
> +       if (num_keys_pressed > 1) {
> +               uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
> +               uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
> +               uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
> +               uint32_t kpasmkp3 = keypad_readl(KPASMKP3);
> +
> +               new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
> +               new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[2] = kpasmkp1 & KPASMKP_MKC_MASK;
> +               new_state[3] = (kpasmkp1 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[4] = kpasmkp2 & KPASMKP_MKC_MASK;
> +               new_state[5] = (kpasmkp2 >> 16) & KPASMKP_MKC_MASK;
> +               new_state[6] = kpasmkp3 & KPASMKP_MKC_MASK;
> +               new_state[7] = (kpasmkp3 >> 16) & KPASMKP_MKC_MASK;
> +
> +               /* if Fn is pressed, all SHIFT is ignored, except when {
> +                * or } is pressed */
> +               if (new_state[6] & 0x40) {
> +                       keypad->fn = 1;
> +                       new_state[3] &= ~0x40;
> +                       new_state[1] &= ~0x80;
> +               }
> +
> +               if (keypad->fn == 1) {
> +                       /* if { or } pressed */
> +                       if ((new_state[4] & 0x20) || (new_state[7] & 0x20)) {
> +                               /* as if LEFTSHIFT is pressed */
> +                               new_state[3] |= 0x40;
> +                               /* as if Fn not pressed */
> +                               new_state[6] &= ~0x40;
> +                       }
> +                       /* if [ or ] pressed */
> +                       if ((new_state[0] & 0x04) || (new_state[3] & 0x20))
> +                               /* as if Fn not pressed */
> +                               new_state[6] &= ~0x40;
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
> +       for (col = 0; col < keypad->matrix_key_cols; col++) {
> +               uint32_t bits_changed;
> +
> +               bits_changed = keypad->matrix_key_state[col] ^ new_state[col];
> +               if (bits_changed == 0)
> +                       continue;
> +
> +               for (row = 0; row < keypad->matrix_key_rows; row++) {
> +                       if ((bits_changed & (1 << row)) == 0)
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
> +static void report_rotary_event(struct mrst_keypad *keypad, int r, int delta)
> +{
> +       struct input_dev *dev = keypad->input_dev;
> +
> +       if (delta == 0)
> +               return;
> +
> +       if (keypad->rotary_up_key[r] && keypad->rotary_down_key[r]) {
> +               int keycode = (delta > 0) ? keypad->rotary_up_key[r] :
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
> +       kprec = keypad_readl(KPREC);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +
> +       if (keypad->enable_rotary0)
> +               report_rotary_event(keypad, 0, rotary_delta(kprec));
> +
> +       if (keypad->enable_rotary1)
> +               report_rotary_event(keypad, 1, rotary_delta(kprec >> 16));
> +}
> +
> +static void mrst_keypad_scan_direct(struct mrst_keypad *keypad)
> +{
> +       unsigned int new_state;
> +       uint32_t kpdk, bits_changed;
> +       int i;
> +
> +       kpdk = keypad_readl(KPDK);
> +
> +       if (keypad->enable_rotary0 || keypad->enable_rotary1)
> +               mrst_keypad_scan_rotary(keypad);
> +
> +       if ((keypad->direct_key_map == NULL) || (++keypad->count == 1)) {
> +               keypad->direct_key_state = 0;
> +               return;
> +       }
> +
> +       new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
> +       new_state = ~new_state;
> +       bits_changed = keypad->direct_key_state ^ new_state;
> +
> +       if (bits_changed == 0)
> +               return;
> +
> +       for (i = 0; i < keypad->direct_key_num; i++) {
> +               if (bits_changed & (1 << i)) {
> +                       input_report_key(keypad->input_dev,
> +                                        keypad->direct_key_map[i],
> +                                        (new_state & (1 << i)));
> +               }
> +       }
> +       input_sync(keypad->input_dev);
> +       keypad->direct_key_state = new_state;
> +
> +}
> +
> +static irqreturn_t mrst_keypad_irq_handler(int irq, void *dev_id)
> +{
> +       struct mrst_keypad *keypad = dev_id;
> +       unsigned long kpc = keypad_readl(KPC);
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
> +       for (i = 0; i < MAX_MATRIX_KEY_ROWS; i++) {
> +               gpio_direction_input(KEYPAD_MATRIX_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_IN_PIN + i, 1);
> +       }
> +
> +       for (i = 0; i < MAX_MATRIX_KEY_COLS; i++) {
> +               /* __gpio_set_value(KEYPAD_GPIO_OUT_PIN + i, 1); */
> +               /* set action is executed in gpio_direction_output() */
> +               gpio_direction_output(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +               gpio_alt_func(KEYPAD_MATRIX_GPIO_OUT_PIN + i, 1);
> +       }
> +
> +       for (i = 0; i < MAX_DIRECT_KEY_NUM; i++) {
> +               gpio_direction_input(KEYPAD_DIRECT_GPIO_IN_PIN + i);
> +               gpio_alt_func(KEYPAD_DIRECT_GPIO_IN_PIN + i, 1);
> +       }
> +}

If it is not needed/ready for mainline lets drop it.

> +#endif
> +
> +static void mrst_keypad_config(struct mrst_keypad *keypad)
> +{
> +       unsigned int mask = 0, direct_key_num = 0;
> +       unsigned long kpc = 0;
> +
> +       /* enable matrix keys with automatic scan */
> +       if (keypad->matrix_key_rows && keypad->matrix_key_cols) {
> +               kpc |= KPC_ASACT | KPC_MIE | KPC_ME | KPC_MS_ALL;
> +               kpc |= KPC_MKRN(keypad->matrix_key_rows) |
> +                      KPC_MKCN(keypad->matrix_key_cols);
> +       }
> +
> +       /* enable rotary key, debounce interval same as direct keys */
> +       if (keypad->enable_rotary0) {
> +               mask |= 0x03;
> +               direct_key_num = 2;
> +               kpc |= KPC_REE0;
> +       }
> +
> +       if (keypad->enable_rotary1) {
> +               mask |= 0x0c;
> +               direct_key_num = 4;
> +               kpc |= KPC_REE1;
> +       }
> +
> +       if (keypad->direct_key_num > direct_key_num)
> +               direct_key_num = keypad->direct_key_num;
> +
> +       keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
> +
> +       /* enable direct key */
> +       if (direct_key_num)
> +               kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);
> +
> +       keypad_writel(KPC, kpc);
> +       keypad_writel(KPREC, DEFAULT_KPREC);
> +       keypad_writel(KPKDI, keypad->debounce_interval);
> +}
> +
> +static int mrst_keypad_open(struct input_dev *dev)
> +{
> +       struct mrst_keypad *keypad = input_get_drvdata(dev);
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
> +       keypad = input_get_drvdata(dev);

And..?


> +}
> +
> +#ifdef CONFIG_PM
> +static int mrst_keypad_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +       /* struct mrst_keypad *keypad = pci_get_drvdata(pdev); */
> +
> +       /* clk_disable(keypad->clk); */

If stopping clock is not needed why do you have this fucntion at all?

> +       return 0;
> +}
> +
> +static int mrst_keypad_resume(struct pci_dev *pdev)
> +{
> +       struct mrst_keypad *keypad = pci_get_drvdata(pdev);
> +       struct input_dev *input_dev = keypad->input_dev;
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
> +       keypad = kzalloc(sizeof(struct mrst_keypad), GFP_KERNEL);
> +       if (keypad == NULL) {
> +               dev_err(&pdev->dev, "failed to allocate driver data\n");
> +               return -ENOMEM;
> +       }
> +
> +       error = pci_enable_device(pdev);
> +       if (error || (pdev->irq < 0)) {
> +               dev_err(&pdev->dev, "failed to enable device/get irq\n");
> +               error = -ENXIO;
> +               goto failed_free;
> +       }
> +
> +       error = pci_request_regions(pdev, DRV_NAME);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request I/O memory\n");
> +               goto failed_free;
> +       }
> +
> +       keypad->mmio_base = ioremap(pci_resource_start(pdev, 0), \
> +               pci_resource_len(pdev, 0));
> +       if (keypad->mmio_base == NULL) {
> +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
> +               error = -ENXIO;
> +               goto failed_free_mem;
> +       }
> +
> +       /* Create and register the input driver. */
> +       input_dev = input_allocate_device();
> +       if (!input_dev) {
> +               dev_err(&pdev->dev, "failed to allocate input device\n");
> +               error = -ENOMEM;
> +               goto failed_free_io;
> +       }
> +
> +       input_dev->name = pci_name(pdev);
> +       input_dev->id.bustype = BUS_PCI;
> +       input_dev->open = mrst_keypad_open;
> +       input_dev->close = mrst_keypad_close;
> +       input_dev->dev.parent = &pdev->dev;
> +
> +       input_dev->keycode = keypad->matrix_keycodes;
> +       input_dev->keycodesize = sizeof(unsigned int);

sizeof(keypad->matrix_keycodes[0]) is safer.

> +       input_dev->keycodemax = ARRAY_SIZE(mrst_keycode);

ARRAY_SIZE(keypad->matrix_keycodes);

> +
> +       keypad->input_dev = input_dev;
> +       keypad->fn = 0;
> +       keypad->numlck = 0;
> +       /*FIXME*/keypad->count = 0;
> +       input_set_drvdata(input_dev, keypad);
> +
> +       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +               BIT_MASK(EV_REL);
> +
> +       mrst_keypad_build_keycode(keypad);
> +       pci_set_drvdata(pdev, keypad);
> +
> +       error = request_irq(pdev->irq, mrst_keypad_irq_handler, IRQF_SHARED,
> +               pci_name(pdev), keypad);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to request IRQ\n");
> +               goto failed_free_dev;
> +       }
> +
> +       /* Register the input device */
> +       error = input_register_device(input_dev);
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
> +       struct mrst_keypad *keypad = pci_get_drvdata(pdev);
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
> +static struct pci_driver mrst_keypad_driver = {
> +       .name           = DRV_NAME,
> +       .id_table       = keypad_pci_tbl,
> +       .probe          = mrst_keypad_probe,
> +       .remove         = __devexit_p(mrst_keypad_remove),
> +#ifdef CONFIG_PM
> +       .suspend        = mrst_keypad_suspend,
> +       .resume         = mrst_keypad_resume,
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
