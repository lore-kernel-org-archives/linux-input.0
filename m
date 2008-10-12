From: Colin Macdonald <cbm@math.ucla.edu>
Subject: Re: [PATCH] input: Thinkpad R31 i8042 nomux quirk
Date: Sun, 12 Oct 2008 11:39:54 -0700
Message-ID: <48F2447A.40607@math.ucla.edu>
References: <48F0EDF0.3020702@math.ucla.edu> <48F1AC77.3020503@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from walnut.math.ucla.edu ([128.97.19.2]:58680 "EHLO
	walnut.math.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYJLSkF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2008 14:40:05 -0400
In-Reply-To: <48F1AC77.3020503@email.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: legolas558 <legolas558@email.it>
Cc: linux-input@vger.kernel.org

legolas558 wrote:
> I also have a notebook, Maxdata Pro 7000X (Fujitsu clone), which has
> such problem (needs i8042.nomux=1, perhaps kernel bug #8740).
> 
> Can we also use a patch for it?

Can you test the patch below and see if it fixes the problem?

> Handle 0x0001, DMI type 1, 25 bytes
> System Information
>        Manufacturer: MAXDATA              Product Name: Pro 7000X    
>        Version: xxxxxxxxxx
>        Serial Number: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>        UUID: xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx
>        Wake-up Type: Power Switch


--- linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h.orig	2008-10-12 11:31:43.000000000 -0700
+++ linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h	2008-10-12 11:33:11.000000000 -0700
@@ -329,6 +329,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
 		},
 	},
+	{
+		.ident = "Maxdata Pro 7000X (Fujitsu clone)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAXDATA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pro 7000X"),
+		},
+	},
 	{ }
 };

