From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
Date: Mon, 11 Feb 2019 00:29:02 -0800
Message-ID: <20190211082902.GA95126@dtor-ws>
References: <20190207224650.GA49861@dtor-ws>
 <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Sven,

On Sun, Feb 10, 2019 at 12:43:21PM -0500, Sven Van Asbroeck wrote:
> Hi Dmitry,
> 
> On Thu, Feb 7, 2019 at 5:46 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > We should be using flush_delayed_work() instead of flush_work() in
> > matrix_keypad_stop() to ensure that we are not missing work that is
> > scheduled but not yet put in the workqueue (i.e. its delay timer has not
> > expired yet).
> >
> 
> Could the following scenario cause a use-after-free?
> (I am adding comments on lines starting with -->)
> 
> a) user closes the device handle:
> 
> static void matrix_keypad_stop(struct input_dev *dev)
> {
>         struct matrix_keypad *keypad = input_get_drvdata(dev);
> 
>         spin_lock_irq(&keypad->lock);
>         keypad->stopped = true;
>         spin_unlock_irq(&keypad->lock);
> 
>         flush_work(&keypad->work.work);
> -->
> --> new interrupt comes in, and schedules new delayed keypad->work (1)

It will not schedule new work because we check keypad->stopped flag
in ISR.

Thanks.

-- 
Dmitry
