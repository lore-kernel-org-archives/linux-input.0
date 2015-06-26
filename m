From: Stephen Chandler Paul <cpaul@redhat.com>
Subject: Re: [PATCH v3] i8042: Add debug_kbd option
Date: Fri, 26 Jun 2015 19:21:47 -0400
Message-ID: <1435360907.12848.2.camel@redhat.com>
References: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
	 <1435357698-13804-1-git-send-email-cpaul@redhat.com>
	 <20150626230500.GA22932@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbbFZXVu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jun 2015 19:21:50 -0400
In-Reply-To: <20150626230500.GA22932@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Fri, 2015-06-26 at 16:05 -0700, Dmitry Torokhov wrote:
> Hi Stephen,
> 
> On Fri, Jun 26, 2015 at 06:28:18PM -0400, cpaul@redhat.com wrote:
> > From: Stephen Chandler Paul <cpaul@redhat.com>
> > 
> > A big problem with the current i8042 debugging option is that it 
> > outputs
> > data going to and from the keyboard by default. As a result, many 
> > dmesg
> > logs uploaded by users will unintentionally contain sensitive 
> > information
> > such as their password, as such it's probably a good idea not to 
> > output
> > data coming from the keyboard unless specifically enabled by the 
> > user.
> > 
> > Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> > ---
> > That patch was not working at all like I thought it was, the 
> > results on the
> > machine I tested it on were very misleading so I apologize for any 
> > trouble that
> > may have caused! I've done more thorough testing of this, and it 
> > should work
> > perfectly on any machine.
> > 
> > 				    Changes
> > * Bus structs are shared between devices, whoops. Now when the 
> > notifier goes
> >   off we check two things:
> >     * That the device actually belongs to the i8042 platform 
> > driver. This is
> >       something that's difficult to reproduce, since devices on the 
> > i8042 bus
> >       are usually handled by the plaform driver. If they don't 
> > happen to be
> >       however (which currently I've only seen with ps2emu, a kernel 
> > module I'm
> >       working on to replay PS/2 devices in the kernel), then we 
> > make the false
> >       assumption the port_data variable points to an i8042_port 
> > struct, and
> >       very likely crash the machine or worse.
> >     * That the IRQ of the port is equivalent to that of the KBD 
> > port, so that
> >       we only mask the interrupts coming from the keyboard.
> > 
> >  Documentation/kernel-parameters.txt |  3 ++
> >  drivers/input/serio/i8042.c         | 64 
> > +++++++++++++++++++++++++++++++++----
> >  drivers/input/serio/i8042.h         | 13 ++++++++
> >  3 files changed, 74 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/kernel-parameters.txt 
> > b/Documentation/kernel-parameters.txt
> > index ae44749..a9d2b19 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -1304,6 +1304,9 @@ bytes respectively. Such letter suffixes can 
> > also be entirely omitted.
> >  			     <bus_id>,<clkrate>
> >  
> >  	i8042.debug	[HW] Toggle i8042 debug mode
> > +	i8042.debug_kbd [HW] Enable printing of interrupt data 
> > from the KBD port
> > +			     (disabled by default, requires that 
> > i8042.debug=1
> > +			     be enabled)
> >  	i8042.direct	[HW] Put keyboard port into non-translated 
> > mode
> >  	i8042.dumbkbd	[HW] Pretend that controller can only read 
> > data from
> >  			     keyboard and cannot control its state
> > diff --git a/drivers/input/serio/i8042.c 
> > b/drivers/input/serio/i8042.c
> > index cb5ece7..0e17bdd 100644
> > --- a/drivers/input/serio/i8042.c
> > +++ b/drivers/input/serio/i8042.c
> > @@ -88,6 +88,10 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to 
> > detect controller settings");
> >  static bool i8042_debug;
> >  module_param_named(debug, i8042_debug, bool, 0600);
> >  MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
> > +
> > +static bool i8042_debug_kbd;
> > +module_param_named(debug_kbd, i8042_debug_kbd, bool, 0600);
> > +MODULE_PARM_DESC(i8042_kbd, "Turn i8042 kbd debugging output on or 
> > off (requires i8042.debug=1)");
> >  #endif
> >  
> >  static bool i8042_bypass_aux_irq_test;
> > @@ -116,6 +120,9 @@ struct i8042_port {
> >  	struct serio *serio;
> >  	int irq;
> >  	bool exists;
> > +#ifdef DEBUG
> > +	bool filter_dbg;
> > +#endif
> 
> Could we call it "driver_bound" and drop #ifdef DEBUG? In fact, I'd
> rager we dropped the #ifdef DEBUG arounf all bus notifier code.
> 
> >  	signed char mux;
> >  };
> >  
> > @@ -133,6 +140,9 @@ static bool i8042_kbd_irq_registered;
> >  static bool i8042_aux_irq_registered;
> >  static unsigned char i8042_suppress_kbd_ack;
> >  static struct platform_device *i8042_platform_device;
> > +#ifdef DEBUG
> > +static struct notifier_block i8042_kbd_bind_notifier_block;
> > +#endif
> >  
> >  static irqreturn_t i8042_interrupt(int irq, void *dev_id);
> >  static bool (*i8042_platform_filter)(unsigned char data, unsigned 
> > char str,
> > @@ -528,10 +538,10 @@ static irqreturn_t i8042_interrupt(int irq, 
> > void *dev_id)
> >  	port = &i8042_ports[port_no];
> >  	serio = port->exists ? port->serio : NULL;
> >  
> > -	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)\n",
> > -	    data, port_no, irq,
> > -	    dfl & SERIO_PARITY ? ", bad parity" : "",
> > -	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
> > +	filter_dbg(port->filter_dbg, data, "<- i8042 (interrupt, 
> > %d, %d%s%s)\n",
> > +		   port_no, irq,
> > +		   dfl & SERIO_PARITY ? ", bad parity" : "",
> > +		   dfl & SERIO_TIMEOUT ? ", timeout" : "");
> >  
> >  	filtered = i8042_filter(data, str, serio);
> >  
> > @@ -1329,6 +1339,13 @@ static void __init 
> > i8042_register_ports(void)
> >  				i8042_ports[i].irq);
> >  			serio_register_port(serio);
> >  			device_set_wakeup_capable(&serio->dev, 
> > true);
> > +#ifdef DEBUG
> > +			if (i == I8042_KBD_PORT_NO) {
> > +				bus_register_notifier(
> > +					serio->dev.bus,
> > +					&i8042_kbd_bind_notifier_b
> > lock);
> > +			}
> 
> 
> Umm, let's export serio_bus and register the notifier when we load 
> the
> module.
> 

Sorry, but would you mind clarifying what you mean by "export
serio_bus"?

Cheers,
	Stephen Chandler Paul
