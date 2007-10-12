From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick driver
Date: Fri, 12 Oct 2007 21:21:11 +0200
Message-ID: <20071012192111.GB12559@Ahmed>
References: <1192174727.6247.20.camel@roc-laptop> <20071012164131.GA12559@Ahmed> <d120d5000710121029q400d05d8s38ae8769f2f44b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000710121029q400d05d8s38ae8769f2f44b15@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 12, 2007 at 01:29:31PM -0400, Dmitry Torokhov wrote:
> Hi Ahmed,
> 

Hi :),

> On 10/12/07, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> > On Fri, Oct 12, 2007 at 03:38:47PM +0800, Bryan Wu wrote:
> > >
> > > Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> > > ---
> >
> > Hi Bryan,
> >
> > Why creating module's own kthread to call ad7142_decode and process keycodes
> > instead of using a tasklet ?
> >
> 
> Yo can't access i2c from a tasklet context.
> 
> > Isn't disabling device interrupts from the begining of the ISR "ad7142_interrupt"
> > till the kthread "ad7142_thread" got waked-up and scheduled a long time,
> > espicially if there's a high load on the userspace side ?
> >
> 
> It is OK - you disable a specific interrupt line preventing it from
> raising any more IRQs until current one is serviced. 

Won't this affect system responsiveness if the IRQ line was shared ?

>
> This is different from disabling interrupts on CPU.
> 

mm, Why disabling interrupts in general. Doesn't IRQ hanlers of the same kind got
executed in a serialized fashion even on SMPs ?. If so, why not just wakeup our
custom-thread or use workqueues and let them do their business ?

It's the first time for me to read others' patches carefully and kindly ask about
some explanations. I hope I'm not bothering people with my misunderstandings!
(till I get more experienced).


Thanks,

-- 
Ahmed S. Darwish
HomePage: http://darwish.07.googlepages.com
Blog: http://darwish-07.blogspot.com
