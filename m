From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: drop remove Unicode non-breaking space from
 Kconfig
Date: Wed, 11 Jun 2014 10:50:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406111050241.1321@pobox.suse.cz>
References: <1402436136-17918-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402436136-17918-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 10 Jun 2014, Brian Norris wrote:

> There is a UTF-8 non-breaking space character (0xc2 0xa0) after the "=
Y"
> in "Say Y here". This is probably not intentional. Replace it with a
> standard ASCII space (0x20).
>=20
> If you can't see a difference here, I don't blame you :)
>=20
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 800c8b60f7a2..08c9693e6f83 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -785,7 +785,7 @@ config HID_XINMO
>  	depends on HID
>  	---help---
>  	Support for Xin-Mo devices that are not fully compliant with the HI=
D
> -	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y=C2=A0=
here
> +	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y her=
e
>  	if you have a Xin-Mo Dual Arcade controller.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
