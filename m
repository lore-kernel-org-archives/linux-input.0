From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v2] MAINTAINERS: add PhoenixRC Flight Controller
 Adapter
Date: Wed, 8 Aug 2018 11:22:14 -0700
Message-ID: <20180808182214.GB28444@dtor-ws>
References: <20180622170605.8411-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622170605.8411-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 22, 2018 at 07:06:05PM +0200, Marcus Folkesson wrote:
> Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
> 
> Notes:
>     v2:
>     	Add proper mailing list
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce5062dc028..d8b5d9f810e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11103,6 +11103,13 @@ S:	Maintained
>  F:	include/linux/personality.h
>  F:	include/uapi/linux/personality.h
>  
> +PHOENIX RC FLIGHT CONTROLLER ADAPTER
> +M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/input/devices/pxrc.rst
> +F:	drivers/input/joystick/pxrc.c
> +
>  PHONET PROTOCOL
>  M:	Remi Denis-Courmont <courmisch@gmail.com>
>  S:	Supported
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
