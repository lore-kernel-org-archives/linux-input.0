From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: mk712: update documentation web link
Date: Tue, 29 May 2018 15:59:28 -0700
Message-ID: <20180529225928.GF167092@dtor-ws>
References: <20180402125551.13641-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180402125551.13641-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, logang@deltatee.com, stefanha@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 02, 2018 at 02:55:50PM +0200, Martin Kepplinger wrote:
> At the mentioned address there's nothing found. By searching information
> on the controller chip still can be found, so update the link to the
> resulting page.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mk712.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mk712.c b/drivers/input/touchscreen/mk712.c
> index bd5352824f77..c179060525ae 100644
> --- a/drivers/input/touchscreen/mk712.c
> +++ b/drivers/input/touchscreen/mk712.c
> @@ -17,7 +17,7 @@
>   * found in Gateway AOL Connected Touchpad computers.
>   *
>   * Documentation for ICS MK712 can be found at:
> - *	http://www.idt.com/products/getDoc.cfm?docID=18713923
> + *	https://www.idt.com/general-parts/mk712-touch-screen-controller
>   */
>  
>  /*
> -- 
> 2.16.2
> 

-- 
Dmitry
