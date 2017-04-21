From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 3/5] MAINTAINERS: add Atmel PTC entries
Date: Fri, 21 Apr 2017 11:56:36 +0200
Message-ID: <20170421095636.a4gkkdrug5ezo3yk@rfolt0960.corp.atmel.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
 <20170421083924.15096-4-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170421083924.15096-4-ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 21, 2017 at 10:39:22AM +0200, Ludovic Desroches wrote:
> Add entries for the Atmel PTC Subsystem.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 860dacb..e1b8b0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2323,6 +2323,13 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
>  F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  F:	include/linux/platform_data/atmel_mxt_ts.h
>  
> +ATMEL PTC SUBSYSTEM DRIVER
> +M:	Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> +L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Supported
> +F:	drivers/input/misc/atmel_ptc.c
> +F:	include/uapi/linux/atmel_ptc.h

I'll remove it in v3.

> +
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers-hoWRoavIt3ZWk0Htik3J/w@public.gmane.org>
>  L:	linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> -- 
> 2.9.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
