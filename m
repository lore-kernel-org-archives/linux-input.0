From: Colin Macdonald <cbm@math.ucla.edu>
Subject: [PATCH] input: Thinkpad R31 i8042 nomux quirk
Date: Sat, 11 Oct 2008 11:18:24 -0700
Message-ID: <48F0EDF0.3020702@math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from walnut.math.ucla.edu ([128.97.19.2]:52984 "EHLO
	walnut.math.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbYJKS1P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2008 14:27:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru

Subject: [PATCH] input: Thinkpad R31 i8042 nomux quirk
from: Colin B Macdonald <cbm@m.fsf.org>

Thinkpad R31 needs i8042 nomux quirk.  Stops jittery jumping mouse
and random keyboard input.  Fixes kernel bug #11723.  Cherry picked
from Ubuntu who have sometimes (on-again-off-again) had a fix in
their patched kernels.

Signed-off-by: Colin B Macdonald <cbm@m.fsf.org>

---

--- linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h.orig	2008-10-11 01:07:22.000000000 -0700
+++ linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h	2008-10-11 01:06:24.000000000 -0700
@@ -322,6 +322,13 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
 		},
 	},
+	{
+		.ident = "IBM 2656",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
+		},
+	},
 	{ }
 };

