From: Andrey Moiseev <o2g.org.ru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: ti_am33x_tsc: make the documentation for the
 ti,wire-config parameter clear
Date: Tue, 12 Nov 2013 20:35:56 +0400
Message-ID: <CABWXVkO+xG=tF04zt-o9nme=mv02pd+Bbeu_07ji_-LK=iy01g@mail.gmail.com>
References: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384273323-15329-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Maybe "most/least significant" is more clear. Everyone got used to
little-endian, anyway.

On Tue, Nov 12, 2013 at 8:22 PM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> The document says "first four bits" and means the upper nibble. Most
> people would probably agree that the first four bits are bits 0=E2=80=
=A63 and
> that is the lower nibble.
> This patch updates the documentation so it is clear what is meant.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt |=
 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-t=
sc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc=
-adc.txt
> index 491c97b..0fcd430 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.=
txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.=
txt
> @@ -17,8 +17,8 @@
>                                 remaining 4 can be used by the ADC.
>         ti,wire-config: Different boards could have a different order=
 for
>                         connecting wires on touchscreen. We need to p=
rovide an
> -                       8 bit number where in the 1st four bits repre=
sent the
> -                       analog lines and the next 4 bits represent po=
sitive/
> +                       8 bit number where the upper nibble represent=
 the
> +                       analog lines and the lower nibble represent p=
ositive/
>                         negative terminal on that input line. Notatio=
ns to
>                         represent the input lines and terminals resoe=
ctively
>                         is as follows:
> --
> 1.8.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
