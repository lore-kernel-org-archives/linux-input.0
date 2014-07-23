From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] synaptics: Add min/max quirk for pnp-id LEN2002 (Edge
 E531)
Date: Tue, 22 Jul 2014 23:08:01 -0700
Message-ID: <20140723060801.GC25004@core.coreip.homeip.net>
References: <1404211212-10382-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404211212-10382-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 01, 2014 at 12:40:12PM +0200, Hans de Goede wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1114768
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 75a5154..84c72f6 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -132,7 +132,8 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
>  		1232, 5710, 1156, 4696
>  	},
>  	{
> -		(const char * const []){"LEN0034", "LEN0036", "LEN2004", NULL},
> +		(const char * const []){"LEN0034", "LEN0036", "LEN2002",
> +					"LEN2004", NULL},
>  		1024, 5112, 2024, 4832
>  	},
>  	{
> @@ -168,7 +169,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
>  	"LEN0049",
>  	"LEN2000",
>  	"LEN2001", /* Edge E431 */
> -	"LEN2002",
> +	"LEN2002", /* Edge E531 */
>  	"LEN2003",
>  	"LEN2004", /* L440 */
>  	"LEN2005",
> -- 
> 2.0.0
> 

-- 
Dmitry
