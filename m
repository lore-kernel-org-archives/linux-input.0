From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Add short KEY_DIRECTION description
Date: Wed, 4 Mar 2015 22:56:28 +0100
Message-ID: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
References: <a7e525e6-b0a2-4329-99fd-21c0af989d8e@HUB1.rwth-ad.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38357 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbCDV4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 16:56:30 -0500
In-Reply-To: <a7e525e6-b0a2-4329-99fd-21c0af989d8e@HUB1.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?Stefan_Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Cc: "<linux-input@vger.kernel.org>" <linux-input@vger.kernel.org>

I need the same key in my Thinkpad patch. But could you use a more desc=
riptive name, such as KEY_ROTATE_DISPLAY?



> On 4 Mar 2015, at 22:42, Stefan Br=C3=BCns <stefan.bruens@rwth-aachen=
=2Ede> wrote:
>=20
> Signed-off-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
> ---
> Requested 5 years ago: https://lkml.org/lkml/2010/2/27/36
> See also http://comments.gmane.org/gmane.linux.kernel.input/11175
>=20
> include/uapi/linux/input.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a1d7e93..0655300 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -368,7 +368,7 @@ struct input_keymap_entry {
> #define KEY_MSDOS        151
> #define KEY_COFFEE        152    /* AL Terminal Lock/Screensaver */
> #define KEY_SCREENLOCK        KEY_COFFEE
> -#define KEY_DIRECTION        153
> +#define KEY_DIRECTION        153     /* Display orientation for e.g.=
 tablets */
> #define KEY_CYCLEWINDOWS    154
> #define KEY_MAIL        155
> #define KEY_BOOKMARKS        156    /* AC Bookmarks */
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
