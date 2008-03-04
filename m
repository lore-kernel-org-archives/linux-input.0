From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 14:47:15 +0200
Message-ID: <20080304124715.GK8473@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:57010 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbYCDMrR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 07:47:17 -0500
Content-Disposition: inline
In-Reply-To: <200802161622.43223.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Sat, Feb 16, 2008 at 04:22:43PM +0000, Peter Stokes wrote:
> The attached patch reconfigures the ati_remote2 driver to use soft-au=
torepeat=20
> functionality and adds support for loadable key maps.

Why was this submitted (and even accepted) without cc:ing me?

> I have reconfigure the driver to use the input system's built-in auto=
repeat=20
> functionality as the device only appears to be able to produce key re=
peat=20
> notifications at a fixed period. Switching to the software autorepeat=
=20
> functionality provides more precise configuration of the timings requ=
ested=20
> for repeat-delay and repeat-rate.

The soft-autorepeat support should be split into a separate patch. I do=
n't
need such fast repeat but if it helps people I'm fine with it.

> As this device is exposed as a combined keyboard and mouse, this chan=
ge=20
> somewhat depends upon the suggested modification to the core soft-aut=
orepeat=20
> functionality as outlined in my previous post to the linux-input mail=
ing list=20
> (on 12th Feb 2008 entitled "Soft-autorepeat functionality"), without =
that=20
> modification, the mouse buttons are autorepeated :-(
>=20
> The loadable keymap support exposes the ability to map 5 separate key=
codes to=20
> each key (depending on which "mode" the remote control is currently i=
n).=20
> Additionally, I have attempted to ensure that the scancodes used to m=
ap=20
> keycodes to the keys lie outside of the range normally covered by reg=
ular=20
> keyboards so as to avoid requests to remap the keys on the remote fro=
m being=20
> intercepted by a normal keyboard.

I thought the idea of input devices was to reflect the hardware and the
keymaps should be handled in userspace. If that's not the case then I t=
hink
the keymap support code should not be inside the driver but instead ins=
ide
the input core. We don't want such invasive changes in every driver do
we?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
