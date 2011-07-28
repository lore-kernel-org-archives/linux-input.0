From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 07/16] HID: wiimote: Parse accelerometer data
Date: Thu, 28 Jul 2011 20:12:25 +0200
Message-ID: <201107282012.25113.oneukum@suse.de>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com> <1311869316-17128-8-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52245 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab1G1SOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:14:11 -0400
In-Reply-To: <1311869316-17128-8-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Donnerstag, 28. Juli 2011, 18:08:27 schrieb David Herrmann:
> +static void handler_accel(struct wiimote_data *wdata, const __u8 *pa=
yload)
> +{
> +       __u16 x, y, z;
> +
> +       if (!(wdata->state.flags & WIIPROTO_FLAG_ACCEL))
> +               return;
> +
> +       /*
> +        * payload is: BB BB XX YY ZZ
> +        * Buttons data contains LSBs
> +        */
> +
> +       x =3D payload[2] << 2;
> +       y =3D payload[3] << 2;
> +       z =3D payload[4] << 2;
> +
> +       x |=3D (payload[0] >> 5) & 0x3;
> +       y |=3D (payload[1] >> 4) & 0x2;
> +       z |=3D (payload[1] >> 5) & 0x2;

Could you make the comments a bit clearer. Those last lines are impossi=
ble
to understand.

	Regards
		Oliver
--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
