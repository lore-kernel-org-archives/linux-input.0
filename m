From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: applespi - use struct_size() helper
Date: Tue, 6 Aug 2019 09:04:00 -0700
Message-ID: <20190806160400.GC178933@dtor-ws>
References: <20190806000638.GA4827@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806000638.GA4827@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 05, 2019 at 07:06:38PM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct touchpad_protocol {
> 	...
>         struct tp_finger        fingers[0];
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(*tp) + tp->number_of_fingers * sizeof(tp->fingers[0]);
> 
> with:
> 
> struct_size(tp, fingers, tp->number_of_fingers)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/applespi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index acf34a5ff571..584289b67fb3 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1494,8 +1494,7 @@ static void applespi_got_data(struct applespi_data *applespi)
>  		size_t tp_len;
>  
>  		tp = &message->touchpad;
> -		tp_len = sizeof(*tp) +
> -			 tp->number_of_fingers * sizeof(tp->fingers[0]);
> +		tp_len = struct_size(tp, fingers, tp->number_of_fingers);
>  
>  		if (le16_to_cpu(message->length) + 2 != tp_len) {
>  			dev_warn_ratelimited(&applespi->spi->dev,
> -- 
> 2.22.0
> 

-- 
Dmitry
