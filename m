From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for serio device tree
 bindings
Date: Wed, 4 Jul 2018 15:27:26 +0000
Message-ID: <20180704152726.uastaefdyzhlbhau@penguin>
References: <20180622100818.29420-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622100818.29420-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 22, 2018 at 12:08:18PM +0200, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Since nobody else did I'll pick it up, thank you Geert.

> ---
> v3:
>   - Update for next-20180622,
> 
> v2:
>   - Add Acked-by.
> 
> Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/serio/":
> 
> -Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:3/3=100%,authored:1/3=33%)
> -Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/3=33%)
> -Dmitry Torokhov <dmitry.torokhov@gmail.com> (commit_signer:1/3=33%)
> -Danilo Krummrich <danilokrummrich@dk-develop.de> (commit_signer:1/3=33%,authored:1/3=33%)
> -Linus Walleij <linus.walleij@linaro.org> (commit_signer:1/3=33%)
> -Mathieu Malaterre <malat@debian.org> (authored:1/3=33%)
> +Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
> +Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel@vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 464d91879df89fce..df246daab5a27af2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7100,6 +7100,7 @@ F:	include/uapi/linux/input.h
>  F:	include/uapi/linux/input-event-codes.h
>  F:	include/linux/input/
>  F:	Documentation/devicetree/bindings/input/
> +F:	Documentation/devicetree/bindings/serio/
>  F:	Documentation/input/
>  
>  INPUT MULTITOUCH (MT) PROTOCOL
> -- 
> 2.17.1
> 

-- 
Dmitry
