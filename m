From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Possible race in ucb1400_ts.ko
Date: Tue, 15 Aug 2017 11:14:35 -0700
Message-ID: <20170815181435.GA14966@dtor-ws>
References: <237b7e86-f8da-ae37-b56d-4786bbfaefc4@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <237b7e86-f8da-ae37-b56d-4786bbfaefc4@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Volkov <avolkov@ispras.ru>
Cc: marek.vasut@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

Hi Anton,

On Tue, Aug 15, 2017 at 04:46:25PM +0300, Anton Volkov wrote:
> Hello.
> 
> While searching for races in the Linux kernel I've come across
> "drivers/input/touchscreen/ucb1400_ts.ko" module. Here is a question
> that I came up with while analyzing results. Lines are given using
> the info from Linux v4.12.
> 
> Consider the following case:
> 
> Thread 1:                   Thread 2:
> ucb1400_suspend
> ->ucb1400_ts_start
>     ucb->stopped = false
>     enable_irq()
> 
> ucb1400_resume
> ->ucb1400_ts_stop           ucb1400_irq
>     ucb->stopped = true       while(!ucb->stopped && ...)
>     (ucb1400_ts.c: line 230)  (ucb1400_ts.c: line 202)
>     disable_irq()
> 
> The value of ucb->stopped may be changed in the midst of 'while'
> loop iterations or prevent all of them from happening. Is this
> feasible from your point of view? If so, is it a benign race or is
> it serious?

Well, I guess nobody is using that driver in mainline, or at least not
with platforms that do system suspend. The suspend is supposed to call
ucb1400_ts_stop(), not ucb1400_ts_start(), and resume is messed up as
well.

We need to fix it. Once it is done, then it should look better. The
ucb->stopped can change in the middle of while loop, and that should
cause the interrupt handler to stop running. The "stop" uses
disable_irq() and thus will wait for the interrupt handler to finish
before continuing.

Thanks.

-- 
Dmitry
