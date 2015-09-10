From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] devicetree: bindings: Update
 gpio-keys-polled with support for abs/rel axis
Date: Thu, 10 Sep 2015 12:45:35 -0500
Message-ID: <55F1C1BF.40207@kernel.org>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
Reply-To: robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD62P6P6EQIMDA6HV4CRUBF3PEL3M-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1441789886-5868-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/09/2015 04:11 AM, Hans de Goede wrote:
> The devicetree binding for gpio-keys-polled already allows specifying
> what type of events (key / rel / abs) a button generates when pressed.
> 
> But for rel / abs axis we also need to specify which value this specific
> gpio represents.
> 
> One usecase is digital joysticks / direction-pads which are hooked up to
> gpio, in this case we've left and right buttons which we want to map to
> EV_ABS, ABS_X and we want generate events for left with a value of -1 and
> for right with a value of +1 (and similar for up / down and ABS_Y).

One minor comment, otherwise:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> index 313abef..ab4b09b 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> @@ -13,11 +13,16 @@ Subnode properties:
>  
>  	- gpios: OF device-tree gpio specification.
>  	- label: Descriptive name of the key.
> -	- linux,code: Keycode to emit.
> +	- linux,code: Key / Axis code to emit.
>  
>  Optional subnode-properties:
>  	- linux,input-type: Specify event type this button/key generates.
>  	  If not specified defaults to <1> == EV_KEY.
> +	- linux,input-value: If linux,input-type is EV_ABS or EV_REL then this
> +	  value is send for events this button generates when pressed.

s/send/sent/

> +	  EV_ABS axis will generate an event with a value of 0 when all
> +	  buttons with linux,input-type == EV_ABS and linux,code == axis
> +	  are released.
>  	- debounce-interval: Debouncing interval time in milliseconds.
>  	  If not specified defaults to 5.
>  	- gpio-key,wakeup: Boolean, button can wake-up the system.
> 
