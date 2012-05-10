From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] TWL6040: fix build error
Date: Thu, 10 May 2012 18:49:16 -0400
Message-ID: <CAP=VYLqwAO8x4aWw7_pH1LH_SPO9Td2ec9oOmKPL-_5LOEQw3g@mail.gmail.com>
References: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57025 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554Ab2EJWts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 18:49:48 -0400
In-Reply-To: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: dmitry.torokhov@gmail.com, peter.ujfalusi@ti.com, broonie@opensource.wolfsonicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 10, 2012 at 2:44 PM, Sasha Levin <levinsasha928@gmail.com> =
wrote:
> Fixes build error due to missing of_property_read_u32.

Yes, I saw the same on x86-64 allyesconfig -- which means that in addit=
ion to
this missing header, it needs to have a Kconfig dependency that limits
it to just being enabled on the platforms where it physically is possib=
le to
have the hardware.  I'm guessing limiting to ARM would be a good start?

Thanks,
Paul.
--

>
> Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
> ---
> =A0drivers/input/misc/twl6040-vibra.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/=
twl6040-vibra.c
> index bb134ce..97447ee 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -27,6 +27,7 @@
> =A0*/
> =A0#include <linux/module.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/of.h>
> =A0#include <linux/of_device.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/input.h>
> --
> 1.7.8.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
