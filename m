From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: devices.txt: remove the mk712
 touchscreen device from the list
Date: Tue, 29 May 2018 15:58:56 -0700
Message-ID: <20180529225856.GE167092@dtor-ws>
References: <20180402125551.13641-1-martink@posteo.de>
 <20180402125551.13641-2-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180402125551.13641-2-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, logang@deltatee.com, stefanha@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 02, 2018 at 02:55:51PM +0200, Martin Kepplinger wrote:
> The input/touchscreen/mk712.c driver has been rewritten for the common
> input event system. in 2005. There shouldn't a special device node be
> created anymore.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Jon, can you please pick it up?

> ---
> 
> Please review this by looking at the driver too. Thanks,
> 
>                     martin
> 
> 
> 
>  Documentation/admin-guide/devices.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 4ec843123cc3..fb39bbf0789a 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -259,7 +259,6 @@
>  		 11 = /dev/vrtpanel	Vr41xx embedded touch panel
>  		 13 = /dev/vpcmouse	Connectix Virtual PC Mouse
>  		 14 = /dev/touchscreen/ucb1x00  UCB 1x00 touchscreen
> -		 15 = /dev/touchscreen/mk712	MK712 touchscreen
>  		128 = /dev/beep		Fancy beep device
>  		129 =
>  		130 = /dev/watchdog	Watchdog timer port
> -- 
> 2.16.2
> 

-- 
Dmitry
