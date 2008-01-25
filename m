From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: [PATCH] linux-2.6.24/drivers/hid/hid-input.c
Date: Fri, 25 Jan 2008 11:11:34 +0100
Message-ID: <20080125101134.GA3802@titan.lahn.de>
References: <alpine.LFD.1.00.0801241506500.15329@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759219AbYAYKhB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801241506500.15329@hp.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In hidinput_configure_usage(device), IS_CHICONY_TACTICAL_PAD(devic) gets
passed the 'device' parameter. But that macro still references its
parameter by 'device' instead of by its local name 'x'.

Signed-off-by: Philipp Matthias Hahn <pmhahn@titan.lahn.de>

--- linux/drivers/hid/hid-input.c	2008-01-25 09:57:17.000000000 +0100
+++ linux/drivers/hid/hid-input.c	2008-01-25 10:56:35.835871529 +0100
@@ -87,7 +87,7 @@
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 
 /* hardware needing special handling due to colliding MSVENDOR page usages */
-#define IS_CHICONY_TACTICAL_PAD(x) (x->vendor == 0x04f2 && device->product == 0x0418)
+#define IS_CHICONY_TACTICAL_PAD(x) (x->vendor == 0x04f2 && x->product == 0x0418)
 #define IS_MS_KB(x) (x->vendor == 0x045e && (x->product == 0x00db || x->product == 0x00f9))
 
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
