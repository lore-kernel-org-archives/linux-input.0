From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: elantech - enable middle button support on 2
 ThinkPads
Date: Mon, 20 May 2019 22:10:53 -0700
Message-ID: <20190521051053.GD183429@dtor-ws>
References: <20190519072711.2592-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190519072711.2592-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

Hi Aaron,

On Sun, May 19, 2019 at 03:27:10PM +0800, Aaron Ma wrote:
> Adding 2 new touchpad PNPIDs to enable middle button support.

Could you add their names in the comments please?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/elantech.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index a7f8b1614559..530142b5a115 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
>  	"LEN2132", /* ThinkPad P52 */
>  	"LEN2133", /* ThinkPad P72 w/ NFC */
>  	"LEN2134", /* ThinkPad P72 */
> +	"LEN0407",
> +	"LEN0408",

These should come first - I'd like to keep the list sorted
alphabetically.

>  	NULL
>  };
>  
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
