From: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 7 Jan 2019 16:42:26 +0000
Message-ID: <20190107164225.GA5394@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Content-Language: en-US
Content-ID: <BB5ACEDF7CF4C44D90428409950F9667@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Bastien,

>Given that we do have access to the datasheet, it would also be useful
>for the patch to mention where in the datasheet it says that the reset
>line can be left pulled-up,

The pin description table on section 4, on the "Reset pin" row, contains a 
remark as follows:

External 10K pull-up resistor required, active-low reset

This comes from a newer revision of the datasheet though:
http://focuslcds.com/content/GT911.pdf

I guess it's open to interpretation whether driving the reset line is 
optional. The code seemed to imply it by using devm_gpiod_get_optional() to 
obtain the GPIO.

>or mention on which shipping device this
>setup is already used (and if so, what the DTS or ACPI snippet that
>declares those is).
>

I am testing with an LCD application kit for the ConnectCore 6UL SBC Pro:

https://www.digi.com/products/models/cc-acc-lcdw-10
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts?h=v5.0-rc1#n120

This display in particular does not have the reset line available on the 
connector. The only way to make it work seems to be to use the INT line to fix 
an I2C address.

>Cheers
>
