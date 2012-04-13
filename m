From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: lg4ff: Take advantage of private driver data
Date: Fri, 13 Apr 2012 14:59:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204131459480.16373@pobox.suse.cz>
References: <1649210.pcO5IpzBEF@qosmio-x300>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41309 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074Ab2DMM77 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 08:59:59 -0400
In-Reply-To: <1649210.pcO5IpzBEF@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Mon, 9 Apr 2012, Michal Mal=FD wrote:

> Hi,
>=20
> this is a revised version of HID: lg4ff: Use Private Data I asked Sim=
on to
> submit for me earlier. To recap what the patch is about, it takes adv=
antage
> of the changes introduced in my patches from 2011/04/02. lg4ff now ca=
lls
> hid_get/set_drvdata() to read or store device configuration. The way =
I understand
> it, this is how all HID drivers store their private data. The change =
from the version
> that was submitted earlier are removed all occurences of uninitialize=
d_var() macro.
>=20
> Please note that this patch depends on
> "[PATCH v4] HID: hid-lg: Allow for custom device-specific properties =
to be stored in private drv data"
> "[PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating memory=
"
>=20
> Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
