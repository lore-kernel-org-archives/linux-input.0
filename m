From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] Input: define KEY_WWAN for Wireless WAN
Date: Sun, 15 Dec 2013 21:02:03 -0800
Message-ID: <20131216050157.GB4322@core.coreip.homeip.net>
References: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
 <1386671349-16337-1-git-send-email-zajec5@gmail.com>
 <alpine.LNX.2.00.1312102036250.1413@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34675 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3LPFCK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 00:02:10 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so5000558pbb.0
        for <linux-input@vger.kernel.org>; Sun, 15 Dec 2013 21:02:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1312102036250.1413@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, linux-input@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>

On Tue, Dec 10, 2013 at 08:36:41PM +0100, Jiri Kosina wrote:
> On Tue, 10 Dec 2013, Rafa=C5=82 Mi=C5=82ecki wrote:
>=20
> > Some devices with support for mobile networks may have buttons for
> > enabling/disabling such connection. An example can be Linksys route=
r
> > 54G3G.
> > We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sen=
se
> > to add KEY_WWAN as well.
> > As we already have KEY_WIMAX, use it's value for KEY_WWAN and make =
it an
> > alias.
> >=20
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> > ---
> > V2: Re-use 246 value for WWAN and make WIMAX an aliast to WWAN
> > ---
> >  include/uapi/linux/input.h |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.=
h
> > index a372627..7c69941 100644
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -464,7 +464,8 @@ struct input_keymap_entry {
> >  #define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
> >  #define KEY_DISPLAY_OFF		245	/* display device to off state */
> > =20
> > -#define KEY_WIMAX		246
> > +#define KEY_WWAN		246	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
> > +#define KEY_WIMAX		KEY_WWAN
> >  #define KEY_RFKILL		247	/* Key that controls all radios */
> > =20
> >  #define KEY_MICMUTE		248	/* Mute / unmute the microphone */
>=20
> Adding Dmitry to CC

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
