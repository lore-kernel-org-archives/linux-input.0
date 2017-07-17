From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 09/11] iio: orientation: hid-sensor-rotation: Drop
 unnecessary static
Date: Mon, 17 Jul 2017 21:45:31 +0100
Message-ID: <20170717214531.6fbc6cfa@kernel.org>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
        <1500149266-32357-10-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-10-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiri Kosina <jikos@kernel.org>, keescook@chromium.org, kernel-janitors@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 15 Jul 2017 22:07:44 +0200
Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Drop static on a local variable, when the variable is initialized before
> any possible use.  Thus, the static has no benefit.
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
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> ---
> These patches are all independent of each other.
> 
>  drivers/iio/orientation/hid-sensor-rotation.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -238,7 +238,7 @@ static int dev_rot_parse_report(struct p
>  static int hid_dev_rot_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	static char *name;
> +	char *name;
>  	struct iio_dev *indio_dev;
>  	struct dev_rot_state *rot_state;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> 

