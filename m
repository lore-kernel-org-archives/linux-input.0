From: Carlos Corbacho <cathectic@gmail.com>
Subject: [PATCH] input: Add wireless and bluetooth keycodes
Date: Thu, 3 May 2007 12:15:16 +0100
Message-ID: <200705031215.16971.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Add wireless and bluetooth keycodes. Also, add keycodes for these
keys having a separate off state (This is true on some machines,
such as many Acer laptops).

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
There don't appear to be any keycodes defined for wireless and bluetooth.
On my laptop (Acer Aspire 5021) these buttons generate scancodes, rather 
than being hardware controlled or generating an ACPI hotkey event, so it 
would be nice to have some standard keycodes to map them to.

Plus, to cause more bother, the buttons on my laptop also generate a 
different scancode depending on whether the device in question is enabled
or disabled (hence the _OFF entries). This is also true for an awful lot of
other Acer laptops.

--- linux-2.6.21/include/linux/input.h.orig	2007-05-03 11:48:15.000000000 +0100
+++ linux-2.6.21/include/linux/input.h	2007-05-03 11:48:21.000000000 +0100
@@ -506,6 +506,10 @@
 #define KEY_VOICEMAIL		0x1ac
 #define KEY_ADDRESSBOOK		0x1ad
 #define KEY_MESSENGER		0x1ae
+#define KEY_WIRELESS		0x1b0
+#define KEY_WIRELESS_OFF	0x1b1
+#define KEY_BLUETOOTH		0x1b2
+#define KEY_BLUETOOTH_OFF	0x1b3
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
