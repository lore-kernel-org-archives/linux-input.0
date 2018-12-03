From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: synaptics - enable SMBus for HP 15-ay000
 (SYN3221).
Date: Mon, 3 Dec 2018 11:26:29 -0800
Message-ID: <20181203192629.GD257010@dtor-ws>
References: <20181116.130459.1796034910024118091.teika@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116.130459.1796034910024118091.teika@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Teika Kazura <teika@gmx.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 16, 2018 at 01:04:59PM +0900, Teika Kazura wrote:
> SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000 series,
> 
> This device has been reported in these messages in the "linux-input" mailing list:
> * https://marc.info/?l=linux-input&m=152016683003369&w=2
> * https://www.spinics.net/lists/linux-input/msg52525.html
> 
> Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
> Reported-by: Teika Kazura <teika@gmx.com>
> Signed-off-by: Teika Kazura <teika@gmx.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d5..591b776f22 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0096", /* X280 */
>  	"LEN0097", /* X280 -> ALPS trackpoint */
>  	"LEN200f", /* T450s */
> +	"SYN3221", /* HP 15-ay000 */
>  	NULL
>  };
> 
> --
> 2.18.1

-- 
Dmitry
