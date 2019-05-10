From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Fri, 10 May 2019 08:14:19 +0100
Message-ID: <20190510071419.GB7321@dell>
References: <20190409154610.6735-1-tbogendoerfer@suse.de>
 <20190409154610.6735-3-tbogendoerfer@suse.de>
 <20190508102313.GG3995@dell>
 <20190509160220.bb5382df931e5bd0972276df@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190509160220.bb5382df931e5bd0972276df@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 09 May 2019, Thomas Bogendoerfer wrote:

> On Wed, 8 May 2019 11:23:13 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Tue, 09 Apr 2019, Thomas Bogendoerfer wrote:
> > 
> > > +static u32 crc8_addr(u64 addr)
> > > +{
> > > +	u32 crc = 0;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < 64; i += 8)
> > > +		crc8_byte(&crc, addr >> i);
> > > +	return crc;
> > > +}
> > 
> > Not looked into these in any detail, but are you not able to use the
> > CRC functions already provided by the kernel?
> 
> they are using a different polynomial, so I can't use it.

Would it be worth moving support out to somewhere more central so
others can use this "polynomial"?

> > > +	}
> > > +	pr_err("ioc3: CRC error in NIC address\n");
> > > +}
> > 
> > This all looks like networking code.  If this is the case, it should
> > be moved to drivers/networking or similar.
> 
> no it's not. nic stands for number in a can produced by Dallas Semi also
> known under the name 1-Wire (https://en.wikipedia.org/wiki/1-Wire).
> SGI used them to provide partnumber, serialnumber and mac addresses.
> By placing the code to read the NiCs inside ioc3 driver there is no need
> for locking and adding library code for accessing these informations.

Great.  So it looks like you should be using this, no?

  drivers/base/regmap/regmap-w1.c

> > > +static struct resource ioc3_uarta_resources[] = {
> > > +	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
> > 
> > You are the first user of offsetof() in MFD.  Could you tell me why
> > it's required please?
> 
> to get the offsets of different chip functions out of a struct.

I can see what it does on a coding level.

What are you using it for in practical/real terms?

Why wouldn't any other MFD driver require this, but you do?

> > Please drop all of these and statically create the MFD cells like
> > almost all other MFD drivers do.
> 
> I started that way and it blew up the driver and create a bigger mess
> than I wanted to have. What's your concern with my approach ?
> 
> I could use static mfd_cell arrays, if there would be a init/startup
> method per cell, which is called before setting up the platform device.
> That way I could do the dynamic setup for ethernet and serial devices.

You can set platform data later.  There are plenty of examples of
this in the MFD subsystem.  Statically define what you can, and add
the dynamic stuff later.

> > > +static void ioc3_create_devices(struct ioc3_priv_data *ipd)
> > > +{
> > > +	struct mfd_cell *cell;
> > > +
> > > +	memset(ioc3_mfd_cells, 0, sizeof(ioc3_mfd_cells));
> > > +	cell = ioc3_mfd_cells;
> > > +
> > > +	if (ipd->info->funcs & IOC3_ETH) {
> > > +		memcpy(ioc3_eth_platform_data.mac_addr, ipd->nic_mac,
> > > +		       sizeof(ioc3_eth_platform_data.mac_addr));
> > 
> > Better to pull the MAC address from within the Ethernet driver.
> 
> the NiC where the MAC address is provided is connected to the ioc3
> chip outside of the ethernet register set. And there is another
> NiC connected to the same 1-W bus. So moving reading of the MAC
> address to the ethernet driver duplicates code and adds complexity
> (locking). Again what's your concern here ?

Does this go away if you use the already provided 1-wire API?

> > > +	if (ipd->info->funcs & IOC3_SER) {
> > > +		writel(GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL,
> > > +			&ipd->regs->gpcr_s);
> > > +		writel(0, &ipd->regs->gppr[6]);
> > > +		writel(0, &ipd->regs->gppr[7]);
> > > +		udelay(100);
> > > +		writel(readl(&ipd->regs->port_a.sscr) & ~SSCR_DMA_EN,
> > > +		       &ipd->regs->port_a.sscr);
> > > +		writel(readl(&ipd->regs->port_b.sscr) & ~SSCR_DMA_EN,
> > > +		       &ipd->regs->port_b.sscr);
> > > +		udelay(1000);
> > 
> > No idea what any of this does.
> > 
> > It looks like it belongs in the serial driver (and needs comments).
> 
> it configures the IOC3 chip for serial usage. This is not part of
> the serial register set, so it IMHO belongs in the MFD driver.

So it does serial things, but doesn't belong in the serial driver?

Could you please go into a bit more detail as to why you think that?

Why is it better here?

It's also totally unreadable by the way!

> > > +	}
> > > +#if defined(CONFIG_SGI_IP27)
> > 
> > What is this?  Can't you obtain this dynamically by probing the H/W?
> 
> that's the machine type and the #ifdef CONFIG_xxx are just for saving space,
> when compiled for other machines and it's easy to remove.

Please find other ways to save the space.  #ifery can get very messy,
very quickly and is almost always avoidable.

> > > +	if (ipd->info->irq_offset) {
> > 
> > What does this really signify?
> 
> IOC3 ASICs are most of the time connected to a SGI bridge chip. IOC3 can
> provide two interrupt lines, which are wired to the bridge chip. The first
> interrupt is assigned via the PCI core, but since IOC3 is not a PCI multi
> function device the second interrupt must be treated here. And the used
> interrupt line on the bridge chip differs between boards.

Please provide a MACRO, function or something else which results in
more readable code.  Whatever you choose to use, please add this text
above, it will be helpful for future readers.

> Thank you for your review. I'll address all other comments not cited in
> my mail.

NP

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
