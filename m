From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - adjust min/max for Lenovo ThinkPad X1
 Carbon 2nd
Date: Mon, 19 Jan 2015 16:38:07 -0800
Message-ID: <20150120003807.GB29820@dtor-glaptop>
References: <20150119093251.GA28865@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150119093251.GA28865@jelly.redhat.com>
Sender: stable-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Bjoern Olausson <bjoern@olausson.de>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 19, 2015 at 07:32:51PM +1000, Peter Hutterer wrote:
> LEN0037 found in the Lenovo ThinkPad X1 Carbon 2nd (2014 model)
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Bjoern Olausson <bjoern@olausson.de>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index f947292..23e26e0 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -135,8 +135,9 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
>  		1232, 5710, 1156, 4696
>  	},
>  	{
> -		(const char * const []){"LEN0034", "LEN0036", "LEN0039",
> -					"LEN2002", "LEN2004", NULL},
> +		(const char * const []){"LEN0034", "LEN0036", "LEN0037",
> +					"LEN0039", "LEN2002", "LEN2004",
> +					NULL},
>  		1024, 5112, 2024, 4832
>  	},
>  	{
> @@ -165,7 +166,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
>  	"LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
>  	"LEN0035", /* X240 */
>  	"LEN0036", /* T440 */
> -	"LEN0037",
> +	"LEN0037", /* X1 Carbon 2nd */
>  	"LEN0038",
>  	"LEN0039", /* T440s */
>  	"LEN0041",
> -- 
> 2.1.0
> 

-- 
Dmitry
