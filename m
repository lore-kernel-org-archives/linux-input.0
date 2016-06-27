From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 4/4] Input: synaptics-rmi4 - add SMBus support
Date: Mon, 27 Jun 2016 17:03:47 +0200
Message-ID: <20160627150347.GV24234@mail.corp.redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-5-git-send-email-benjamin.tissoires@redhat.com>
 <20160623230635.GS32561@dtor-ws>
 <20160624071931.GP24234@mail.corp.redhat.com>
 <20160624233505.GC11719@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160624233505.GC11719@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 24 2016 or thereabouts, Dmitry Torokhov wrote:
> On Fri, Jun 24, 2016 at 09:19:32AM +0200, Benjamin Tissoires wrote:
> > On Jun 23 2016 or thereabouts, Dmitry Torokhov wrote:
> > > On Thu, Jun 09, 2016 at 04:53:50PM +0200, Benjamin Tissoires wrote:
> > > > +
> > > > +static struct i2c_driver rmi_smb_driver = {
> > > > +	.driver = {
> > > > +		.owner	= THIS_MODULE,
> > > > +		.name	= "rmi4_smbus",
> > > > +		.pm	= &rmi_smb_pm,
> > > > +		.resume	= rmi_smb_resume,
> > > 
> > > Why rmi_smb_resume is not part of rmi_smb_pm?
> > > 
> > 
> > This is because rmi_smbus device both have a PS/2 interface and a SMBus
> > one. I'll have to check again now that I have a slightly different way
> > of binding smbus devices in my tree, but the issue was:
> > - having resume part of pm means it will get caught by PM directly
> > - the PS/2 node gets also resumed by PM
> > - calling PS/2 commands during resume switches the devices back into
> >   PS/2 and stops the SMBus communication.
> > 
> > So it's easier to wait only for the PS/2 PM resume call which will call
> > the SMBus resume function when the device is in a proper state.
> > 
> > I'll send out the updated patch with your comments next week hopefully.
> 
> Hmm, I think you will have to walk me through resume process. How do we
> tie in PS/2 and I2C on these devices abd have PS/2 code call into this
> driver?
> 

Sure.

For starters, here is my latest WIP (I need to rework on the series for
commit messages and probably squash some patches):
https://github.com/bentiss/linux/commits/synaptics-rmi4-smbus-v4.7-rc4%2B

Then, let me explain the problems we have with those touchpads and the
resume process.

The touchpads are both connected to PS/2 and SMBus as you know. However,
there is no SMBus enumeration entry anywhere in the system. Luckily,
the PS/2 chip is aware of the other bus, and can be polled to
request whether or not we are confronted to a RMI4 over SMBus device
(see https://github.com/bentiss/linux/commit/a3e67de764656201522962028bc783fc4b921de3 )

Of course, to make those touchpads robust with reboots and allow legacy
drivers (PS/2) to use them, the firmware tend to switch back to PS/2 as
soon as you issue a PS/2 reset command or if you send some other PS/2
commands. The problem we have is that if you send some various PS/2
commands to the touchpad, it disconnects from the SMBus entirely (it
took me one year to understand why the device was not showing up on
I2C).

The last interesting fact for those touchpad is that you need to enable
SMBus communication by issuing a SMB_PROTOCOL_VERSION_ADDRESS command.
If you do not issue this after a PS/2 reset, the device is muted over
SMBus.

So, to be sure we can query the touchpad from PS/2 and to control the
PS/2 commands and the resume, I have in the series above a separate PS/2
driver for this touchpad. The regular psmouse driver probes the PS/2
chip, but aborts seeing the SMBus capability. Then rmi_ps2 takes over
and binds to the PS/2 chip to fill in the platform data required by
rmi_smbus (https://github.com/bentiss/linux/commit/3ceb7c80ecee17a86b8ae8476211c7498cc823d2)

If we simply unbind the PS/2 node and let it dangling, the serio driver
issues a reconnect after resume on both the PS/2 chip of the touchpad,
and the PS/2 pass-through node of the trackstick.

But if the PS/2 chip of the touchpad is left dangling, the resume
process will first call a reconnect on the pass-through, then on
the touchpad through the enumeration of the serio bus, which will reset
the touchpad and messed up the pass-through node and the rmi-smbus
driver.
So keeping around a reference to the PS/2 node allows to set this node
as a parent of the pass-through trackstick node and guarantees that the
touchpad will be resumed before the trackstick.

One final thing. I tried not having rmi_ps2 calling the .resume callback
of rmi_smbus and keeping rmi_smbus as a PM. But the issue is that the
serio driver sends the reset command in a workqueue as it can takes some
time:

- serio gets resume called -> prepare the worker for the
  resume/reconnect process
- rmi_smbus gets resumed -> OK
- the worker kicks in, reset the PS/2 lines, and shuts down the
  rmi_smbus device


I also tried one thing where I did not bind the PS/2 touchpad at all
(and having some kind of platform driver to bind rmi_smbus). And of
course, grub initializes the touchpad, so it disconnects on I2C and you
can't bind it on SMBus, ever :)


I think that's all I know on these touchpads and this is all the mess I can
present. If you have a better option, I'm all ears as this is not clean,
but I can't figure out a better way.

Cheers,
Benjamin
