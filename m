From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 4/6] Haptic: add haptic configuration
Date: Wed, 7 Oct 2009 12:38:42 +0530
Message-ID: <5d5443650910070008w5520890die68747bf5f0a9f13@mail.gmail.com>
References: <20091007061814.GA7596@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758493AbZJGHJV@vger.kernel.org>
In-Reply-To: <20091007061814.GA7596@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Kyungmin,

On Wed, Oct 7, 2009 at 11:48 AM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> haptic class support
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
> +obj-$(CONFIG_HAPTCI) =A0 =A0 =A0 =A0 =A0 +=3D haptic/

s/CONFIG_HAPTCI/CONFIG_HAPTIC :)

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
