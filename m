From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] add quirk to fix volume wheel on Toshiba U300 laptops
Date: Fri, 18 Jun 2010 14:32:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006181431080.13809@pobox.suse.cz>
References: <201006091337.10152.akohlsmith@mixdown.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34727 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761177Ab0FRMcc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 08:32:32 -0400
In-Reply-To: <201006091337.10152.akohlsmith@mixdown.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Kohlsmith <akohlsmith@mixdown.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 9 Jun 2010, Andrew Kohlsmith wrote:

> Good afternoon,
> 
> Here is a small patch which adds a quirk match for these laptops; the volume 
> wheel on them does not stop when you move it (the wheel does not send 'up' 
> keycodes).
> 
> Patch applies cleanly to linus' tree as of about...10 minutes ago. :-)

Hi Andrew,

this patch needs to go through Dmitry, who is current input subsystem 
maintainer.

I have added him (and linux-input) to CC, and included the patch for 
convenience below.

You'd also need to include your Signed-off-by: line in order for the patch 
to be properly merged.

Thanks.



diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index d358ef8..f1e1801 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1715,6 +1715,22 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.callback = atkbd_setup_scancode_fixup,
 		.driver_data = atkbd_oqo_01plus_scancode_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U300"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_volume_forced_release_keys,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite Pro U300"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_volume_forced_release_keys,
+	},
 	{ }
 };
 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
