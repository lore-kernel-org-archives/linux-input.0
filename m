From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Date: Thu, 14 Mar 2019 20:54:51 +0100
Message-ID: <20190314195451.GC6058@hirez.programming.kicks-ass.net>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20181019102031.77015d44@korsan.localdomain>
 <20181025074903.GA9323@amd>
 <20181028220654.7e77e5d7@ubuntu>
 <20181130154455.21578c4d@korsan.localdomain>
 <20181202222809.GA29467@amd>
 <20181218102302.2b029612@korsan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218102302.2b029612@korsan.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, jason.low2@hpe.com, Waiman.Long@hpe.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, dmitry.torokhov@gmail.com, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 18, 2018 at 10:23:02AM +0300, Numan Demirdöğen wrote:
> I found that passing the options i8042.reset=1 i8042.dumbkbd=1 i8042.direct=1
> results in the keyboard functioning after resume. However, there is a
> long delay before the keyboard or mouse will respond to input on the
> lock screen.[1]

So the thing is, the mutex works, there's nothing wrong or broken about
it (or we'd have known, the kernel would crash and burn). The hand-off
stuff fixed at least one known starvation case as well.

What it does do, is change timing behaviour. But that is something that
is not guaranteed anyway.

This all smells like there's some timing dependent behaviour (aka. race
condition) in the suspend/keyboard interaction _somewhere_.

Now, I know absolutely nothing about either suspend or keyboard stuff,
so I really can't help there. The best idea is to add trace_printk()
throughout the keyboard suspend/resume code and see if there's a clue to
be had there (using remote access to dump the trace buffer after resume,
because of lack of keyboard).

Obviously that takes someone who knows how that should work ...
