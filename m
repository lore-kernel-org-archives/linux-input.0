From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: xilinx_ps2: Add missing of_address.h header
Date: Thu, 14 Jul 2011 00:27:12 +0900
Message-ID: <CACxGe6vRZ4tCALpzFng2y9W_9zB3qQEntma+z292FXzDuYBRKQ@mail.gmail.com>
References: <1310564781-5979-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34604 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab1GMP1d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 11:27:33 -0400
In-Reply-To: <1310564781-5979-1-git-send-email-monstr@monstr.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Wed, Jul 13, 2011 at 10:46 PM, Michal Simek <monstr@monstr.eu> wrote=
:
> Add missing header.
>
> Error log:
> CC =A0 =A0 =A0drivers/input/serio/xilinx_ps2.o
> drivers/input/serio/xilinx_ps2.c: In function 'xps2_of_probe':
> drivers/input/serio/xilinx_ps2.c:249: error: implicit declaration of =
function 'of_address_to_resource'
>
> Signed-off-by: Michal Simek <monstr@monstr.eu>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/input/serio/xilinx_ps2.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/x=
ilinx_ps2.c
> index 80baa53..d64c5a4 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -23,7 +23,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/list.h>
> =A0#include <linux/io.h>
> -
> +#include <linux/of_address.h>
> =A0#include <linux/of_device.h>
> =A0#include <linux/of_platform.h>
>
> --
> 1.5.5.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
