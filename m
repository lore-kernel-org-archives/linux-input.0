From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick driver
Date: Fri, 12 Oct 2007 11:50:12 -0400
Message-ID: <d120d5000710120850p64aae40ep95f98cfcee7d8d6f@mail.gmail.com>
References: <1192174727.6247.20.camel@roc-laptop>
	 <d120d5000710120749o2505dd7aq42559c35298f05d0@mail.gmail.com>
	 <1192203593.7089.4.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1192203593.7089.4.camel@roc-laptop>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: bryan.wu@analog.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On 10/12/07, Bryan Wu <bryan.wu@analog.com> wrote:
> On Fri, 2007-10-12 at 10:49 -0400, Dmitry Torokhov wrote:
> > Hi Bryan,
> >
> > On 10/12/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > > +
> [snip]
> > > +
> > > +static void ad7142_close(struct input_dev *dev)
> > > +{
> > > +       free_irq(CONFIG_BFIN_JOYSTICK_IRQ_PFX, ad7142_interrupt);
> > > +       kthread_stop(ad7142_task);
> >
> > Don't you need to write something over i2c to shut the devoce off?
> > What stops it from continuing to generate interrupts?
> >
> Actually, I am going to use "completion" to replace the whole
> wait_interrupt_xxx and intr_flag things which original from Aubrey. How
> do you think of that?
>

I don't think it is a very good idea - for me completion is one-time
deal. You use it and then you are done. How about firing a work from
interrupt and either rely on the default workqueue (keventd) or create
your own to execute it?

Thank you.

-- 
Dmitry
