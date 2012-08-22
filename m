From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH -next] HID: picoLCD: Add missing #include
 <linux/uaccess.h>
Date: Wed, 22 Aug 2012 16:28:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208221628190.32304@pobox.suse.cz>
References: <1345581683-2099-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33980 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085Ab2HVO2g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 10:28:36 -0400
In-Reply-To: <1345581683-2099-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 21 Aug 2012, Geert Uytterhoeven wrote:

> m68k/allmodconfig:
>=20
> drivers/hid/hid-picolcd_debugfs.c: In function =E2=80=98picolcd_debug=
_reset_write=E2=80=99:
> drivers/hid/hid-picolcd_debugfs.c:54: error: implicit declaration of =
function =E2=80=98copy_from_user=E2=80=99
> drivers/hid/hid-picolcd_debugfs.c: In function =E2=80=98picolcd_debug=
_eeprom_read=E2=80=99:
> drivers/hid/hid-picolcd_debugfs.c:112: error: implicit declaration of=
 function =E2=80=98copy_to_user=E2=80=99
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> http://kisskb.ellerman.id.au/kisskb/buildresult/6990818/
>=20
>  drivers/hid/hid-picolcd_debugfs.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-pico=
lcd_debugfs.c
> index f2491fa..15c22f2 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -27,6 +27,7 @@
>  #include <linux/debugfs.h>
> =20
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
> =20
>  #include "hid-picolcd.h"

Applied, thanks Geert.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
