From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCHv3 5/5] ARM: sunxi: dts: Add note ps2 pins conflict with hdmi
Date: Tue, 16 Dec 2014 23:21:12 +0800
Message-ID: <CAGb2v65OFKkkFTpcDoW3OwToXdgRP6hLVCYY7CR7MYZ-VgckGA@mail.gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
 <1418408748-9797-6-git-send-email-vishnupatekar0510@gmail.com>
 <CAGb2v65xpUhiMzSKu_1+JGNbg3oFdpw2EQ+JGUYkivCtG2O6gw@mail.gmail.com> <CAEzqOZtOycU5LT8b3SHOymMpMOMExGC9PHiZ9wHtAjxR2R5+Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEzqOZtOycU5LT8b3SHOymMpMOMExGC9PHiZ9wHtAjxR2R5+Ew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Sat, Dec 13, 2014 at 11:18 AM, Vishnu Patekar
<vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hello Chen-Yu,
> Thank you for pointing out styling error.
>
> On Sat, Dec 13, 2014 at 7:36 AM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>>
>> Hi,
>>
>> On Sat, Dec 13, 2014 at 2:25 AM, VishnuPatekar
>> <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > 1. Please note that ps20 pins conflict with HDMI on Lime2 Board
>> > so, by deault ps20 and ps21 are disabled for Lime2 Board.
>> > There is no on board ps2 connector and these pins can be used
>> > for different purpose.
>> >
>> > Signed-off-by: VishnuPatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > ---
>> >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |    6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>> > b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>> > index ed364d5..951b615 100644
>> > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>> > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
>> > @@ -112,7 +112,11 @@
>> >                         pinctrl-0 = <&uart0_pins_a>;
>> >                         status = "okay";
>> >                 };
>> > -
>> > +
>> > +               /* PS2 0 and PS2 1 are disabled by default; Please note
>> > that
>> > +               ps20 pins conflict with HDMI on Lime2 Board
>> > +               */
>> > +
>>
>> Multi-line comments should be:
>>
>> /*
>>  * line 1
>>  * line 2
>>  * ...
>>  */
>
> Okie.

So, in fact this patch shouldnt be needed. The LIME2 uses the dedicated
pins for HDMI DDC. PS2 0 pins PI20 and PI21 are in fact routed to
the GPIO-2 header. They are _not_ used for HDMI. Nothing bad should
happen unless you also multiplex PI20/PI21 to HSCL/HDSA.

If you check the schematics Olimex published and trace the HDMI lines,
you will see that this is the case.

ChenYu

>>
>>
>> And why is there a delete and insert for an empty line?
>> Weird... though git seems to ignore it when applying.
>
> I used clean_patch to clear the styling error. that might have modified it.
>
>
>>
>>
>> ChenYu
>>
>> >                 i2c0: i2c@01c2ac00 {
>> >                         pinctrl-names = "default";
>> >                         pinctrl-0 = <&i2c0_pins_a>;
>> > --
>> > 1.7.9.5
>> >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
