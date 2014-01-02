From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
Date: Thu, 02 Jan 2014 14:45:29 +0100
Message-ID: <52C56D79.1060506@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com> <20140101205603.GA1141@core.coreip.homeip.net> <52C5336B.9010903@redhat.com> <1700375.GaI3zFl6RI@phil>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBCG3SWLAKGQEOHIC6SA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1700375.GaI3zFl6RI@phil>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 01/02/2014 12:59 PM, Heiko St=FCbner wrote:
> Hi Hans, Dmitry,
>
> Am Donnerstag, 2. Januar 2014, 10:37:47 schrieb Hans de Goede:
>> Hi,
>>
>> On 01/01/2014 09:56 PM, Dmitry Torokhov wrote:
>>> Hi Hans,
>>>
>>> On Wed, Jan 01, 2014 at 08:30:07PM +0100, Hans de Goede wrote:
>>>> +Required properties:
>>>> + - compatible: "allwinner,sun4i-lradc-keys"
>>>> + - reg: mmio address range of the chip
>>>> + - interrupts: interrupt to which the chip is connected
>>>> + - allwinner,chan0-step: step in mV between keys must be 150 or 200
>>>> + - allwinner,chan0-keycodes: array of include/uapi/linux/input.h KEY_
>>>> codes>
>>> I think this should be "linux,chan0-keycodes".
>>
>> Right, because the codes are Linux specific, will fix in v2.
>
> but the property with its "chan0-" thingy would be allwinner-specific if =
I'm
> not mistaken.

Correct, but denoting that this is linux only is more important, so as to
avoid namespace collisions.

>
> Also, instead of inventing yet another vendor-specific property, why not =
re-use
> a button binding similar to gpio-keys like:
>
>         lradc: lradc@01c22800 {
>                 compatible =3D "allwinner,sun4i-lradc-keys";
>                 reg =3D <0x01c22800 0x100>;
>                 interrupts =3D <31>;
>                 allwinner,chan0-step =3D <200>;
>
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>
> 		button@0 {
> 			reg =3D <0>; /* your channel index from above */
> 			linux,code =3D <115>; /* already used as dt-property */
> 		};
>
> 		button@1 {
> 			reg =3D <1>;
> 			linux,code =3D <114>;
> 		};

Ugh no. Having a vendor specific property which is KISS certainly beats thi=
s,
both wrt ease of writing dts files as well as wrt the dts parsing code in t=
he driver.

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
