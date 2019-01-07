From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 7 Jan 2019 10:56:07 -0800
Message-ID: <20190107185607.GA141497@dtor-ws>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <20190107164225.GA5394@agonzal-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107164225.GA5394@agonzal-linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Cc: Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 07, 2019 at 04:42:26PM +0000, Gonzalez, Alex wrote:
> Hi Bastien,
> 
> >Given that we do have access to the datasheet, it would also be useful
> >for the patch to mention where in the datasheet it says that the reset
> >line can be left pulled-up,
> 
> The pin description table on section 4, on the "Reset pin" row, contains a 
> remark as follows:
> 
> External 10K pull-up resistor required, active-low reset
> 
> This comes from a newer revision of the datasheet though:
> http://focuslcds.com/content/GT911.pdf
> 
> I guess it's open to interpretation whether driving the reset line is 
> optional. The code seemed to imply it by using devm_gpiod_get_optional() to 
> obtain the GPIO.

They are optional in the sense that driver should work without them, but
if they specified we need both.

> 
> >or mention on which shipping device this
> >setup is already used (and if so, what the DTS or ACPI snippet that
> >declares those is).
> >
> 
> I am testing with an LCD application kit for the ConnectCore 6UL SBC Pro:
> 
> https://www.digi.com/products/models/cc-acc-lcdw-10
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts?h=v5.0-rc1#n120
> 
> This display in particular does not have the reset line available on the 
> connector. The only way to make it work seems to be to use the INT line to fix 
> an I2C address.

Do you have to use 0x14 address? Can you used the default 0x5d?

My concern with trying to do the address selection without RST line is
that it is quite unreliable, as it really depends on timings between the
chip reset, INT line being driven by the host and then being switched to
input.

Thanks.

-- 
Dmitry
