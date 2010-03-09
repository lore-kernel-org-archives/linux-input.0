From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] HID: N-trig MTM Driver fix and cleanup patch 1
Date: Tue, 9 Mar 2010 00:43:57 -0800
Message-ID: <20100309084357.GI17288@core.coreip.homeip.net>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:44555 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0CIIoD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 03:44:03 -0500
Content-Disposition: inline
In-Reply-To: <1268082827-2680-1-git-send-email-micki@n-trig.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mickib1@gmail.com
Cc: jkosina@suse.cz, rafi@seas.upenn.edu, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 08, 2010 at 11:13:41PM +0200, mickib1@gmail.com wrote:
> From: micki <micki@micki-laptop.(none)>
>=20
> Add Change Log and defines of MTM firmware.
> Add debug Paramater change Driver name in hid_driver structure
>=20

---------------------------------------

> N-trig is changing the way people interact with computers by providin=
g a dual-mode pen and true multi-touch input device, specifically desig=
ned for today's advanced computing world.
> N-trig DuoSense=AE solution provides a real Hands-on computing=AE exp=
erience, and sets the stage for OEMs and ISVs to introduce innovative c=
omputer products and applications for an intuitive, Hands-on=AE experie=
nce directly onscreen.
> DuoSense digitizers are easily integrated into existing technologies,=
 support all LCDs, keep devices slim and light, and can be implemented =
in a broad range of products, ranging from small notebooks to large LCD=
s.
> N-trig has offices in Israel, the US, Taiwan and Japan.
>=20

----------------------------------------

The above certainly does not belong to kernel changelog.

> Signed-off-by: Micki Balanga <micki@n-trig.com>
> ---
>  drivers/hid/hid-ntrig.c |   94 +++++++++++++++++++++++++++++++++++++=
+++++++--
>  1 files changed, 89 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 3234c72..e99342d 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -3,7 +3,18 @@
>   *
>   *  Copyright (c) 2008 Rafi Rubin
>   *  Copyright (c) 2009 Stephane Chatty
> + *  Copyright (c) 2010 N-TRIG
>   *
> + *	1.0 - Rafi Rubin ( Version From 2010-02-13 02:13:05)
> + *		This cleans up the identification of multitouch
> + *		groups and enables the end of group sync.
> + *		Taps are now explicitly handled to adjust for the changes in the
> + *		event stream in multitouch mode.
> + *		Added triple and quad tap for the benefit of
> + *		tools that recognize different tap types but
> + *		do not have full multi touch support.
> + *	1.1 - N-trig - Add Change Log and defines of MTM firmware.
> + *		Add debug Paramater change Driver name in hid_driver structure

No need to keep changelog in the file, we have scm for a reason.

Also, all patches split in a wied fashion, being not really useable on
their own. For exapmple thi spatch adds ntrig_dbg but no users for this
facility.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
