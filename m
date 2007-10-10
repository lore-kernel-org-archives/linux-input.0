From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Generic, platform independent matrix keyboard support
Date: Wed, 10 Oct 2007 09:48:47 -0400
Message-ID: <d120d5000710100648w24ca7fe8g6bbedf5502a6df75@mail.gmail.com>
References: <200709021228.58354.ppisa4lists@pikron.com>
	 <200710091222.10677.ppisa4lists@pikron.com>
	 <d120d5000710090922t94cb098v8cf923b2cecac63b@mail.gmail.com>
	 <200710100332.35807.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710100332.35807.ppisa4lists@pikron.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Pisa <ppisa4lists@pikron.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On 10/9/07, Pavel Pisa <ppisa4lists@pikron.com> wrote:
>
> Name of corresponding platform and PCI methods is probe.
> But name can be changed if new one is seen as more logical.
>

There you indeed probing devices for supported functionality. But here
you just register a new object with the system (note that all such
methods have 'register' in them - device_register(),
input_register_device() , etc).

> > > +
> > > +       input_dev = input_allocate_device();
> > > +       if (!input_dev)
> > > +               goto fail_arr_alloc;
> > > +
> > > +       kbd->input = input_dev;
> > > +       kbd->hw_dev = dev;
> > > +       dev_set_drvdata(dev, kbd);
> >
> > Does not belong here.
>
> Where I can store pointer to specialized part.
>

I mean setting up kbd does not belong here. You set it up (by setting
hw_dev and  calling dev_set_drvdadat) before calling
genmatrix_register().

> > > +
> > > +       /* Setup input device */
> > > +       input_dev->name = "GenMatrix Keyboard";
> > > +       input_dev->phys = kbd->phys;
> > > +       input_dev->dev.parent = dev;
> >
> > Make this input_dev->dev.parent = kbd->dev; and get rid of dev argument.
>
> I am not fully sure what it would cause in device model hierarchy,
> but I try to learn and check that.
>

I meant input_dev->dev.parent = kbd->hw_dev;

> > > +
> > > +       input_dev->id.bustype = BUS_HOST;
> > > +       input_dev->id.vendor = 0x0001;
> > > +       input_dev->id.product = 0x0001;
> > > +       input_dev->id.version = 0x0100;
> > > +
> > > +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP); /* BIT(EV_PWR) |
> > > BIT(EV_SW); */ +       input_dev->keycode = kbd->keycode;
> > > +       input_dev->keycodesize = sizeof(*kbd->keycode);
> > > +       input_dev->keycodemax = kbd->keycode_cnt;
> > > +
> > > +       for (i = 0; i < kbd->keycode_cnt; i++)
> > > +               set_bit(kbd->keycode[i], input_dev->keybit);
> > > +       clear_bit(0, input_dev->keybit);
> > > +       /*
> > > +       set_bit(SW_LID, input_dev->swbit);
> > > +       set_bit(SW_TABLET_MODE, input_dev->swbit);
> > > +       set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
> > > +       */
> > > +
> > > +       err = kbd->setup(kbd->hw_dev);
> > > +       if (err) {
> > > +               dev_err(kbd->hw_dev, "low-level hardware setup
> > > failed\n"); +               goto fail;
> > > +       }
> > > +
> > > +       err = input_register_device(input_dev);
> > > +       if (err) {
> > > +               dev_err(kbd->hw_dev, "input device registration\n");
> > > +               goto fail_to_register;
> > > +       }
> > > +
> > > +       mod_timer(&kbd->timer, jiffies + 1);
> >
> > Do not start timer/IRQs until there are users. Implement
> > inptu_dev->open() abd ->close() and do it from there.
>
> OK, that is right solution. I look at that.
>
> > > +static int genmatrix_remove(struct device *dev)
> > > +{
> > > ..........
> > > +       dev_set_drvdata(dev, NULL);
> > > +
> > > +       kfree(kbd->phys);
> > > +       kfree(kbd->down_arr);
> > > +       kfree(kbd->chng_arr);
> > > +       kfree(kbd->keycode);
> >
> > I don't see you allocate kbd->keycode, why are you freeing it?
>
> Somebody has to remove it. May it be, that free calls could/should
> be distributed different way between genmatrix_plat_remove()
> and genmatrix_remove().
>
> > > +
> > > +       kfree(kbd);
> >
> > Actually, why are you freeing kbd? If it was not allocated in probe(),
> > it should not be freed in remove().
>
> Somebody has to free it.  The genmatrix_remove() may be more
> appropriate, but I would be happy to not teach that how pointer to
> kbd is stored in dev hierarchy. But move could be right thing to do.
>

But kbd may be a part of a bigger structure and not allocated
separately. I prefer the following rule - if a layer did not allocate
a resource it should not try to free it.

-- 
Dmitry
