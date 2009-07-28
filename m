From: "Jory A. Pratt" <geekypenguin@gmail.com>
Subject: [RFC PATCH] Asus G1S noloop exception
Date: Mon, 27 Jul 2009 23:29:43 -0500
Message-ID: <4A6E7EB7.4090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:63548 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZG1Ev5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2009 00:51:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

INPUT - Touchpad not detected on Asus G1S

The synaptic touchpad on the Asus G1S is not properly detected when 
rebooting machine
or on cold boot from time to time. Adding the Asus G1S to the noloop 
exception table resolves
the issue, as it allows the AUX IRQ to be rasied.

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

diff --git a/drivers/input/serio/i8042-x86ia64io.h 
b/drivers/input/serio/i8042-x86ia64io.h
index fb8a3cd..6723d04 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -78,6 +78,14 @@ static struct dmi_system_id __initdata 
i8042_dmi_noloop_table[] = {
                 },
         },
         {
+               .ident = "ASUS G1S",
+               .matches = {
+                       DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer 
INC."),
+                       DMI_MATCH(DMI_BOARD_NAME, "G1S"),
+                       DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+               },
+       },
+       {
                 /* AUX LOOP command does not raise AUX IRQ */
                 .ident = "ASUS P65UP5",
                 .matches = {
