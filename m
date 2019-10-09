From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Wed, 9 Oct 2019 12:47:40 +0200
Message-ID: <20191009104740.GA107000@gerhold.net>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008220014.GI22365@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 08, 2019 at 03:00:14PM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 07, 2019 at 10:50:21PM +0200, Stephan Gerhold wrote:
> > MMS345L is another first generation touch screen from Melfas,
> > which uses the same registers as MMS152.
> > 
> > However, using I2C_M_NOSTART for it causes errors when reading:
> > 
> > 	i2c i2c-0: sendbytes: NAK bailout.
> > 	mms114 0-0048: __mms114_read_reg: i2c transfer failed (-5)
> > 
> > The driver works fine as soon as I2C_M_NOSTART is removed.
> > 
> > Add a separate melfas,mms345l binding, and make use of I2C_M_NOSTART
> > only for MMS114 and MMS152.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Note: I was not able to find a datasheet for any of the models,
> > so this change is merely based on testing and comparison with
> > the downstream driver [1].
> > 
> > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > but it seems abandoned and I do not have any other model for testing.
> > Therefore, this patch implements the least instrusive solution
> > and only removes I2C_M_NOSTART for MMS345L.
> 
> Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> to work for you and him and it looks like Android drivers are not using
> I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> it was originally developed.
> 
> Any objections?

I cannot really speak for any of the other models, but no objections for
removing I2C_M_NOSTART from my side. I'm actually rather confused by it
since it is used on the first partial message.

The documentation [1] says:
  If you set the I2C_M_NOSTART variable for the first partial message,
  we do not generate Addr, but we do generate the startbit S.
  ** This will probably confuse all other clients on your bus,
  so don't try this. **

Yet, someone felt like trying this here. ;)

I have tested the following two patches from Andy on MMS345L:
  - Input: mms114 - use smbus functions whenever possible [2]
  - Input: mms114 - get read of custm i2c read/write functions [3]

Indeed, with I2C_M_NOSTART removed I can actually use "melfas,mms152"
and the touchscreen appears to work without further changes.
(The only weird thing is that it displays an empty "Compat group" in
  "TSP FW Rev: bootloader 0x6 / core 0x26 / config 0x26, Compat group: ",
 I suspect that register does not exist on MMS345L...)

But there is a limitation that won't let us take these two patches as-is:
i2c_smbus_read_i2c_block_data() is limited to I2C_SMBUS_BLOCK_MAX,
which is: 32 /* As specified in SMBus standard */

According to "Input: mms114 - use smbus functions whenever possible":
> The exchange of data to and from the mms114 touchscreen never
> exceeds 256 bytes. In the worst case it goes up to 80 bytes in
> the interrupt handler while reading the events.

Since i2c_smbus_read_i2c_block_data() is limited to 32, larger packets
won't be read correctly. For example, if you use more than 4 fingers you
can easily trigger a situation where one of the fingers gets "stuck",
together with: mms114 4-0048: Wrong touch type (0)
(It attempts to read uninitialized data in this case...)

So we still need the custom functions for reading the touch packet,
or maybe change the driver to use regmap instead.

[1]: https://www.kernel.org/doc/html/latest/i2c/i2c-protocol.html
[2]: https://patchwork.kernel.org/patch/10189551/
[3]: https://patchwork.kernel.org/patch/10189541/
