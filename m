From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 22:15:42 +0800
Message-ID: <AANLkTin2ap24Jn38eXx3uHLiJ32otXA6PgtL-yORU7sr@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<20100621091952.GB7702@n2100.arm.linux.org.uk> <AANLkTilU1X1LR33Eed9BVGE2n-dqRuIuUFfbDd3gzEVc@mail.gmail.com>
	<20100621111612.GJ7702@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100621111612.GJ7702@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 21, 2010 at 7:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 21, 2010 at 06:39:10PM +0800, Eric Miao wrote:
>> On Mon, Jun 21, 2010 at 5:19 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jun 21, 2010 at 05:05:34PM +0800, Eric Miao wrote:
>> >> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@sams=
ung.com> wrote:
>> >> > +void __init samsung_keypad_set_platdata(struct samsung_keypad_=
platdata *pd)
>> >> > +{
>> >> > + =C2=A0 =C2=A0 =C2=A0 struct samsung_keypad_platdata *npd;
>> >> > +
>> >> > + =C2=A0 =C2=A0 =C2=A0 if (!pd) {
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_=
ERR "%s: no platform data\n", __func__);
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> >> > + =C2=A0 =C2=A0 =C2=A0 }
>> >> > +
>> >> > + =C2=A0 =C2=A0 =C2=A0 npd =3D kmemdup(pd, sizeof(struct samsun=
g_keypad_platdata), GFP_KERNEL);
>> >> > + =C2=A0 =C2=A0 =C2=A0 if (!npd)
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_=
ERR "%s: no memory for platform data\n", __func__);
>> >>
>> >> This part of the code is actually duplicated again and again and =
again
>> >> for each device, PXA and other legacy platforms are bad reference=
s for
>> >> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are=
 three
>> >> major points:
>> >>
>> >> =C2=A01. A minimum 'struct pxa_device_desc' for a simple descript=
ion of a
>> >> =C2=A0 =C2=A0 device (more than 90% of the devices can be describ=
ed that way),
>> >> =C2=A0 =C2=A0 and avoid using a comparatively heavier weight plat=
form_device,
>> >> =C2=A0 =C2=A0 which can be generated at run-time
>> >>
>> >> =C2=A02. pxa_register_device() to allocate and register the platf=
orm_device
>> >> =C2=A0 =C2=A0 at run-time, along with the platform data
>> >
>> > It's a bad idea to make platform data be run-time discardable like=
 this:
>> >
>> >> > +struct samsung_keypad_platdata {
>> >> > + =C2=A0 =C2=A0 =C2=A0 const struct matrix_keymap_data *keymap_=
data;
>> >
>> > What you end up with is some platform data structures which must b=
e kept
>> > (those which have pointers to them from the platform data), and ot=
hers
>> > (the platform data itself) which can be discarded at runtime.
>> >
>> > We know that the __initdata attributations cause lots of problems =
-
>> > they're frequently wrong. =C2=A0Just see the constant hastle with =
__devinit
>> > et.al. =C2=A0The same issue happens with __initdata as well.
>> >
>> > So why make things more complicated by allowing some platform data
>> > structures to be discardable and others not to be? =C2=A0Is their =
small
>> > size (maybe 6 words for this one) really worth the hastle of getti=
ng
>> > __initdata attributations wrong (eg, on the keymap data?)
>> >
>>
>> Russell,
>>
>> The benefit I see is when multiple boards are compiled in, those
>> data not used can be automatically discarded.
>
> Yes, but only some of the data can be discarded. =C2=A0Continuing wit=
h the
> example in hand, while you can discard the six words which represent
> samsung_keypad_platdata, but the keymap_data can't be because that wo=
n't
> be re-allocated, which is probably a much larger data structure.
>
> So, samsung_keypad_platdata can be marked with __initdata, but the ke=
ymap
> data must not be - and this is where the confusion about what can be
> marked with __initdata starts - and eventually leads to the keymap da=
ta
> also being mistakenly marked __initdata.

Indeed. One ideal solution would be to make all the board code into
a module, yet since some of the code should be executed really
early and need to stay as built-in, looks like we need a way to
separate these two parts.

>
> Is saving six words (or so) worth the effort to track down stuff
> inappropriately marked with __initdata ? =C2=A0I'm sure there's bigge=
r savings
> to be had in other parts of the kernel (such as shrinking the size of
> tcp hash tables, reducing the kernel message ring buffer, etc) if siz=
e is
> really a concern.
>

That's true, however, I think the size will become a bit more significa=
nt
if more and more board code is compiled into a single kernel.
