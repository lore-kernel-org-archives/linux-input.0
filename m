From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH V2] Input: define KEY_WWAN for Wireless WAN
Date: Tue, 10 Dec 2013 20:36:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312102036250.1413@pobox.suse.cz>
References: <1385664173-18879-1-git-send-email-zajec5@gmail.com> <1386671349-16337-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51284 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3LJTgp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 14:36:45 -0500
In-Reply-To: <1386671349-16337-1-git-send-email-zajec5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc: linux-input@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 10 Dec 2013, Rafa=C5=82 Mi=C5=82ecki wrote:

> Some devices with support for mobile networks may have buttons for
> enabling/disabling such connection. An example can be Linksys router
> 54G3G.
> We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sense
> to add KEY_WWAN as well.
> As we already have KEY_WIMAX, use it's value for KEY_WWAN and make it=
 an
> alias.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> ---
> V2: Re-use 246 value for WWAN and make WIMAX an aliast to WWAN
> ---
>  include/uapi/linux/input.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a372627..7c69941 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -464,7 +464,8 @@ struct input_keymap_entry {
>  #define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
>  #define KEY_DISPLAY_OFF		245	/* display device to off state */
> =20
> -#define KEY_WIMAX		246
> +#define KEY_WWAN		246	/* Wireless WAN (LTE, UMTS, GSM, etc.) */
> +#define KEY_WIMAX		KEY_WWAN
>  #define KEY_RFKILL		247	/* Key that controls all radios */
> =20
>  #define KEY_MICMUTE		248	/* Mute / unmute the microphone */

Adding Dmitry to CC

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
