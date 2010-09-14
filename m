From: William Manson <WManson@synaptics.com>
Subject: RE: Synaptics i2c touchscreen driver
Date: Mon, 13 Sep 2010 17:26:15 -0700
Message-ID: <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9B@USW-EX2K7-1.synaptics-inc.local>
References: <27F9C60D11D683428E133F85D2BB4A530450B63EDD@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:19567 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab0INA0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 20:26:40 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530450B63EDD@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'Arce, Abraham'" <x0066660@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@suse.de>, Christopher Heiny <Cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Abraham -

Yes - the TM1217 is an RMI4 based module [I just got an email from a f/w engineer confirming it is indeed RMI4].

We are currently working on submitting a new patch for our RMI4 based driver to add some functionality based on Dmitry Torokhov's request that we implement an RMI bus architecture. This is kind of a large change and we had hoped our current submission for our RMI4 driver would be added to the Kernel.org under a branch where every developer could access it and then we could add in the RMI bus architecture in a later patch. So it will take a while till we can make a new patch but I have no problem if you want to try the existing patch out.

Be aware that it is for building a modular driver and I believe Android kernel is not built around module support. The existing Android Touch Screen driver for our older RMI3 sensors is built as a monolithic driver in one single file. I'm not aware whether Froyo (Android 2.2) supports modules or not. So - if not then you may have to somehow merge the code into one file with one mod_init and one mod_exit.

As far as any help from the community - I for one would welcome it. Our goal is to have a very 'generic' RMI4 based driver that can have different physical layer modules plugged into it (I2C, SPI, PS/2, USB, etc.) and then also have support for multiple RMI4 modules with each RMI4 module supporting multiple functions (see our RMI4 spec. on our website - www.synaptics.com and go to Support/Developer Resource/Manuals - to get info about what RMI4 functions are currently defined). This modular approach is much more than a single driver for RMI4 that only supports one physical protocol like I2C and only supports "some" functions. To be frank, most people are mainly interested in just Function 0x11 (2D sensor - or the clear pad itself). But it would be possible to have multiple controllers wher
 e two of the controllers support 2D and one supports buttons and say yet another supports LEDs and buttons and maybe some custom GPIOs. So the much broader modular approach is better in the long run for overall "generic" RMI4 support.

Thanks,
William Manson



-----Original Message-----
From: Arce, Abraham [mailto:x0066660@ti.com]
Sent: Monday, September 13, 2010 2:26 PM
To: Dmitry Torokhov; Greg KH; Christopher Heiny; Allie Xiong; William Manson
Cc: devel@driverdev.osuosl.org; linux-input@vger.kernel.org
Subject: RE: Synaptics i2c touchscreen driver

Hi,

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > On Mon, Sep 13, 2010 at 08:27:57AM -0700, Greg KH wrote:
> > > On Sun, Sep 12, 2010 at 04:45:23PM -0500, Arce, Abraham wrote:
> > >
> > > I was watching your Android presentation gave at ELC 2010, in that,
> > > you have mention Synaptics i2c touchscreen driver. I've been trying to
> > > identify if Synaptics team has an upstreaming plan but still no clear
> > > information on this.
> > >
> > > I have already requested this info but things are extremely quiet.
> > >
> > > http://www.spinics.net/lists/linux-input/msg11006.html
> > >
> > > Any information will be highly appreciated...
> >
> > Sorry, I don't have any information or know anything about this at all.
> >
>
> As far as I know [current] versions of Android use RMI3 touchscreens
> which are older technology. Synaptics is trying to get their newer RMI4
> driver merged and probably not that interested in RMI3 anymore.

Thanks Greg and Dmitry for all the info... it helped!

Christopher, Allie, William,

First, I am looking for more information on TM-01217 controller, I remember looking at some document saying that that this particular controller supports RMI4, is this correct?

Another question, it is about the final patch for touchscreens based on RMI4 protocol:

http://www.spinics.net/lists/linux-input/msg10042.html

When are you planning to release the final patch for upstreaming? Any help that you may need from the community?

Best Regards
Abraham

