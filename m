From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: input: Synaptics touchscreen driver followup
Date: Tue, 12 Oct 2010 10:55:53 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53046845E437@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A530468370A42@dlee03.ent.ti.com>
 <7F4B01C67BC89E4CB219B3E4BCFAE7F16BE5D34473@USW-EX2K7-1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45441 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757286Ab0JLP4K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 11:56:10 -0400
In-Reply-To: <7F4B01C67BC89E4CB219B3E4BCFAE7F16BE5D34473@USW-EX2K7-1.synaptics-inc.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <Cheiny@synaptics.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: William Manson <WManson@synaptics.com>, Allie Xiong <axiong@synaptics.com>, Jean Delvare <khali@linux-fr.org>

Hi Christopher,

> From: Christopher Heiny [mailto:Cheiny@synaptics.com]
> 
> My apologies for top posting.  I'm at not at the office right now, and
> constrained to use a webmail interface.
> 

No problem...

> We are working on the RMI4 bus implementation  Internal code review is planned
> for this week, with a new patch to be issued late this week or early next
> week.

Excellent!

> 
> Attached is a simple diagram that should help clarify the architecture, along
> with some excerpts from our RMI bus related discussion between our team and
> Dmitry a few weeks ago.

Thanks for sharing, now it is more clear my understanding

> 
> I think it is very important for us to coordinate our efforts on this driver.
> This will avoid redundant coding and (worse) working at cross-purposes.  We'd
> definitely like to see any bug fixes and improvements you have made.  If
> that's agreeable to you, let's work out some processes for that offline.  If
> you wish, we'll send you a pre-code-review patch of our current work.

Sure, completely agree on the coordination part. I have not done big progress, just being able to register all layers after facing some kernel crashes but nothing as improvements, since you have the new implementation and it probably changed many lines of code it will be better as initial step to help you by integrating and testing it in my platform. 

I'll sync up with you offline...

Best Regards
Abraham

> 
> Thanks,
> Chris
> 
> On 08/30/2010 02:12 PM, Christopher Heiny wrote:
> > Hi Dmitry,
> >
> > I hope you had a good&  relaxing vacation!
> >
> > We are working on refactoring our RMI4 driver submission to implement
> > the RMI bus.  Before we progress too far on this, I would like to
> > clarify with you whether our design meets your requirements and
> > expectations.
> >
> > Based on your previous email, we plan to restructure the driver as shown
> > in the attached quick&dirty drawing.  We chose this approach because a
> > system might have multiple sensors attached to it (for example, the Fuse
> > concept phone, which has 4 RMI sensing device in it).  Each sensor
> > implements a number of RMI4 functions, which are best represented as
> > devices on the bus.
> >
> >
> > - a low level layer providing access to the physical bus.  This already
> > exists in the form of the rmi_i2c.c file.
> >
> >
> > - a rmi_bus module, implementing /sys/bus/rmi.  Basically our view is
> > that this module would present the devices on the bus, handle
> > interdevice communications (mostly just IRQ notifications from F01 to
> > other functions), and proxy register read/write requests to the
> > appropriate physical layer for a given sensor.
> >
> >
> > - each function is presented as a device on the RMI bus
> >
> > - per-function drivers that are matched to these devices by the kernel
> > bus functionality
> >
> > We chose this approach because almost all RMI4 functions are independent
> > of one another.  The sole exception is F01, and its primary interaction
> > with other functions is to notify them of the need to read or write data
> > from or to the sensor.
> >
> > This structure should completely eliminate the ad hoc device matching
> > that was present in our previous driver submissions.  It also enables
> > easy addition of support for new RMI4 functions, either by Synaptics or
> > by third parties.
> 
> Following this, Dmitry raised the question of why the logical devices on the
> bus were organized by sensor and function.  My reply follows.
> 
> On 08/30/2010 04:04 PM, Christopher Heiny wrote:
> > On 08/30/2010 03:03 PM, Dmitry Torokhov wrote:
> >> >  I see... I guess I am looking into a way to group functions into a
> >> >  "package" for userspace because quite often they make sense only
> >> >  together. The classic scenario would be touchpad + buttons where they
> >> >  work together in tandem rather than completely separate devices.
> > You're correct - the relationship between various RMI4 functions
> > (touchpad/touchscreen, buttons, scroll strips, and so on) is much looser
> > in this sort of application than in the classic laptop environment where
> > the buttons are intimately coupled to pointing.
> >
> > I think part of the confusion arose because I referred to what you
> > called a "physical device" as a "sensor" (hoping to reduce confusion,
> > but that doesn't seem to have worked).  I'll drop that and revert to
> > physical device.
> >
> > The RMI4 spec defines the interface to a physical device as a set of
> > functions.  Each of these functions implements a self contained
> > behavior, such as pointing, physical device control, buttons, LED
> > lighting, flash reprogramming, and so on.
> >
> > A given system might have one RMI4 physical device that supports
> > multiple functions in addition to the basic Function 01  (for example,
> > touchscreen (called Function 11 in the RMI spec) and buttons (Function
> > 19)), or it might have two RMI4 physical devices, one for F11 and one
> > for F19.  An example of such a device would be the Nexus One - the four
> > capacitive navigation buttons at the bottom of the screen perform
> > functions that are mostly independent of pointing.
> >
> > A more extreme example would be the Synaptics Fuse concept phone, which
> > contains 4 RMI4 sensors: one for the front touchscreen and capacitive
> > buttons, one for each of the side grip sensors, and one for the back
> > navigation sensor.  Some of these implement one RMI4 function, some
> > implement multiple RMI4 functions.
> >
> > The idea (which I didn't make clear at all in my original note) is to
> > present each of the RMI spec functions as a logical device on the RMI
> > bus.  That way it doesn't matter if the pointing and button functions
> > are implemented on one physical device or on two different physical
> > devices.  Also, this means there is no RMI-specific binding layer needed
> > at all in the driver - all driver<->functionality binding is done via
> > the kernel bus architecture.  This simplifies the overall driver
> > structure a lot.
> >
> > Looking head, it's possible that there might be two physical devices
> > that both implement the buttons function (for example, one for
> > navigation buttons, another for multimedia controls), which would
> > present on the bus as two logical button devices.  I didn't go into it
> > in the original note, but the rough idea there is to have a platform
> > specific configuration file that specifies the mapping of the buttons on
> > each logical device.  As a very simplistic comparision (and possibly not
> > entirely valid), this would be kind of like the config files for
> > lm-sensors that tell what a given platform's sensors measure.
> 
> ________________________________________
> From: Arce, Abraham [x0066660@ti.com]
> Sent: Tuesday, October 12, 2010 12:07 AM
> To: linux-input@vger.kernel.org; Dmitry Torokhov
> Cc: William Manson; Allie Xiong; Christopher Heiny; Jean Delvare
> Subject: input: Synaptics touchscreen driver followup
> 
> Hi,
> 
> This is a follow up on
>  http://www.spinics.net/lists/linux-input/msg11163.html
> 
> I have started to work with synaptics-rmi4 branch using sdp4430 board with 2
> TM1217 controllers. I am right now using linux-omap-2.6 kernel
> 
> After some modifications and board configuration changes I was able to
> register all rmi layers however I am still facing some issues, will continue
> debugging
> 
> - Compilation error when built as modules
> - Interrupts not being generated but registered
> - In polling mode, kernel crash when ts_work_func is executed
> 
> If anyone has made some other progress I'll be glad to test changes...
> 
> Dmitry,
> 
> I have 2 questions,
> 
> 1. Is it ok to send patches for cleanup or do you prefer functional ones?
> There are some checkpatch warnings still around
> 
> 2. Could you please explain more about bus implementation? I have read
> Documentation/driver-model/bus.txt and wrote some initial code to register rmi
> as a bus, giving
> 
> # ls /sys/bus/rmi/drivers/
> # ls /sys/bus/rmi/devices/
> 
> From this point, I am confused on where bus will be in the picture shared by
> Synaptics team, shown below...
> 
> - Does it mean RMI4 Driver will be RMI4 bus and we will keep same application
> on top of it?
> 
> - What about i2c and spi layers? They will be drivers for rmi bus?
> 
> - What will be a device for rmi bus? The application?
> 
>   +----------------------------------------+
>   |               Application              |
>   +----------------------------------------+
>   |                RMI4 Driver             | Data Layer
>   |                (this file)             |
>   +-----+-----+-------+----------+---------+
>   | I2C | SPI | SMBus |         etc.       | Physical Layer
>   +-----+-----+-------+----------+---------+
> 
> Thanks for the guidance!
> 
> Best Regards
> Abraham
