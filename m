From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Add alias KEY_ROTATE_DISPLAY for KEY_DIRECTION,
 add description
Date: Thu, 5 Mar 2015 23:54:34 -0800
Message-ID: <20150306075434.GA14237@dtor-ws>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
 <1425511870-3303-1-git-send-email-stefan.bruens@rwth-aachen.de>
 <41beb348-6e52-44bf-923b-68d552ef328b@HUB2.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40896 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbbCFHyj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 02:54:39 -0500
Received: by iecrp18 with SMTP id rp18so15666626iec.7
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2015 23:54:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <41beb348-6e52-44bf-923b-68d552ef328b@HUB2.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: linux-input@vger.kernel.org

On Thu, Mar 05, 2015 at 12:31:09AM +0100, Stefan Br=FCns wrote:
> Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>

Applied, but made KEY_ROTATE_DISPLAY primary.

> ---
>  include/uapi/linux/input.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a1d7e93..47b0138 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -368,7 +368,8 @@ struct input_keymap_entry {
>  #define KEY_MSDOS		151
>  #define KEY_COFFEE		152	/* AL Terminal Lock/Screensaver */
>  #define KEY_SCREENLOCK		KEY_COFFEE
> -#define KEY_DIRECTION		153
> +#define KEY_DIRECTION		153	/* Display orientation for e.g. tablets *=
/
> +#define KEY_ROTATE_DISPLAY	KEY_DIRECTION
>  #define KEY_CYCLEWINDOWS	154
>  #define KEY_MAIL		155
>  #define KEY_BOOKMARKS		156	/* AC Bookmarks */
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
