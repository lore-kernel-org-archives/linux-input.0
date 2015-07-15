From: Stephen Chandler Paul <cpaul@redhat.com>
Subject: Re: [PATCH v5] i8042: Add unmask_kbd_data option
Date: Wed, 15 Jul 2015 13:16:10 -0400
Message-ID: <1436980570.10553.0.camel@redhat.com>
References: <20150627203543.GA31870@rhlx01.hs-esslingen.de>
	 <1435852008-4509-1-git-send-email-cpaul@redhat.com>
	 <20150715165954.GA19828@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbbGORQM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2015 13:16:12 -0400
In-Reply-To: <20150715165954.GA19828@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Andreas Mohr <andi@lisas.de>

On Wed, 2015-07-15 at 09:59 -0700, Dmitry Torokhov wrote:
> Hi Stephen,
> 
> On Thu, Jul 02, 2015 at 11:46:48AM -0400, cpaul@redhat.com wrote:
> > +static int i8042_kbd_bind_notifier(struct notifier_block *nb,
> > +				   unsigned long action, void 
> > *data)
> > +{
> > +	struct device *dev = data;
> > +	struct serio *serio = to_serio_port(dev);
> > +	struct i8042_port *port = serio->port_data;
> > +
> > +	if (serio != i8042_ports[I8042_KBD_PORT_NO].serio)
> > +		return 0;
> > +
> > +	switch (action) {
> > +	case BUS_NOTIFY_BOUND_DRIVER:
> > +		port->driver_bound = true;
> > +		break;
> > +
> > +	case BUS_NOTIFY_UNBOUND_DRIVER:
> 
> I think it should be BUS_NOTIFY_UNBIND_DRIVER so that we see the KBD
> data as it goes through driver cleanup. Yell if you disagree, or I'll
> change it locally.
Sounds good to me

Cheers,
	Stephen Chandler Paul

> 
> Thanks.
> 
