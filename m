From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
Date: Sun, 10 Feb 2019 12:43:21 -0500
Message-ID: <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
References: <20190207224650.GA49861@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207224650.GA49861@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, Feb 7, 2019 at 5:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> We should be using flush_delayed_work() instead of flush_work() in
> matrix_keypad_stop() to ensure that we are not missing work that is
> scheduled but not yet put in the workqueue (i.e. its delay timer has not
> expired yet).
>

Could the following scenario cause a use-after-free?
(I am adding comments on lines starting with -->)

a) user closes the device handle:

static void matrix_keypad_stop(struct input_dev *dev)
{
        struct matrix_keypad *keypad = input_get_drvdata(dev);

        spin_lock_irq(&keypad->lock);
        keypad->stopped = true;
        spin_unlock_irq(&keypad->lock);

        flush_work(&keypad->work.work);
-->
--> new interrupt comes in, and schedules new delayed keypad->work (1)
-->
        /*
         * matrix_keypad_scan() will leave IRQs enabled;
         * we should disable them now.
         */
        disable_row_irqs(keypad);
}

b) user removes the keypad, or unloads the module:

static int matrix_keypad_remove(struct platform_device *pdev)
{
        struct matrix_keypad *keypad = platform_get_drvdata(pdev);

        matrix_keypad_free_gpio(keypad);
        input_unregister_device(keypad->input_dev);
        kfree(keypad);

-->
--> delayed keypad->work scheduled at (1) above executes anywhere past here,
--> and causes a user-after-free.
-->

        return 0;
}
