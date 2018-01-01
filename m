From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: xps 15 9560 touchpad high interrupts
Date: Mon, 1 Jan 2018 08:14:41 +0200
Message-ID: <20180101061441.mi3fxata4prkt4eu@sapphire.tkos.co.il>
References: <CAEOHGO=GYr4NCnwNXf=it6WFVRQ0d-eYTVKoZSiuhYhumnBK5A@mail.gmail.com>
 <20171231062520.qlcijf32eoqhdksf@sapphire.tkos.co.il>
 <CAEOHGOks90Am19G4-YALXq6vL8GOM9V0Mmf65-rUNYOvf5Rhyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEOHGOks90Am19G4-YALXq6vL8GOM9V0Mmf65-rUNYOvf5Rhyw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Javad Karabi <karabijavad@gmail.com>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Javad Karabi,

Added linux-i2c to Cc.

On Sun, Dec 31, 2017 at 03:58:57PM -0600, Javad Karabi wrote:
> On Sun, Dec 31, 2017 at 12:25 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> > Added linux-input list to Cc.
> >
> > On Sat, Dec 30, 2017 at 05:10:06PM -0600, Javad Karabi wrote:
> > > im trying to figure out why i get like 7000 interrupts a second simply by
> > > resting my finger on the touchpad (not even moving it)
> > > this is on a xps 15 9560
> > > and the touchpad is at
> > > DLL07BE:01 06CB:7A13 Touchpad as
> > > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/
> > i2c-DLL07BE:01/0018:06CB:7A13.0009/input/input58
> > >
> > > could you provide me with any advice as to where i should look to figure
> > > this out?
> > > i have already tried adding code to i2c-designware-platdrv.c
> > > i added
> > > dev->clk_freq = 100000;
> > > in dw_i2c_plat_probe, but it still shoots off thousands of interrupts a
> > > second (and they are apparently spurious interrupts, atleast accoding
> > > to /proc/irq/17/spurious
> > >
> > > could you provide any guidance at all? would be much appreciated.. i
> > > would love to fix this issue and get it upstreamed in the kernel if 
> > > possible.
> > > thank you
> >
> > i2c_designware is a I2C bus master driver. It allows the host to
> > communicate with various devices. Your touchpad is apparently one such 
> > device. But each device on the I2C bus needs its own driver. I have no 
> > idea which driver handles your touchpad device. Maybe someone on the 
> > linux-input list knows.
> >
> > Specifically, the interrupts handling has nothing to do with the I2C bus.
> > Unlike PCIe, I2C provides no in-bus interrupt delivery facility. I2C
> > devices usually use a separate dedicated interrupt line. So the spurious 
> > interrupts that you see must be handled at the touchpad input driver 
> > level.
> >
> > One thing that might help others help you is the version of the kernel you
> > are running. Please provide the output of 'uname -rv' on your machine.
> 
> uname -rv
> 4.15.0-rc5 #2 SMP Thu Dec 28 18:21:06 CST 2017
> 
> for what its worth, i think it might be hid_multitouch that is handling the
> touchpad, since when i rmmod it, my touchpad is no longer active.

The hid-multitouch driver handles USB devices, not I2C. The code at 
drivers/hid/hid-multitouch.c shows a few supported USB_VENDOR_ID_SYNAPTICS 
(0x06cb) devices, but the 0x7a13 device ID does not appear there as of 
v4.15-rc6. Maybe your kernel is patched to add support for that device.

I guess that i2c_designware appears on the device hierarchy because the 
"smart" USB hub on your system is controlled over the I2C bus.

> when you say that the touchpad driver handles the irq stuff... i am a
> little confused because i2c-designware-platdrv.c contains this line:
> irq = platform_get_irq(pdev, 0);

Do you have an indication that irq 17 belongs to i2c-designware?

The i2c-designware driver uses an interrupt to handle its hardware buffer, and 
to receive transactions status. I2C is a slow protocol, so most controller 
implementations are asynchronous. If this irq misbehaves, then there is most 
likely a problem with the i2c-designware driver.

> i would assume that hid_multitouch would contain irq related code if i am
> understanding you correctly?
> am i misunderstanding?

Since hid-multitouch is a USB driver, the irq handle itself is in the USB bus 
driver.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
