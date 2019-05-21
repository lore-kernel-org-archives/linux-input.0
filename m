From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: synaptics - remove X240 from the topbuttonpad
 list
Date: Mon, 20 May 2019 22:08:50 -0700
Message-ID: <20190521050850.GC183429@dtor-ws>
References: <20190519072711.2592-1-aaron.ma@canonical.com>
 <20190519072711.2592-2-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190519072711.2592-2-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, Christopher Heiny <Cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Aaron,

On Sun, May 19, 2019 at 03:27:11PM +0800, Aaron Ma wrote:
> Lenovo ThinkPad X240 does not have the top software button.
> When this wrong ID in top button list, smbus mode will fail to probe,
> so keep it working at PS2 mode.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/synaptics.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index b6da0c1267e3..6ae7bc92476b 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -140,7 +140,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
>  	"LEN002E",
>  	"LEN0033", /* Helix */
>  	"LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
> -	"LEN0035", /* X240 */

According to the history this came from Synaptics through Hans, so I'd
like to make sure there are no several X240 versions floating around...

>  	"LEN0036", /* T440 */
>  	"LEN0037", /* X1 Carbon 2nd */
>  	"LEN0038",
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
