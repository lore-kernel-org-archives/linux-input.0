From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/4] Input: elan_i2c - add Host Notify support
Date: Mon, 3 Oct 2016 16:33:17 +0200
Message-ID: <20161003143317.GU19261@mail.corp.redhat.com>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
 <1475073244-23068-4-git-send-email-benjamin.tissoires@redhat.com>
 <20160930235744.GB1680@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160930235744.GB1680@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-input@vger.kernel.org

[Adding the I2C folks]

On Sep 30 2016 or thereabouts, Dmitry Torokhov wrote:
> On Wed, Sep 28, 2016 at 04:34:03PM +0200, Benjamin Tissoires wrote:
> > The Thinkpad series 13 uses Host Notify to report the interrupt.
> > Add elan_smb_alert() to handle those interrupts and disable the irq
> > handling on this case.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 100 ++++++++++++++++++++++++++++--------
> >  1 file changed, 78 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index 2de1f75..11671c7 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -96,6 +96,34 @@ struct elan_tp_data {
> >  	bool			baseline_ready;
> >  };
> >  
> > +static inline void elan_enable_irq(struct elan_tp_data *tp)
> > +{
> > +	if (tp->client->irq)
> > +		enable_irq(tp->client->irq);
> 
> Hmm, so I wonder, why alert is not implemented as irqchip? Then clients
> would not need to be bothered with these details, they'd simply requster
> and manipulate irqs.
> 

Sounds like a good idea. There are few things to be aware:
- I don't think it will be OK to blindly add a Host Notify irq when none
  is provided by ACPI, platform or device tree. I think we would need to
  add an API (i2c_host_notify_to_irq()) that will be called by the driver
- On both systems I have seen using Host Notify (Synaptics and Elan),
  none is using the payload available in Host Notify. That means
  that we can use in those case an irq but it'll add more complexity
  when we actually need this payload to be retrieved
- Host Notify uses the same .alert mechanism than SMBus Alert. I checked
  the users of this mechanism (lm90 and ipmi_ssif), and none uses the
  payload provided by SMbus Alert
- lm90 can use a provided irq in addition to SMBus Alert, which is my
  main concern if we override the client->irq in i2c-core.c

The more I think of it, the more I think this is a good idea given that
the mechanism provided by .alert are similar to irq (without the payload
option), and would allow to reduce the code in i2c-smbus.

I'd be fine to implement an irqchip for Host Notify, but do we want to:
- remove the current (yet unused) .alert Host Notify support?
- keep .alert and have an irqchip available depending on how the user
  wants to address these notifications?
- also switch SMBus Alert into an irq, which would mean we will lose the
  payload availability (or we will need some API to retrieve it)?

Any thoughts?

Cheers,
Benjamin
