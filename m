From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 8/8] Input: elan_i2c - add Host Notify support
Date: Tue, 11 Oct 2016 16:20:52 +0200
Message-ID: <20161011142051.GL30411@mail.corp.redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476117755-8113-9-git-send-email-benjamin.tissoires@redhat.com>
 <CAKdAkRRK746K_+qqi+5YYfJ8NMBwbn5MYa02N4tn-qkfjnVwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRRK746K_+qqi+5YYfJ8NMBwbn5MYa02N4tn-qkfjnVwGg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Oct 10 2016 or thereabouts, Dmitry Torokhov wrote:
> Hi Benjamin,
> 
> On Mon, Oct 10, 2016 at 9:42 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > The Thinkpad series 13 uses Host Notify to report the interrupt.
> > Add elan_smb_alert() to handle those interrupts and disable the irq
> > handling on this case.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> 
> Why do we have to do this in the driver instead of having I2C core set
> it up for us? I expect we'd be repeating this block of code for every
> driver that has an option of using SMbus notify.

I didn't want to assign blindly an IRQ for Host Notify because it's a
device (as I2C client) feature. Not all SMBus clients on the Host Notify
capable bus are capable of Host Notify, so I thought it was the
responsibility of the driver to assign it.

However, I can see your point, though I'd need some inputs (and I'll
have to resend the series as the Intel bot showed me 2 mistakes).

So, if i2c-core gets to assign itself the IRQ for Host Notify, do we:
1) assign an IRQ to any SMBus device on a Host Notify capable adapter
   that doesn't have a valid provided IRQ?
2) have a new field in struct i2c_board_info that explicitly requires
   Host Notify as an IRQ?
3) do not touch anything in i2c_core, let the caller of i2c_new_device
   fill in the irq by a call to 
   i2c_smbus_host_notify_to_irq(adapter, address)?

1) has the advantage of being transparent for everybody, except we will
provide IRQs to devices that don't have one (this can be ignored), but
this may also lead to errors when IRQ is not correctly set by the caller
where it should be, and the driver/developer doesn't understand why it
is never triggered.

2) is a nice compromise, but we will need some OF binding, add some work
in for the callers of i2c_new_device() and will not work nicely with
sysfs instantiated i2c devices (the new_device sysfs entry). The sysfs
could be solved by adding some new address namespace, but that doesn't
make sense I think

3) requires less changes in i2c_core but it's going to be even harder
to add a device through sysfs that is Host Notify capable given that we
can't specify the IRQ.

After thinking a bit, I think I'd lean toward 1), but I am open to other
options as well.

Cheers,
Benjamin



> 
> Thanks!
> 
> > ---
> >
> > new in v4 (was submitted on linux-input with the .alert callback)
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index 6f16eb4..4aaac5d 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -1040,6 +1040,21 @@ static int elan_probe(struct i2c_client *client,
> >                                                 I2C_FUNC_SMBUS_BLOCK_DATA |
> >                                                 I2C_FUNC_SMBUS_I2C_BLOCK)) {
> >                 transport_ops = &elan_smbus_ops;
> > +
> > +               if (!irq) {
> > +                       if (!i2c_check_functionality(client->adapter,
> > +                                       I2C_FUNC_SMBUS_HOST_NOTIFY)) {
> > +                               dev_err(dev, "no Host Notify support\n");
> > +                               return -ENODEV;
> > +                       }
> > +
> > +                       irq = i2c_smbus_host_notify_to_irq(client);
> > +                       if (irq < 0) {
> > +                               dev_err(dev,
> > +                                       "Unable to request a Host Notify IRQ.\n");
> > +                               return irq;
> > +                       }
> > +               }
> >         } else {
> >                 dev_err(dev, "not a supported I2C/SMBus adapter\n");
> >                 return -EIO;
> > --
> > 2.7.4
> >
> 
> 
> 
> -- 
> Dmitry
