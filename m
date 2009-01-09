From: akpm@linux-foundation.org
Subject: [patch 03/17] serio_raw: add support for translated (SERIO_I8042XL) ports
Date: Fri, 09 Jan 2009 12:19:42 -0800
Message-ID: <200901092019.n09KJhLP017131@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57509 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752926AbZAIUUe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:20:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, niels.devos@wincor-nixdorf.com, dmitry.torokhov@gmail.com

From: "Niels de Vos" <niels.devos@wincor-nixdorf.com>

serio_raw only binds to non-translated devices. Enable serio_raw to
bind to normal (translated) keyboards which can have non-standard
extensions (like POS Keyboards). With this it is possible to send
commands to the device over /dev/serio_raw<n>.

Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/serio_raw.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN drivers/input/serio/serio_raw.c~serio_raw-add-support-for-translated-serio_i8042xl-ports drivers/input/serio/serio_raw.c
--- a/drivers/input/serio/serio_raw.c~serio_raw-add-support-for-translated-serio_i8042xl-ports
+++ a/drivers/input/serio/serio_raw.c
@@ -378,6 +378,12 @@ static struct serio_device_id serio_raw_
 		.id	= SERIO_ANY,
 		.extra	= SERIO_ANY,
 	},
+	{
+		.type   = SERIO_8042_XL,
+		.proto  = SERIO_ANY,
+		.id     = SERIO_ANY,
+		.extra  = SERIO_ANY,
+	},
 	{ 0 }
 };
 
_
