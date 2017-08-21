From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Mon, 21 Aug 2017 09:15:53 +0200
Message-ID: <20170821071553.GD28808@mail.corp.redhat.com>
References: <20170818193436.GA31365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818193436.GA31365@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Aug 18 2017 or thereabouts, Dmitry Torokhov wrote:
> The touchpad on Lenovo Carbon X1 Gen 5 (2017 - Kabylake) is accessible over
> SMBUS/RMI, so let's activate it by default.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 9a8d81efd329..248c7c9dcbaa 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -172,6 +172,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0048", /* X1 Carbon 3 */
>  	"LEN0046", /* X250 */
>  	"LEN004a", /* W541 */
> +	"LEN0072", /* X1 Carbon Gen 5 (2017) */
>  	"LEN200f", /* T450s */
>  	NULL
>  };
> -- 
> 2.14.1.480.gb18f417b89-goog
> 
> 
> -- 
> Dmitry
