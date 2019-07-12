From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - enable RMI on ThinkPad T580
Date: Thu, 11 Jul 2019 23:45:48 -0700
Message-ID: <20190712064548.GC150689@dtor-ws>
References: <20190711105436.6290-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711105436.6290-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 06:54:36PM +0800, Kai-Heng Feng wrote:
> Like the ThinkPad T560 case, now we can use RMI on T580 to have a more
> responsive touchpad.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I already applied Nick Black'spatch for this, thanks.

> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index b8ec301025b7..eb3f642967ab 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -175,6 +175,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0092", /* X1 Carbon 6 */
>  	"LEN0096", /* X280 */
>  	"LEN0097", /* X280 -> ALPS trackpoint */
> +	"LEN009b", /* T580 */
>  	"LEN200f", /* T450s */
>  	"LEN2054", /* E480 */
>  	"LEN2055", /* E580 */
> -- 
> 2.17.1
> 

-- 
Dmitry
