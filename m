From: akpm@linux-foundation.org
Subject: [patch 4/4] input: touchpad not detected on Asus G1S
Date: Thu, 06 Aug 2009 16:04:14 -0700
Message-ID: <200908062304.n76N4ETi002625@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38029 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978AbZHFXEU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2009 19:04:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, geekypenguin@gmail.com

From: "Jory A. Pratt" <geekypenguin@gmail.com>

The synaptic touchpad on the Asus G1S is not properly detected when
rebooting machine or on cold boot from time to time.  Adding the Asus G1S
to the noloop exception table resolves the issue, as it allows the AUX IRQ
to be rasied.

# dmidecode 2.10
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
     Manufacturer: ASUSTeK Computer Inc.
     Product Name: G1S
     Version: 1.0
     Serial Number: NF1G7900340285
     UUID: 242481DC-61E7-7EFB-2480-001D606B6A5E
     Wake-up Type: Power Switch
     SKU Number:
     Family:

Signed-off-by: Jory A. Pratt <geekypenguin@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/input/serio/i8042-x86ia64io.h~input-touchpad-not-detected-on-asus-g1s drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h~input-touchpad-not-detected-on-asus-g1s
+++ a/drivers/input/serio/i8042-x86ia64io.h
@@ -78,6 +78,14 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident = "ASUS G1S",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+		},
+	},
+	{
 		/* AUX LOOP command does not raise AUX IRQ */
 		.ident = "ASUS P65UP5",
 		.matches = {
_
