From: Denis Zaitceff <zaitceff@gmail.com>
Subject: [PATCH] atkbd.c: make the unknown key warnings controllable thru a config option
Date: Sun, 29 Jun 2008 22:54:23 +0600
Message-ID: <20080629225423.A23524@ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756720AbYF2QzA@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: vojtech@suse.cz, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The patch allows to configure off the logging of ATKBD_KEY_UNKNOWN
events.  This logging can be healthy, but usually it just pollutes the
kernel log.  And this logging may be _very_ massive.

Very probably that other (than atkbd) keyboard drivers may win from
the similar patches.

Please apply this patch.


--- drivers/input/keyboard/Kconfig
+++ drivers/input/keyboard/Kconfig
@@ -12,6 +12,15 @@ menuconfig INPUT_KEYBOARD
 
 if INPUT_KEYBOARD
 
+config KEYBOARD_VERBOSE_KEY_UNKNOWN
+	bool "Report unknown keys"
+	default n
+	help
+	  If Y, each press and release of any key unknown to the keyboard driver
+	  will be logged at the KERN_WARNING level.  This is really good if you
+	  want to study your keyboard, but may really flood your logs.
+	  Be warned!
+
 config KEYBOARD_ATKBD
 	tristate "AT keyboard" if EMBEDDED || !X86_PC
 	default y
--- drivers/input/keyboard/atkbd.c
+++ drivers/input/keyboard/atkbd.c
@@ -442,6 +442,7 @@ static irqreturn_t atkbd_interrupt(struc
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
+#ifdef KEYBOARD_VERBOSE_KEY_UNKNOWN
 			printk(KERN_WARNING
 			       "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
 			       atkbd->release ? "released" : "pressed",
@@ -450,6 +451,7 @@ static irqreturn_t atkbd_interrupt(struc
 			printk(KERN_WARNING
 			       "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
 			       code & 0x80 ? "e0" : "", code & 0x7f);
+#endif
 			input_sync(dev);
 			break;
 		case ATKBD_SCR_1:
