From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH trivial] input: apanel: remove a redundant MODULE_ALIAS
Date: Mon, 29 Aug 2011 15:07:14 -0700
Message-ID: <201108291507.14497.dmitry.torokhov@gmail.com>
References: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55886 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754747Ab1H2WHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 18:07:55 -0400
In-Reply-To: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, Stephen Hemminger <shemminger@linux-foundation.org>, linux-kernel@vger.kernel.org

On Monday, August 29, 2011 02:26:29 PM Jonathan Neusch=C3=A4fer wrote:
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  drivers/input/misc/apanel.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.=
c
> index a8d2b8d..1dd1bd3 100644
> --- a/drivers/input/misc/apanel.c
> +++ b/drivers/input/misc/apanel.c
> @@ -346,5 +346,4 @@ MODULE_DESCRIPTION(APANEL_NAME " driver");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(APANEL_VERSION);
>=20
> -MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
>  MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
                                        ^

Not necessarily redundant, if you notice the register is different.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
