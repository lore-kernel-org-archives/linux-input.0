From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:mouse:psmouse-base - Change 1 to true for bool
 type variable.
Date: Tue, 26 May 2015 14:43:02 -0700
Message-ID: <20150526214302.GA10343@dtor-ws>
References: <1432573888-3070-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432573888-3070-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 25, 2015 at 10:41:28PM +0530, Shailendra Verma wrote:
> The variable psmouse_smartscroll is bool type so assigning true
> instead of 1.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/psmouse-base.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 5bb1658..7c4ba43 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -63,7 +63,7 @@ static unsigned int psmouse_rate = 100;
>  module_param_named(rate, psmouse_rate, uint, 0644);
>  MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
>  
> -static bool psmouse_smartscroll = 1;
> +static bool psmouse_smartscroll = true;
>  module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
>  MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
>  
> -- 
> 1.7.9.5
> 

-- 
Dmitry
