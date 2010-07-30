From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable
	it.
Date: Fri, 30 Jul 2010 08:02:19 -0400
Message-ID: <AANLkTikMkWt9bnY58tOneydJNHi1PZO5DsQbwuucJcrO@mail.gmail.com>
References: <1280456235-2024-1-git-send-email-maximlevitsky@gmail.com>
	<1280456235-2024-14-git-send-email-maximlevitsky@gmail.com>
	<AANLkTim42mHVhOgmVGxh2XsbbbVC7ZOgtfd7DDSrxZDB@mail.gmail.com>
	<1280461565.15737.124.camel@localhost>
	<1280489761.3646.3.camel@maxim-laptop>
	<AANLkTimqi+DwXUKxBkfkLVnvS4ONRT461CcRLk3F9ojX@mail.gmail.com>
	<1280490865.21345.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280490865.21345.0.camel@maxim-laptop>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andy Walls <awalls@md.metrocast.net>, lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 30, 2010 at 7:54 AM, Maxim Levitsky <maximlevitsky@gmail.co=
m> wrote:
> On Fri, 2010-07-30 at 07:51 -0400, Jon Smirl wrote:
>> On Fri, Jul 30, 2010 at 7:36 AM, Maxim Levitsky <maximlevitsky@gmail=
=2Ecom> wrote:
>> > On Thu, 2010-07-29 at 23:46 -0400, Andy Walls wrote:
>> >> On Thu, 2010-07-29 at 22:39 -0400, Jon Smirl wrote:
>> >> > On Thu, Jul 29, 2010 at 10:17 PM, Maxim Levitsky
>> >> > <maximlevitsky@gmail.com> wrote:
>> >> > > note that error_adjustment module option is added.
>> >> > > This allows to reduce input samples by a percent.
>> >> > > This makes input on my system more correct.
>> >> > >
>> >> > > Default is 4% as it works best here.
>> >> > >
>> >> > > Note that only normal input is adjusted. I don't know
>> >> > > what adjustments to apply to fan tachometer input.
>> >> > > Maybe it is accurate already.
>> >> >
>> >> > Do you have the manual for the ENE chip in English? or do you r=
ead Chinese?
>> >>
>> >> The datasheet for a similar chip, the KB3700, is out there in Eng=
lish,
>> >> but it doesn't have CIR.
>> >>
>> >> You might find these links mildly interesting:
>> >>
>> >> http://www.coreboot.org/Embedded_controller
>> >> http://wiki.laptop.org/go/Embedded_controller
>> >> http://lists.laptop.org/pipermail/openec/2008-July/000108.html
>> >
>> > Nope, I have read that.
>> >>
>> >> Regards,
>> >> Andy
>> >>
>> >> > Maybe you can figure out why the readings are off by 4%. I susp=
ect
>> >> > that someone has set a clock divider wrong when programming the=
 chip.
>> >> > For example setting the divider for a 25Mhz clock when the cloc=
k is
>> >> > actually 26Mhz would cause the error you are seeing. Or they ju=
st made
>> >> > a mistake in computing the divisor. It is probably a bug in the=
 BIOS
>> >> > of your laptop. =A0If that's the case you could add a quirk in =
the
>> >> > system boot code to fix the register setting.
>> >
>> > I figured out how windows driver compensates for the offset, and d=
o the
>> > same in my driver. I think the problem is solved.
>> >
>>
>> Should that be a <=3D or >=3D instead of !=3D?
>> + =A0 =A0 =A0 if (pll_freq !=3D 1000)
>
> This is how its done in windows driver.

That doesn't mean it is bug free.

Experimenting with changing the PLL frequency register may correct the
error.  Try taking 96% of pll_freq and write it back into these
register. This would be easy to fix with a manual. The root problem is
almost certainly a bug in the way the PLLs were programmed.

I don't like putting in fudge factors like the 4% correction. What
happens if a later version of the hardware has fixed firmware? I
normal user is never going to figure out that they need to change the
fudge factor.

+       pll_freq =3D (ene_hw_read_reg(dev, ENE_PLLFRH) << 4) +
+               (ene_hw_read_reg(dev, ENE_PLLFRL) >> 2);
+


>>
>> Programming the PLL wrong would cause the 4% error.
>>
>> =A0 =A0 =A0 =A0hw_revision =3D ene_hw_read_reg(dev, ENE_HW_VERSION);
>> =A0 =A0 =A0 =A0old_ver =3D ene_hw_read_reg(dev, ENE_HW_VER_OLD);
>>
>> + =A0 =A0 =A0 pll_freq =3D (ene_hw_read_reg(dev, ENE_PLLFRH) << 4) +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ene_hw_read_reg(dev, ENE_PLLFRL) >> 2=
);
>> +
>> + =A0 =A0 =A0 if (pll_freq !=3D 1000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->rx_period_adjust =3D 4;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->rx_period_adjust =3D 2;
>> +
>> +
>> + =A0 =A0 =A0 ene_printk(KERN_NOTICE, "PLL freq =3D %d\n", pll_freq)=
;
>> +
>> =A0 =A0 =A0 =A0if (hw_revision =3D=3D 0xFF) {
>>
>>
>>
>> >
>> > Best regards,
>> > Maxim Levitsky
>> >
>> >
>>
>>
>>
>
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
