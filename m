From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH TRIVIAL 1/5] Input: keyboard: use macro module_platform_driver()
Date: Tue, 22 Nov 2011 10:23:06 +0100
Message-ID: <CACRpkdadvJN2P-imOmNFMiYHTh6Vkoadbd4SEyWNQi76kAoVUw@mail.gmail.com>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw>
	<1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 22, 2011 at 10:00 AM, JJ Ding <jj_ding@emc.com.tw> wrote:

> Commit 940ab88962bc1aff3273a8356d64577a6e386736 introduced a new macr=
o to
> save some platform_driver boilerplate code. Use it.
>
> Signed-off-by: JJ Ding <dgdunix@gmail.com>
(...)
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/in=
put/keyboard/nomadik-ske-keypad.c
> index fcdec5e..6c4828f 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -390,18 +390,7 @@ struct platform_driver ske_keypad_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ske_keypad_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ske_keypad_remove),
> =A0};
> -
> -static int __init ske_keypad_init(void)
> -{
> - =A0 =A0 =A0 return platform_driver_probe(&ske_keypad_driver, ske_ke=
ypad_probe);
> -}
> -module_init(ske_keypad_init);
> -
> -static void __exit ske_keypad_exit(void)
> -{
> - =A0 =A0 =A0 platform_driver_unregister(&ske_keypad_driver);
> -}
> -module_exit(ske_keypad_exit);
> +module_platform_driver(ske_keypad_driver);
>
> =A0MODULE_LICENSE("GPL v2");
> =A0MODULE_AUTHOR("Naveen Kumar <naveen.gaddipati@stericsson.com> / Su=
ndar Iyer <sundar.iyer@stericsson.com>");

This actually also fixes a bug since platform_driver_probe() was used e=
ven
though there is a .probe member in the driver struct, so thanks.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
