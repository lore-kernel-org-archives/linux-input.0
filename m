From: Pavel Pisa <ppisa4lists@pikron.com>
Subject: Re: [PATCH] Generic, platform independent matrix keyboard support
Date: Wed, 10 Oct 2007 03:32:34 +0200
Message-ID: <200710100332.35807.ppisa4lists@pikron.com>
References: <200709021228.58354.ppisa4lists@pikron.com> <200710091222.10677.ppisa4lists@pikron.com> <d120d5000710090922t94cb098v8cf923b2cecac63b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710090922t94cb098v8cf923b2cecac63b@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hello Dimitry,

thanks for review and excuse for my mistakes and not well
described things.

On Tuesday 09 October 2007 18:22, Dmitry Torokhov wrote:
> On 10/9/07, Pavel Pisa <ppisa4lists@pikron.com> wrote:
> > Subject: Generic, platform independent matrix keyboard support
>
> Only commenting on the generic part, not GPIO for now...

OK

> > +       /* State of keyboard matrix and key press reporting */
> > +       genmatrix_retmask_t *down_arr;  /* array of size scan_cnt */
> > +       genmatrix_retmask_t *chng_arr;  /* array of size scan_cnt */
> > +       unsigned char      key_hit;
>
> I see you are setting it but never use...

It slipped there from original code, which solves even key repeat
and shift/modifiers processing in same FSM as noise suppression.
The actual dual processing in the driver and input layer leads
to some waste of timer, but is better layered. I agree, that
Linux input subsystem core has evolved into really advanced
piece of code. The option would be to integrate optional noise
suppression directly into it. But I am not sure, if it would not
lead more to mess then good design.

So I am removing abundant key_hit.

> > +       int                key_last_changed;
> > +
> > +       /* Internal state for repeat processing */
> > +       int                key_state;
> > +       unsigned long      check_time;
>
> Input core alredy has repeat processing. Is it not sufficient?

OK, comment has not been updated, state is only
for noise suppression processing in the Linux case.
Comment corrected.

> > +
> > +       unsigned long      push_time;
> > +       unsigned long      release_time;
> > +       unsigned long      pushcheck_time;
> > +
> > +       spinlock_t         lock;
>
> OK, you have a lock, but I don't see it being used anywhere.

Good catch, I have thought that I would need it to serialize
interrupts, timer processing and IRQ enabling. I have solved
all these without need of any locking. If it is preferred,
I remove it. On the other hand this is possible, that it could
be required in next driver iteration.
...
OK, I remove it to not harm your eyes.

> > +       struct timer_list  timer;
> > +
> > +       /* Scancode to key translation */
> > +       unsigned           keycode_cnt;
> > +       unsigned char      *keycode;
> > +
> > +       int                suspended;
>
> What is 'suspended' member needed for?

It holds that information. It is found in other drivers.
I expected to use it to block IRQ and timer processing
in the suspended state. I have added check to the
genmatrix_timer() for it.

> > +};
> > +
> > +/**
> > + * genmatrix_scan - Scan keyboard matrix and report requests for state
> > change + * @kbd:       keyboard instance data and state structure
> > + *
> > + * Scans keyboard matrix connected row by row by calling function
> > + * mx1_kbd_onerow(). Number of scanned output lines is defined
> > + * by %KBD_SCAN_CNT. Checks read keyboard state against @down_arr
> > + * and updates @key_change_arr array. The @down_arr state is
> > + * left unchanged. It is changed later by kbd_down() function.
> > + * Returns 0, if no keyboard activity is found. Returns 1
> > + * if at least one key is pressed. Returns 2 or 3 in case
> > + * of detected change.
> > + */
>
> The comment refers to non-existing functions. This makes harder to
> fugure out what is going on.

OK, comments updated

> > +static int genmatrix_scan(struct genmatrix_kbd *kbd)
> > +{
> > +       int i, ret = 0;
> > +       genmatrix_retmask_t val, chng;
> > +       for (i = 0; i < kbd->scan_cnt; i++) {
> > +               val = kbd->scan_single(kbd->hw_dev, i);
> > +               chng = val ^ kbd->down_arr[i];
> > +               kbd->chng_arr[i] = chng;
>
> Ok, so there can be only 32 keys per row... Kind of unfortunate
> limitation for generic layer. Although if you forget about matrix
> stuff and convert down_arr and chg_arr to be just a bitmaps and pass
> it to scan_single along with irq (if any) that could be generic
> enough.

OK, you are right that I have not thought about this limitation.
On the other hand I cannot imagine electronic designed wanting
so many wires. Reduction of the wires counts is why matrix keyboards
are used. The 32 bits limitation then means that maximal supported
keyboard can be 32x32 key => 1024 keys, that is quite imposing.
I cannot imagine anybody selecting something like 2x33 keys,
but you are right that there is limitation. 32 lines are natural
limit of pin number quickly accessible by single read on 32-bit
system if optimized low level stuff is used. The same comes to mind
as limit for simple passed function return values. I have thought
and used this knowledge of matrix organization for simpler probe
in down processing, but this optimization in not used there yet.
I would be happy, if I would not need to expose down_arr and
chg_arr details to hardware specific functions as well.
If bits are simple array, then fast processing of return pins read
for one scan line gets to be complicated. 

So I agree, that there is limit. I try to thing about it a little
more.

> > +       if (kbd->key_state == KEY_STATE_PUSH) {
> > +               kbd->down_arr[si] |= 1 << ri;
> > +               kbd->key_state = KEY_STATE_PUSHED;
> > +               kbd->check_time = act_time + kbd->pushcheck_time;
> > +               kbd->key_hit = 1;
> > +               input_report_key(kbd->input,
> > kbd->keycode[kbd->key_last_changed], 1); +               return 1;
>
> What happens if we have several keys pressed at once? It looks like
> we'll lose keypresses.

No, the processing is done such way, that first detected change is
noted and checked until key gets stable. Then change is propagated
into down_arr and other key change is looked for.
This is safe. You can argue, that the double key simultaneous press
is not propagated with same time delay equivalent to noise check
for both keys. That is correct, but user is not typically able
to time keys so precisely or rely on so precise key press events
timing. It could be problem for organ keys, but I think, that
it is different case, requires press force sensitivity in most
cases and different kind of HW solution.

I see as only other, really clean solution to have state automata
and timer for each key, but it would lead to much much higher
resources demand.

> > +       } else if (kbd->key_state == KEY_STATE_PUSHED) {
> > +               kbd->check_time = act_time + kbd->pushcheck_time;
> > +               return 0;
>
> Input core already does filtering of duplicate events, there is no
> need to reimplement it.

You are right there, but state processing is necessary for noise
filterring anyway so I do not see any reason for the overhead
of calling of the input layer there.

> > +       } else if (kbd->key_state == KEY_STATE_RELEASE) {
> > +               kbd->down_arr[si] &= ~(1<<ri);
> > +               kbd->key_state = KEY_STATE_IDLE;
> > +               kbd->key_hit = 2;
> > +               input_report_key(kbd->input,
> > kbd->keycode[kbd->key_last_changed], 0); +               return 2;
>
> And we risk losing releases as well.

No, same serialization there as above.

> > +void genmatrix_report_irq(struct device *dev)
> > +{
> > +       int res;
> > +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> > +       res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> > +       kbd->deactivate_all(kbd->hw_dev, res);
> > +       mod_timer(&kbd->timer, jiffies + 1);
>
> Why do we need to relay the work to timer? The execution context is
> the same, why not do it right here?

Because else there are two not synchronized context accessing same
state structure => serialization is required and Linux kernel
driver model would require ugly spinlock_irq there over relatively
long periods. This is bad for other interrupts and timers latencies
if RT patch is not used.

Other options is to be absolutely sure, that IRQ and timer
cannot be activated in parallel, but again, for SMP this
means some busy loops in irq_disable leading to IPI ...
nothing nice. In this case it is left on kernel to synchronize
timer removal and activation and ensuring that timer runs
only once. Again it could lead to complex cases on SMP,
but it is hidden in the kernel core and should be optimal
for given kernel build. The minimal delay is even advantage
for fast stopping of processing spike caused by noise.

But may it be, that there is some better solution there.

> > +static void genmatrix_timer(unsigned long context)
> > +{
> > +       struct genmatrix_kbd *kbd = (struct genmatrix_kbd *)context;
> > +       int res;
> > +       unsigned long ticks;
> > +
> > +       if (test_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags)) {
> > +               res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b,
> > &kbd->flags);
>
> What if interrupt arrives here?

If the interrupts are edge trigerred (reasonable requirement for keyboard),
than there is no problem. But for level triggered case this could lead
to the problem. But how could that be done better? I do not like to expose
interrupts numbers to the driver core. I did not like to move state into
deactivate_all/activate_all functions. This does not to seems simple for
me. Or OK, I can add spinlock and block IRQs over whole test_and_clear_bit() 
and deactivate_all(). Probably no so big lose for non RT kernels which
do not guarantee anything and converted to RT-mutex for RT ones.
But anyway, there may be some race problem in theory on SMP.

Returning lock to rethink this again.

> > +               kbd->deactivate_all(kbd->hw_dev, res);
> > +       }
> > +
> > +       res = genmatrix_scan(kbd);
> > +       if (test_bit(GENMATRIX_FLG_WITH_IRQ_b, &kbd->flags) &&
> > +               (kbd->key_state == KEY_STATE_IDLE)) {
> > +
> > +               res = test_and_set_bit(GENMATRIX_FLG_IRQ_EN_b,
> > &kbd->flags); +               kbd->activate_all(kbd->hw_dev, !res);
>
> Do we really need this test? How can IRQ be already enabled here?

It could be simplified probably.

> > +               if (res || !test_bit(GENMATRIX_FLG_IRQ_EN_b,
> > &kbd->flags)) +                       mod_timer(&kbd->timer, jiffies +
> > kbd->pushcheck_time); +       } else {
> > +               res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b,
> > &kbd->flags); +               kbd->deactivate_all(kbd->hw_dev, res);
>
> Do you expect IRQ mode to change after device registration?

Not at this moment.

> > +               ticks = kbd->check_time - jiffies;
> > +               if ((long)ticks <= kbd->pushcheck_time / 4)
> > +                       ticks = (kbd->pushcheck_time + 3) / 4;
> > +               if (ticks > kbd->pushcheck_time)
> > +                       ticks = kbd->pushcheck_time;
> > +
>
> Why is this needed? In polled mode I expect the timer fie exactly
> every pushcheck_time jiffies.

The first comparison ensures, that in kernel overload state the keyboard
would not make things even worse. The second one, that the extensive long
time is not used. The timing can be adjusted for different states, but may
it be, that it could be simplified for use within Linux kernel.

> > +static int genmatrix_resume(struct device *dev)
> > +{
> > +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> > +
> > +       kbd->suspended = 0;
> > +
> > +       mod_timer(&kbd->timer, jiffies + kbd->pushcheck_time);
>
> Only restart timer if device is open.

OK.

> > +       return 0;
> > +}
> > +
> > +#endif
> > +
> > +const char genmatrix_input_name[] = "genmatrixkbd/input";
>
> Does not seem to be used.

This is required for kbd->phys, which is needed for input_dev->phys.
I should move this near to genmatrix_plat_probe() instead of one
global name. But then name should reflect that. I should find
how to add some pseudo/unique number to the input to make
it better addressable.

> > +
> > +static int genmatrix_probe_common(struct device *dev, struct
> > genmatrix_kbd *kbd) +{
> > +       struct input_dev   *input_dev;
> > +       int    err = -ENOMEM;
> > +       int    i;
> > +
> > +       /* Initialize spin-lock and timer */
> > +       spin_lock_init(&kbd->lock);
> > +       setup_timer(&kbd->timer, genmatrix_timer, (unsigned long)kbd);
> > +
> > +       /* State of keyboard matrix and key press reporting */
> > +       kbd->key_hit = 0;
> > +       kbd->key_last_changed = 0;
> > +
> > +       kbd->down_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]),
> > GFP_KERNEL); +       if (!kbd->down_arr)
> > +               goto fail_arr_alloc;
> > +       kbd->chng_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]),
> > GFP_KERNEL); +       if (!kbd->chng_arr)
> > +               goto fail_arr_alloc;
> > +
> > +       /* Internal state for repeat processing */
> > +       kbd->key_state = KEY_STATE_IDLE;
> > +       kbd->check_time = jiffies;
> > +
> > +       kbd->push_time = msecs_to_jiffies(KEY_PUSH_T);
> > +       kbd->release_time = msecs_to_jiffies(KEY_RELEASE_T);
> > +       kbd->pushcheck_time = msecs_to_jiffies(KEY_PUSHCHECK_T);
>
> I think these should be pre-initialized before getting into
> generic_probe. We may try to apply sane defaults if they are 0 but
> callers should be able to specify their own scan parameters. BTW
> genmatrix_register() is probably a better name for this function.

Changed to allow caller specify different values.

Name of corresponding platform and PCI methods is probe.
But name can be changed if new one is seen as more logical.

> > +
> > +       input_dev = input_allocate_device();
> > +       if (!input_dev)
> > +               goto fail_arr_alloc;
> > +
> > +       kbd->input = input_dev;
> > +       kbd->hw_dev = dev;
> > +       dev_set_drvdata(dev, kbd);
>
> Does not belong here.

Where I can store pointer to specialized part.

> > +
> > +       /* Setup input device */
> > +       input_dev->name = "GenMatrix Keyboard";
> > +       input_dev->phys = kbd->phys;
> > +       input_dev->dev.parent = dev;
>
> Make this input_dev->dev.parent = kbd->dev; and get rid of dev argument.

I am not fully sure what it would cause in device model hierarchy,
but I try to learn and check that.

> > +
> > +       input_dev->id.bustype = BUS_HOST;
> > +       input_dev->id.vendor = 0x0001;
> > +       input_dev->id.product = 0x0001;
> > +       input_dev->id.version = 0x0100;
> > +
> > +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP); /* BIT(EV_PWR) |
> > BIT(EV_SW); */ +       input_dev->keycode = kbd->keycode;
> > +       input_dev->keycodesize = sizeof(*kbd->keycode);
> > +       input_dev->keycodemax = kbd->keycode_cnt;
> > +
> > +       for (i = 0; i < kbd->keycode_cnt; i++)
> > +               set_bit(kbd->keycode[i], input_dev->keybit);
> > +       clear_bit(0, input_dev->keybit);
> > +       /*
> > +       set_bit(SW_LID, input_dev->swbit);
> > +       set_bit(SW_TABLET_MODE, input_dev->swbit);
> > +       set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
> > +       */
> > +
> > +       err = kbd->setup(kbd->hw_dev);
> > +       if (err) {
> > +               dev_err(kbd->hw_dev, "low-level hardware setup
> > failed\n"); +               goto fail;
> > +       }
> > +
> > +       err = input_register_device(input_dev);
> > +       if (err) {
> > +               dev_err(kbd->hw_dev, "input device registration\n");
> > +               goto fail_to_register;
> > +       }
> > +
> > +       mod_timer(&kbd->timer, jiffies + 1);
>
> Do not start timer/IRQs until there are users. Implement
> inptu_dev->open() abd ->close() and do it from there.

OK, that is right solution. I look at that.

> > +static int genmatrix_remove(struct device *dev)
> > +{
> > ..........
> > +       dev_set_drvdata(dev, NULL);
> > +
> > +       kfree(kbd->phys);
> > +       kfree(kbd->down_arr);
> > +       kfree(kbd->chng_arr);
> > +       kfree(kbd->keycode);
>
> I don't see you allocate kbd->keycode, why are you freeing it?

Somebody has to remove it. May it be, that free calls could/should
be distributed different way between genmatrix_plat_remove()
and genmatrix_remove().

> > +
> > +       kfree(kbd);
>
> Actually, why are you freeing kbd? If it was not allocated in probe(),
> it should not be freed in remove().

Somebody has to free it.  The genmatrix_remove() may be more
appropriate, but I would be happy to not teach that how pointer to
kbd is stored in dev hierarchy. But move could be right thing to do.

> The main advantage is that the code deals with noisy devices... How
> widespread are they? I think we should take another look at this once
> current implementation cleaned up.

My own experience is, that there does not exists any mechanical
switch/contact without danger of unexpected brushes and noises.
The question is only time duration. Even microswitches has
brushes. But they are short (at least for new devices).
If they are directly connected to the TTL speed rate logic
than single edge cannot be guaranteed anyway. Only really
safe is to use both contact (DIS and CON) and connect them
to R/S flip-flop. So there does not exists any mechanical
matrix keyboard without noise and when you do new design,
it is misleading, that it works for new devices better
and if you are not prepared for rapid degradation you
end up with multiple software updates. For example TI-57..59
calculators are unusable today due to degraded keyboards
to the level, that it is big mastery to make single press.

But on the other hand, if scan frequency is slow (100Hz or 10Hz)
situation gets better. Anyway I would not believe device
without reasonable noise suppression for any little more
critical application. And as I have said, mechanical contact
is vengeful beast, it seems to work in lab and breaks in
field. And if you do not want to invest into really
expensive construction brushes duration is relatively long.

Because I have not resolved all notices yet, I am  sending
only pointer to the slightly updated patch.

http://rtime.felk.cvut.cz/repos/ppisa-linux-devel/kernel-patches/current/genmatrix-kbd.patch

Best wishes

             Pavel
