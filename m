From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: 2.6.28 thinks that my PS/2 mouse is a touchpad
Date: Mon, 29 Dec 2008 19:56:19 +0100
Message-ID: <20081229185619.GA18394@adopmeer.homeip.net>
References: <gj4r8h$okm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:39341 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYL2TSH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2008 14:18:07 -0500
Content-Disposition: inline
In-Reply-To: <gj4r8h$okm$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Dec 27, 2008 at 02:06:29PM +0500, Alexander E. Patrakov wrote:
> 
> Linux-2.6.28, as compiled by Arch Linux developers, thinks that my PS/2
> mouse (a cheap M-BT58 optical wheel mouse by Logitech) is actually a
> touchpad.  This makes it unusable.  Adding the "proto=imps" parameter to
> the psmouse module helps.

> CONFIG_MOUSE_PS2_ELANTECH=y

Oh dear. The first victim of this driver... :(

As we can see below the mouse gets detected as an Elantech touchpad. This
means that it reacts to the Elantech magic knock with the exact same
response we expect from a real Elantech touchpad.

I see no way to prevent this from happening.

> elantech.c: Elantech version query result 0x00, 0x01, 0x64.
> elantech.c: assuming hardware version 1, firmware version 0.100
> elantech.c: Synaptics capabilities query result 0x00, 0x02, 0x64.

However, all version query results I have seen from Elantech touchpads have
a non-zero first byte and a zero second byte. So we could test for that to
prevent this mouse from being detected as a touchpad.

Dmitry, do you think something like this is sufficient?

--- elantech.c.ORIG	2008-12-29 19:35:01.000000000 +0100
+++ elantech.c.NEW	2008-12-29 19:38:59.000000000 +0100
@@ -618,6 +618,10 @@ int elantech_init(struct psmouse *psmous
 	}
 	pr_info("elantech.c: Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
 		param[0], param[1], param[2]);
+	if (param[0] == 0 || param[1] != 0) {
+		pr_info("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
+		goto init_fail;
+	}
 	etd->fw_version_maj = param[0];
 	etd->fw_version_min = param[2];


Arjan

