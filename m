From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 05/12] HID: hid-lg4ff: Update a warning message for a
 case where device is incorrectly flagged to be handled by hid-lg4ff in
 hid-lg.
Date: Tue, 31 Mar 2015 16:38:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1503311638080.21441@pobox.suse.cz>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net> <1426938462-884-6-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48518 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522AbbCaOio (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 10:38:44 -0400
In-Reply-To: <1426938462-884-6-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org

On Sat, 21 Mar 2015, Michal Mal=C3=BD wrote:

> The original warning message was highly misleading. This warning can =
be
> triggered only if a device is flagged to be handled by hid-lg4ff in
> hid-lg but hid-lg4ff lacks support for such device.
>=20
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
> ---
>  drivers/hid/hid-lg4ff.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index d1d5d45..a2f47ee 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -1021,8 +1021,7 @@ int lg4ff_init(struct hid_device *hid)
>  	}
> =20
>  	if (i =3D=3D ARRAY_SIZE(lg4ff_devices)) {
> -		hid_err(hid, "Device is not supported by lg4ff driver. If you thin=
k it should be, consider reporting a bug to"
> -			     "LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madc=
atxster@gmail.com>\n");
> +		hid_err(hid, "This device is flagged to be handled by the lg4ff mo=
dule but this module does not know how to handle it. Please report this=
 as a bug to LKML, Simon Wood <simon@mungewell.org> or Michal Maly <mad=
catxster@devoid-pointer.net>\n");

Could you please split this so that we don't have this ugly overly long=
=20
line, and resend this patch as v2? Thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
