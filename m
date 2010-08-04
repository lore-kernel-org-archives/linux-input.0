From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] USB: drop tty argument from usb_serial_handle_sysrq_char()
Date: Wed, 04 Aug 2010 00:59:11 -0700
Message-ID: <20100804075911.30647.64907.stgit@localhost.localdomain>
References: <20100804075602.30647.91462.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60589 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab0HDH7O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Aug 2010 03:59:14 -0400
In-Reply-To: <20100804075602.30647.91462.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jason Wessel <jason.wessel@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

Since handle_sysrq() does not take tty as argument anymore we can
drop it from usb_serial_handle_sysrq_char() as well.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/serial/ftdi_sio.c |    2 +-
 drivers/usb/serial/generic.c  |    5 ++---
 drivers/usb/serial/pl2303.c   |    2 +-
 include/linux/usb/serial.h    |    3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e298dc4..8aecfe5 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1827,7 +1827,7 @@ static int ftdi_process_packet(struct tty_struct *tty,
 
 	if (port->port.console && port->sysrq) {
 		for (i = 0; i < len; i++, ch++) {
-			if (!usb_serial_handle_sysrq_char(tty, port, *ch))
+			if (!usb_serial_handle_sysrq_char(port, *ch))
 				tty_insert_flip_char(tty, *ch, flag);
 		}
 	} else {
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 9587c22..dee73b9 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -338,7 +338,7 @@ void usb_serial_generic_process_read_urb(struct urb *urb)
 		tty_insert_flip_string(tty, ch, urb->actual_length);
 	else {
 		for (i = 0; i < urb->actual_length; i++, ch++) {
-			if (!usb_serial_handle_sysrq_char(tty, port, *ch))
+			if (!usb_serial_handle_sysrq_char(port, *ch))
 				tty_insert_flip_char(tty, *ch, TTY_NORMAL);
 		}
 	}
@@ -443,8 +443,7 @@ void usb_serial_generic_unthrottle(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(usb_serial_generic_unthrottle);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-int usb_serial_handle_sysrq_char(struct tty_struct *tty,
-			struct usb_serial_port *port, unsigned int ch)
+int usb_serial_handle_sysrq_char(struct usb_serial_port *port, unsigned int ch)
 {
 	if (port->sysrq && port->port.console) {
 		if (ch && time_before(jiffies, port->sysrq)) {
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 6b60018..34ad7b3 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -788,7 +788,7 @@ static void pl2303_process_read_urb(struct urb *urb)
 
 	if (port->port.console && port->sysrq) {
 		for (i = 0; i < urb->actual_length; ++i)
-			if (!usb_serial_handle_sysrq_char(tty, port, data[i]))
+			if (!usb_serial_handle_sysrq_char(port, data[i]))
 				tty_insert_flip_char(tty, data[i], tty_flag);
 	} else {
 		tty_insert_flip_string_fixed_flag(tty, data, tty_flag,
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 84a4c44..55675b1 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -342,8 +342,7 @@ extern int usb_serial_generic_submit_read_urb(struct usb_serial_port *port,
 extern void usb_serial_generic_process_read_urb(struct urb *urb);
 extern int usb_serial_generic_prepare_write_buffer(struct usb_serial_port *port,
 						void *dest, size_t size);
-extern int usb_serial_handle_sysrq_char(struct tty_struct *tty,
-					struct usb_serial_port *port,
+extern int usb_serial_handle_sysrq_char(struct usb_serial_port *port,
 					unsigned int ch);
 extern int usb_serial_handle_break(struct usb_serial_port *port);
 

