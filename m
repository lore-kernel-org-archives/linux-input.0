From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] iio: hid-sensor-accel-3d: Drop unnecessary static
Date: Sun, 7 May 2017 13:57:01 +0100
Message-ID: <dfd867a9-935f-62f2-f952-6e4ddd33c8e6@kernel.org>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493928654-18768-8-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Content-Language: en-GH
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 04/05/17 21:10, Julia Lawall wrote:
> Drop static on a local variable, when the variable is initialized before
> use, on every possible execution path through the function.  The static has
> no benefit, and dropping it reduces the code size.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> The change in code size is indicates by the following output from the size
> command.
> 
> before:
>    text    data     bss     dec     hex filename
>    3879     512       8    4399    112f drivers/iio/accel/hid-sensor-accel-3d.o
> 
> after:
>    text    data     bss     dec     hex filename
>    3863     512       0    4375    1117 drivers/iio/accel/hid-sensor-accel-3d.o
> 
> Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 43a6cb0..2238a26 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -347,7 +347,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
>  static int hid_accel_3d_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
> -	static const char *name;
> +	const char *name;
>  	struct iio_dev *indio_dev;
>  	struct accel_3d_state *accel_state;
>  	const struct iio_chan_spec *channel_spec;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
