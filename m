From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Generic, platform independent matrix keyboard support
Date: Tue, 9 Oct 2007 12:22:40 -0400
Message-ID: <d120d5000710090922t94cb098v8cf923b2cecac63b@mail.gmail.com>
References: <200709021228.58354.ppisa4lists@pikron.com>
	 <200710090218.27964.ppisa4lists@pikron.com>
	 <20071009074020.GA14231@flint.arm.linux.org.uk>
	 <200710091222.10677.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710091222.10677.ppisa4lists@pikron.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Pisa <ppisa4lists@pikron.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Pavel,

On 10/9/07, Pavel Pisa <ppisa4lists@pikron.com> wrote:
> Subject: Generic, platform independent matrix keyboard support
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>
> The genmatrix_kbd module provides support for matrix keyboard
> where switches interconnects return lines with port driven
> scan lines. Actual version code allow to register concrete
> hardware described by platform device. Hardware can be described
> by list of output and input pins and manipulation can be delegated
> to GPIO layer or hardware specific setup(), release(), activate_all()
> deactivate_all() and scan_single() functions can be defined.
>

Only commenting on the generic part, not GPIO for now...

> +
> +#include <linux/genmatrix_kbd.h>
> +
> +/* Some sane defaults */
> +#define KEY_PUSH_T      20
> +#define KEY_RELEASE_T   10
> +#define KEY_PUSHCHECK_T  20
> +
> +/* Individual key states */
> +#define KEY_STATE_IDLE     0
> +#define KEY_STATE_PUSH     1
> +#define KEY_STATE_RELEASE  2
> +#define KEY_STATE_PUSHED   4
> +#define KEY_STATE_NOISE    8
> +#define KEY_STATE_BUSY     (KEY_STATE_PUSH|KEY_STATE_RELEASE)
> +
> +/* Bit flags */
> +#define GENMATRIX_FLG_WITH_IRQ_b 0
> +#define GENMATRIX_FLG_IRQ_EN_b   1
> +
> +typedef unsigned genmatrix_retmask_t;
> +
> +struct genmatrix_kbd {
> +       struct input_dev   *input;
> +       struct device      *hw_dev;
> +       char   *phys;
> +       unsigned long      flags;
> +
> +       /* Platform specific information */
> +       unsigned           scan_cnt;
> +       unsigned           ret_cnt;
> +
> +       int  (*setup)(struct device *dev);
> +       void (*release)(struct device *dev);
> +       unsigned (*activate_all)(struct device *dev, int setup_irq);
> +       void (*deactivate_all)(struct device *dev, int disable_irq);
> +       unsigned (*scan_single)(struct device *dev, unsigned scannr);
> +
> +       /* State of keyboard matrix and key press reporting */
> +       genmatrix_retmask_t *down_arr;  /* array of size scan_cnt */
> +       genmatrix_retmask_t *chng_arr;  /* array of size scan_cnt */
> +       unsigned char      key_hit;

I see you are setting it but never use...

> +       int                key_last_changed;
> +
> +       /* Internal state for repeat processing */
> +       int                key_state;
> +       unsigned long      check_time;

Input core alredy has repeat processing. Is it not sufficient?

> +
> +       unsigned long      push_time;
> +       unsigned long      release_time;
> +       unsigned long      pushcheck_time;
> +
> +       spinlock_t         lock;

OK, you have a lock, but I don't see it being used anywhere.

> +       struct timer_list  timer;
> +
> +       /* Scancode to key translation */
> +       unsigned           keycode_cnt;
> +       unsigned char      *keycode;
> +
> +       int                suspended;

What is 'suspended' member needed for?

> +};
> +
> +/**
> + * genmatrix_scan - Scan keyboard matrix and report requests for state change
> + * @kbd:       keyboard instance data and state structure
> + *
> + * Scans keyboard matrix connected row by row by calling function
> + * mx1_kbd_onerow(). Number of scanned output lines is defined
> + * by %KBD_SCAN_CNT. Checks read keyboard state against @down_arr
> + * and updates @key_change_arr array. The @down_arr state is
> + * left unchanged. It is changed later by kbd_down() function.
> + * Returns 0, if no keyboard activity is found. Returns 1
> + * if at least one key is pressed. Returns 2 or 3 in case
> + * of detected change.
> + */

The comment refers to non-existing functions. This makes harder to
fugure out what is going on.

> +static int genmatrix_scan(struct genmatrix_kbd *kbd)
> +{
> +       int i, ret = 0;
> +       genmatrix_retmask_t val, chng;
> +       for (i = 0; i < kbd->scan_cnt; i++) {
> +               val = kbd->scan_single(kbd->hw_dev, i);
> +               chng = val ^ kbd->down_arr[i];
> +               kbd->chng_arr[i] = chng;

Ok, so there can be only 32 keys per row... Kind of unfortunate
limitation for generic layer. Although if you forget about matrix
stuff and convert down_arr and chg_arr to be just a bitmaps and pass
it to scan_single along with irq (if any) that could be generic
enough.

> +               if (val)
> +                       ret |= 1;
> +               if (chng)
> +                       ret |= 2;
> +       }
> +       return ret;
> +}
> +
> +/**
> + * genmatrix_down - Detects changed key scancode and applies changes to matrix state
> + * @kbd:       keyboard instance data and state structure
> + *
> + * Functions check @chng_arr and process changes.
> + * It updates its internal state @key_state, does
> + * noise cancellation and repeat timing, then updates
> + * @down_arr, stores detected scancode to @key_last_changed
> + * and calls modifiers processing kbd_scan2mod().
> + * Return value is zero if no change is detected.
> + * In other case evaluated scancode is returned.
> + * Variable @key_hit signals by value 1 pressed key, by value
> + * 2 key release.
> + */
> +static int genmatrix_down(struct genmatrix_kbd *kbd)
> +{
> +       int si, ri = 0;
> +       unsigned char val;
> +       unsigned long act_time = jiffies;
> +
> +       if (!(kbd->key_state & KEY_STATE_BUSY)) {
> +               for (si = 0; si < kbd->scan_cnt; si++) {
> +                       val = kbd->chng_arr[si];
> +                       if (!val) continue;
> +                       ri = fls(val) - 1;
> +                       kbd->key_last_changed = si * kbd->ret_cnt + ri;
> +                       if (kbd->down_arr[si] & (1 << ri)) {
> +                               kbd->check_time = act_time + kbd->push_time;
> +                               kbd->key_state = KEY_STATE_RELEASE;
> +                       } else {
> +                               kbd->check_time = act_time + kbd->release_time;
> +                               kbd->key_state = KEY_STATE_PUSH;
> +                       }
> +                       break;
> +               }
> +               if (kbd->key_state == KEY_STATE_IDLE)
> +                       return 0;
> +       } else {
> +               if (kbd->key_last_changed < 0) {
> +                       kbd->key_state = KEY_STATE_IDLE;
> +                       return 0;
> +               }
> +               si = (kbd->key_last_changed) / kbd->ret_cnt;
> +               ri = (kbd->key_last_changed) % kbd->ret_cnt;
> +               if (!(kbd->chng_arr[si] & (1 << ri))) {
> +                       /* Noise detected */
> +                       if (!(kbd->key_state & KEY_STATE_NOISE)) {
> +                               kbd->check_time = act_time + kbd->release_time;
> +                               kbd->key_state |= KEY_STATE_NOISE;
> +                       }
> +               }
> +       }
> +
> +       if (!time_after(jiffies, kbd->check_time))
> +               return 0;
> +
> +       if (kbd->key_state == KEY_STATE_PUSH) {
> +               kbd->down_arr[si] |= 1 << ri;
> +               kbd->key_state = KEY_STATE_PUSHED;
> +               kbd->check_time = act_time + kbd->pushcheck_time;
> +               kbd->key_hit = 1;
> +               input_report_key(kbd->input, kbd->keycode[kbd->key_last_changed], 1);
> +               return 1;

What happens if we have several keys pressed at once? It looks like
we'll lose keypresses.

> +       } else if (kbd->key_state == KEY_STATE_PUSHED) {
> +               kbd->check_time = act_time + kbd->pushcheck_time;
> +               return 0;

Input core already does filtering of duplicate events, there is no
need to reimplement it.

> +       } else if (kbd->key_state == KEY_STATE_RELEASE) {
> +               kbd->down_arr[si] &= ~(1<<ri);
> +               kbd->key_state = KEY_STATE_IDLE;
> +               kbd->key_hit = 2;
> +               input_report_key(kbd->input, kbd->keycode[kbd->key_last_changed], 0);
> +               return 2;

And we risk losing releases as well.

> +       }
> +       kbd->key_state = KEY_STATE_IDLE;
> +       return 0;
> +}
> +
> +/**
> + * genmatrix_report_irq - The call-back notifying about IRQ arrival
> + * @dev:       device structure of given genmatrix instance
> + *
> + * This function is called by concrete keyboard hardware adaptation
> + * layer to notify driver core about activation of some return line.
> + * The function deactivates lines and queues event for delayed
> + * processing by the driver core
> + */
> +void genmatrix_report_irq(struct device *dev)
> +{
> +       int res;
> +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> +       res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> +       kbd->deactivate_all(kbd->hw_dev, res);
> +       mod_timer(&kbd->timer, jiffies + 1);

Why do we need to relay the work to timer? The execution context is
the same, why not do it right here?

> +}
> +EXPORT_SYMBOL(genmatrix_report_irq);
> +
> +/**
> + * genmatrix_timer - Time and event driven processing of keyboard state
> + * @context:   registered pointer to keyboard instance data and state structure
> + *
> + * The function disables IRQs if they have been enabled, the it calls
> + * genmatrix_scan() which reports found changes by setting corresponding
> + * bits of @chng_arr. If there is change or there is unfinished
> + * previous state processing, genmatrix_down() is called.
> + * If the final state is %KEY_STATE_IDLE, the wait for state
> + * change is armed else periodic matrix monitoring is scheduled.
> + */
> +static void genmatrix_timer(unsigned long context)
> +{
> +       struct genmatrix_kbd *kbd = (struct genmatrix_kbd *)context;
> +       int res;
> +       unsigned long ticks;
> +
> +       if (test_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags)) {
> +               res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);

What if interrupt arrives here?

> +               kbd->deactivate_all(kbd->hw_dev, res);
> +       }
> +
> +       res = genmatrix_scan(kbd);
> +       if (res & 2)
> +               dev_dbg(kbd->hw_dev, "genmatrix_scan returned %d, state %d, last %d\n",
> +                       res, kbd->key_state, kbd->key_last_changed);
> +
> +       if (res || (kbd->key_state != KEY_STATE_IDLE)) {
> +               res = genmatrix_down(kbd);
> +               if (res)
> +                       dev_dbg(kbd->hw_dev, "genmatrix_down returned %d, last %d\n",
> +                               res, kbd->key_last_changed);
> +       }
> +
> +       if (test_bit(GENMATRIX_FLG_WITH_IRQ_b, &kbd->flags) &&
> +               (kbd->key_state == KEY_STATE_IDLE)) {
> +
> +               res = test_and_set_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> +               kbd->activate_all(kbd->hw_dev, !res);

Do we really need this test? How can IRQ be already enabled here?

> +               if (res || !test_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags))
> +                       mod_timer(&kbd->timer, jiffies + kbd->pushcheck_time);
> +       } else {
> +               res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> +               kbd->deactivate_all(kbd->hw_dev, res);

Do you expect IRQ mode to change after device registration?

> +               ticks = kbd->check_time - jiffies;
> +               if ((long)ticks <= kbd->pushcheck_time / 4)
> +                       ticks = (kbd->pushcheck_time + 3) / 4;
> +               if (ticks > kbd->pushcheck_time)
> +                       ticks = kbd->pushcheck_time;
> +

Why is this needed? In polled mode I expect the timer fie exactly
every pushcheck_time jiffies.

> +               mod_timer(&kbd->timer, jiffies + ticks);
> +       }
> +}
> +
> +#ifdef CONFIG_PM
> +static int genmatrix_suspend(struct device *dev, pm_message_t state)
> +{
> +       int res;
> +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> +
> +       kbd->suspended = 1;
> +
> +       res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> +       kbd->deactivate_all(kbd->hw_dev, res);
> +
> +       return 0;
> +}
> +
> +static int genmatrix_resume(struct device *dev)
> +{
> +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> +
> +       kbd->suspended = 0;
> +
> +       mod_timer(&kbd->timer, jiffies + kbd->pushcheck_time);

Only restart timer if device is open.

> +       return 0;
> +}
> +
> +#endif
> +
> +const char genmatrix_input_name[] = "genmatrixkbd/input";

Does not seem to be used.

> +
> +static int genmatrix_probe_common(struct device *dev, struct genmatrix_kbd *kbd)
> +{
> +       struct input_dev   *input_dev;
> +       int    err = -ENOMEM;
> +       int    i;
> +
> +       /* Initialize spin-lock and timer */
> +       spin_lock_init(&kbd->lock);
> +       setup_timer(&kbd->timer, genmatrix_timer, (unsigned long)kbd);
> +
> +       /* State of keyboard matrix and key press reporting */
> +       kbd->key_hit = 0;
> +       kbd->key_last_changed = 0;
> +
> +       kbd->down_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]), GFP_KERNEL);
> +       if (!kbd->down_arr)
> +               goto fail_arr_alloc;
> +       kbd->chng_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]), GFP_KERNEL);
> +       if (!kbd->chng_arr)
> +               goto fail_arr_alloc;
> +
> +       /* Internal state for repeat processing */
> +       kbd->key_state = KEY_STATE_IDLE;
> +       kbd->check_time = jiffies;
> +
> +       kbd->push_time = msecs_to_jiffies(KEY_PUSH_T);
> +       kbd->release_time = msecs_to_jiffies(KEY_RELEASE_T);
> +       kbd->pushcheck_time = msecs_to_jiffies(KEY_PUSHCHECK_T);

I think these should be pre-initialized before getting into
generic_probe. We may try to apply sane defaults if they are 0 but
callers should be able to specify their own scan parameters. BTW
genmatrix_register() is probably a better name for this function.

> +
> +       input_dev = input_allocate_device();
> +       if (!input_dev)
> +               goto fail_arr_alloc;
> +
> +       kbd->input = input_dev;
> +       kbd->hw_dev = dev;
> +       dev_set_drvdata(dev, kbd);

Does not belong here.

> +
> +       /* Setup input device */
> +       input_dev->name = "GenMatrix Keyboard";
> +       input_dev->phys = kbd->phys;
> +       input_dev->dev.parent = dev;

Make this input_dev->dev.parent = kbd->dev; and get rid of dev argument.

> +
> +       input_dev->id.bustype = BUS_HOST;
> +       input_dev->id.vendor = 0x0001;
> +       input_dev->id.product = 0x0001;
> +       input_dev->id.version = 0x0100;
> +
> +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP); /* BIT(EV_PWR) | BIT(EV_SW); */
> +       input_dev->keycode = kbd->keycode;
> +       input_dev->keycodesize = sizeof(*kbd->keycode);
> +       input_dev->keycodemax = kbd->keycode_cnt;
> +
> +       for (i = 0; i < kbd->keycode_cnt; i++)
> +               set_bit(kbd->keycode[i], input_dev->keybit);
> +       clear_bit(0, input_dev->keybit);
> +       /*
> +       set_bit(SW_LID, input_dev->swbit);
> +       set_bit(SW_TABLET_MODE, input_dev->swbit);
> +       set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
> +       */
> +
> +       err = kbd->setup(kbd->hw_dev);
> +       if (err) {
> +               dev_err(kbd->hw_dev, "low-level hardware setup failed\n");
> +               goto fail;
> +       }
> +
> +       err = input_register_device(input_dev);
> +       if (err) {
> +               dev_err(kbd->hw_dev, "input device registration\n");
> +               goto fail_to_register;
> +       }
> +
> +       mod_timer(&kbd->timer, jiffies + 1);

Do not start timer/IRQs until there are users. Implement
inptu_dev->open() abd ->close() and do it from there.

> +
> +       return 0;
> +
> +fail_to_register:
> +       kbd->release(kbd->hw_dev);
> +       del_timer_sync(&kbd->timer);
> +fail:
> +       input_free_device(input_dev);
> +
> +fail_arr_alloc:
> +       kfree(kbd->phys);
> +       kfree(kbd->down_arr);
> +       kfree(kbd->chng_arr);
> +       kfree(kbd->keycode);
> +
> +       kbd->phys = NULL;
> +       kbd->down_arr = NULL;
> +       kbd->chng_arr = NULL;
> +       kbd->keycode = NULL;
> +
> +       return err;
> +}
> +
> +static int genmatrix_remove(struct device *dev)
> +{
> +       struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
> +       int res;
> +
> +       del_timer_sync(&kbd->timer);
> +
> +       res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
> +       kbd->deactivate_all(kbd->hw_dev, res);
> +
> +       del_timer_sync(&kbd->timer);
> +
> +       kbd->release(kbd->hw_dev);
> +
> +       input_unregister_device(kbd->input);
> +
> +       dev_set_drvdata(dev, NULL);
> +
> +       kfree(kbd->phys);
> +       kfree(kbd->down_arr);
> +       kfree(kbd->chng_arr);
> +       kfree(kbd->keycode);

I don't see you allocate kbd->keycode, why are you freeing it?

> +
> +       kfree(kbd);

Actually, why are you freeing kbd? If it was not allocated in probe(),
it should not be freed in remove().

The main advantage is that the code deals with noisy devices... How
widespread are they? I think we should take another look at this once
current implementation cleaned up.

Thanks.

-- 
Dmitry
