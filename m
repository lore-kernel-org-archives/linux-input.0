From: Bryan Wu <bryan.wu@analog.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142
	joystick driver
Date: Fri, 12 Oct 2007 23:39:53 +0800
Message-ID: <1192203593.7089.4.camel@roc-laptop>
References: <1192174727.6247.20.camel@roc-laptop>
	 <d120d5000710120749o2505dd7aq42559c35298f05d0@mail.gmail.com>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758071AbXJLPkP@vger.kernel.org>
In-Reply-To: <d120d5000710120749o2505dd7aq42559c35298f05d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: bryan.wu@analog.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Fri, 2007-10-12 at 10:49 -0400, Dmitry Torokhov wrote:
> Hi Bryan,
> 
> On 10/12/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > +
[snip]
> > +
> > +static void ad7142_close(struct input_dev *dev)
> > +{
> > +       free_irq(CONFIG_BFIN_JOYSTICK_IRQ_PFX, ad7142_interrupt);
> > +       kthread_stop(ad7142_task);
> 
> Don't you need to write something over i2c to shut the devoce off?
> What stops it from continuing to generate interrupts?
> 
Actually, I am going to use "completion" to replace the whole
wait_interrupt_xxx and intr_flag things which original from Aubrey. How
do you think of that?

Thanks
-Bryan
