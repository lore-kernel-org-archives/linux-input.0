From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen:
 goodix: Document vcc-supply property
Date: Mon, 3 Dec 2018 18:41:39 +0800
Message-ID: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com> <20181203101547.16835-5-jagan@amarulasolutions.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBB4UQSTQAKGQEIJQ4BBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20181203101547.16835-5-jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.

"External pull-up regulator" sounds fishy. Chips have power supply
pins, either combined, or separate rails for analog, digital, and I/O.
For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
and description you provide match none of these.

If a regulator is needed for pull-up resistors on the I2C bus, this
should be referenced in either the I2C bus master node, or if the I2C
bus goes through a pin controller, in the pin controller node.

Putting the reference in the slave device node is wrong, since it
doesn't actually use it. It becomes even clearer when you have multiple
slaves on the same bus, and you reference the same regulator in all
of them.

Or, as a last resort, you could mark it as always-on with a TODO note.

ChenYu


> So, document the same as optional property.
>
> Signed-off-by: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..604766e347ce 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,7 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - vcc-supply          : 3v3 regulator phandle for controller VCC pin
>
>  Example:
>
> --
> 2.18.0.321.gffc6fa0e3
>
