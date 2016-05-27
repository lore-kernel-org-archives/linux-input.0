From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] Input: pwm-beeper - fix: scheduling while atomic
Date: Fri, 27 May 2016 11:11:33 +0200
Message-ID: <57480F45.7070106@gmx.at>
References: <56C4735E.6020300@gmx.at> <20160222194639.GD26177@dtor-ws>
 <20160512121852.GB26824@ulmo.ba.sec> <5735F4E3.20008@gmx.at>
 <573C8761.9070601@gmx.at> <20160520165918.GE14951@dtor-ws>
 <574411B5.2010407@gmx.at> <20160526003615.GE22369@dtor-ws>
 <57480B5C.7080409@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57480B5C.7080409@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On 2016-05-27 10:54, Manfred Schlaegl wrote:
> 
> Ok. Thanks for clarification.
> I will send a patch with the modifications you suggested before.
> 
> The following patch will also have some slight modifications in line numbers to make it apply after
> cfae56f18 (input: misc: pwm-beeper: Explicitly apply PWM config extracted from pwm_args).
> 
> best regards,
> Manfred
> 
While testing the patch I found another problem.

calling 
pwm_config(beeper->pwm, period / 2, period) with periode=0 leads to 

[  199.964836] Division by zero in kernel.
[  199.964875] CPU: 0 PID: 277 Comm: kworker/0:1 Not tainted 4.6.0-general-1-11011-g928f0cf #24
[  199.964887] Hardware name: Freescale i.MX53 (Device Tree Support)
[  199.964925] Workqueue: events pwm_beeper_work
[  199.964937] Backtrace: 
[  199.964970] [<c010a73c>] (dump_backtrace) from [<c010a920>] (show_stack+0x18/0x1c)
[  199.964980]  r6:00000000 r5:ce9fed9c r4:00000000 r3:00000000
[  199.965018] [<c010a908>] (show_stack) from [<c031ca78>] (dump_stack+0x20/0x28)
[  199.965037] [<c031ca58>] (dump_stack) from [<c010a888>] (__div0+0x18/0x20)
[  199.965053] [<c010a870>] (__div0) from [<c031b86c>] (Ldiv0+0x8/0x14)
[  199.965080] [<c034bbec>] (imx_pwm_config_v2) from [<c034bfb8>] (imx_pwm_config+0x68/0x88)
[  199.965088]  r9:00000000 r8:ceabf2c0 r7:00000000 r6:00000000 r5:ceabf440 r4:ce9fed9c
[  199.965121] [<c034bf50>] (imx_pwm_config) from [<c034b288>] (pwm_apply_state+0xfc/0x188)
[  199.965129]  r9:00000000 r8:cedd9a00 r7:00000000 r6:ceabf2e0 r5:ce9f7ec0 r4:ceabf2c0
[  199.965164] [<c034b18c>] (pwm_apply_state) from [<c0475b28>] (__pwm_beeper_set+0x60/0xd8)
[  199.965172]  r7:00000000 r6:ceabf2c0 r5:00000000 r4:cea92e80
[  199.965200] [<c0475ac8>] (__pwm_beeper_set) from [<c0475bb4>] (pwm_beeper_work+0x14/0x18)
[  199.965209]  r7:ce9da998 r6:c0908a80 r5:cea92e88 r4:ce9da980
[  199.965240] [<c0475ba0>] (pwm_beeper_work) from [<c01315c8>] (process_one_work+0x1f4/0x334)
[  199.965255] [<c01313d4>] (process_one_work) from [<c0131dc4>] (worker_thread+0x330/0x4ac)
[  199.965264]  r10:00000000 r9:00000008 r8:c0908a94 r7:ce9da998 r6:c0908a80 r5:c0908a80
[  199.965289]  r4:ce9da980
[  199.965311] [<c0131a94>] (worker_thread) from [<c0136308>] (kthread+0xe4/0xf8)
[  199.965319]  r10:00000000 r9:00000000 r8:00000000 r7:c0131a94 r6:ce9da980 r5:00000000
[  199.965342]  r4:cea7d900 r3:ce9f6000
[  199.965364] [<c0136224>] (kthread) from [<c01073b8>] (ret_from_fork+0x14/0x3c)
[  199.965372]  r7:00000000 r6:00000000 r5:c0136224 r4:cea7d900

I modified the patch, so that pwm_config is called only with periode >0

-       pwm_config(beeper->pwm, period / 2, period);
-
-       if (period == 0)
-               pwm_disable(beeper->pwm);
-       else
+       if (period) {
+               pwm_config(beeper->pwm, period / 2, period);
                pwm_enable(beeper->pwm);
+       } else
+               pwm_disable(beeper->pwm);

I will send the corrected patch shortly.

Best regards,
Manfred
