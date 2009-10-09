From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 4/6] Haptic: add haptic configuration (v2)
Date: Fri, 9 Oct 2009 14:59:19 +0530
Message-ID: <5d5443650910090229mb3baf06we208c07200003f77@mail.gmail.com>
References: <20091009085847.GA24918@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:34886 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZJIJa0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 05:30:26 -0400
In-Reply-To: <20091009085847.GA24918@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Kyungmin,

On Fri, Oct 9, 2009 at 2:28 PM, Kyungmin Park <kyungmin.park@samsung.co=
m> wrote:
> haptic class support
>
> Changelog v1:
> =A0 =A0 =A0 =A0Fix typo
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/Kconfig =A0| =A0 =A02 ++
> =A0drivers/Makefile | =A0 =A01 +
> =A02 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 48bbdbe..a44348e 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -90,6 +90,8 @@ source "drivers/memstick/Kconfig"
>
> =A0source "drivers/leds/Kconfig"
>
> +source "drivers/haptic/Kconfig"
> +
> =A0source "drivers/accessibility/Kconfig"
>
> =A0source "drivers/infiniband/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 6ee53c7..ee6f438 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -94,6 +94,7 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 +=3D idle/
> =A0obj-$(CONFIG_MMC) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mmc/
> =A0obj-$(CONFIG_MEMSTICK) =A0 =A0 =A0 =A0 +=3D memstick/
> =A0obj-$(CONFIG_NEW_LEDS) =A0 =A0 =A0 =A0 +=3D leds/
> +obj-$(CONFIG_HAPTIC) =A0 =A0 =A0 =A0 =A0 +=3D haptic/
> =A0obj-$(CONFIG_INFINIBAND) =A0 =A0 =A0 +=3D infiniband/
> =A0obj-$(CONFIG_SGI_SN) =A0 =A0 =A0 =A0 =A0 +=3D sn/
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D firm=
ware/

Reviewed-by: Trilok Soni <soni.trilok@gmail.com>


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
