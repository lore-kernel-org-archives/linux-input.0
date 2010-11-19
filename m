From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] da850-evm: add baseboard UI expander buttons,
 switches and LEDs
Date: Fri, 19 Nov 2010 09:02:32 -0800
Message-ID: <20101119170232.GB6236@core.coreip.homeip.net>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
 <cover.1289935504.git.bengardiner@nanometrics.ca>
 <d6d59b4a3c34149008f3681e0d6106efa15f354d.1289935504.git.bengardiner@nanometrics.ca>
 <B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
 <AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:38156 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab0KSRCm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 12:02:42 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Ben,

On Fri, Nov 19, 2010 at 10:40:50AM -0500, Ben Gardiner wrote:
>=20
> >> +
> >> +static struct gpio_keys_platform_data user_sw_gpio_key_platform_d=
ata =3D {
> >> + =A0 =A0 .buttons =3D user_sw_gpio_keys,
> >> + =A0 =A0 .nbuttons =3D ARRAY_SIZE(user_sw_gpio_keys),
> >> + =A0 =A0 .rep =3D 0, /* disable auto-repeat */
> >> + =A0 =A0 .poll_interval =3D DA850_SW_POLL_MS,
> >> +};
> >
> > I wonder if we really have create to separate platform data
> > for switches and push buttons. If it is only the debounce period
> > that is different, it can be handled by initializing that field
> > differently.
>=20
> I see. Good idea; we can declare an array of gpio_keys_platform_data.
>=20
> Note; it is the polling interval which differs, not the debounce inte=
rval.

Another question is why do you want to poll the same device at
different intervals? The processor is already woken up so it makes sens=
e
to do as much as possible instead of going to sleep. In your case
200/700 for every 1400ms interval you wake an extra time to poll
switches so unless polling switches takes very long time it is better t=
o
combine them together (and into one input device, probably).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
