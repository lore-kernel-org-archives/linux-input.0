From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xen-kbdfront - mark expected switch fall-through
Date: Tue, 16 Oct 2018 17:12:06 -0700
Message-ID: <20181017001206.GH230131@dtor-ws>
References: <20181008140748.GA10114@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008140748.GA10114@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 08, 2018 at 04:07:48PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I placed the "fall through"
> part at the beginning of the code comment, which is what GCC is
> expecting to find.
> 
> Addresses-Coverity-ID: 114757 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/misc/xen-kbdfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 594f72e..24bc5c5 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -524,7 +524,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>  	case XenbusStateClosed:
>  		if (dev->state == XenbusStateClosed)
>  			break;
> -		/* Missed the backend's CLOSING state -- fallthrough */
> +		/* fall through - Missed the backend's CLOSING state */
>  	case XenbusStateClosing:
>  		xenbus_frontend_closed(dev);
>  		break;
> -- 
> 2.7.4
> 

-- 
Dmitry
