From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Mon, 12 Oct 2009 11:27:28 -0700
Message-ID: <874oq4sc1b.fsf@deeprootsystems.com>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1255109225-6833-1-git-send-email-miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
	(miguel aguilar's message of "Fri\, 9 Oct 2009 11\:27\:05 -0600")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org

<miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org> writes:

> From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
>
> Adds the driver for enabling keypad support for DaVinci platforms.
>
> DM365 is the only platform that uses this driver at the moment.
>
> Signed-off-by: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/mach-davinci/include/mach/keyscan.h |   44 ++++
>  drivers/input/keyboard/Kconfig               |   10 +
>  drivers/input/keyboard/Makefile              |    1 +
>  drivers/input/keyboard/davinci_keyscan.c     |  338 ++++++++++++++++++++++++++
>  4 files changed, 393 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-davinci/include/mach/keyscan.h
>  create mode 100644 drivers/input/keyboard/davinci_keyscan.c
>
> diff --git a/arch/arm/mach-davinci/include/mach/keyscan.h b/arch/arm/mach-davinci/include/mach/keyscan.h
> new file mode 100644
> index 0000000..dd84361
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/keyscan.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2009 Texas Instruments, Inc
> + *
> + * Author: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef DAVINCI_KEYSCAN_H
> +#define DAVINCI_KEYSCAN_H
> +
> +#include <linux/io.h>
> +
> +/* Base of key scan register bank */
n> +#define DM365_KEYSCAN_BASE		(0x01C69400)

This base address is not used in the driver code and is SoC specific.  

You've already defined it in PATCH 2/2 in the SoC specific files which
is the right place.

Kevin
