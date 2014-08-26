From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - suppress message about 'Unknown touchpad'
Date: Tue, 26 Aug 2014 10:20:54 +0200
Message-ID: <53FC4366.7050600@redhat.com>
References: <20140825183031.GA5151@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140825183031.GA5151@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Paul Menzel <paulepanter@users.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 08/25/2014 08:30 PM, Dmitry Torokhov wrote:
> When we fail to match data returned by E7 and EC reports we state that we
> found "Unknown ALPS touchpad" whereas it is most likely it is not ALPS
> touchpad at all. Change wording a bit and reduce the message to debug so
> that it does not litter users logs and confuse them.
> 
> Reported-by: Paul Menzel <paulepanter@users.sourceforge.net>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I noticed this too, and I agree that it is a confusing message:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/input/mouse/alps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index a59a1a6..a956b98 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2234,8 +2234,8 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
>  		return 0;
>  	}
>  
> -	psmouse_info(psmouse,
> -		     "Unknown ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
> +	psmouse_dbg(psmouse,
> +		    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
>  
>  	return -EINVAL;
>  }
> 
