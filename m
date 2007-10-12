From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH try #2] Input/Joystick Driver: add support AD7142 joystick driver
Date: Fri, 12 Oct 2007 16:23:15 -0400
Message-ID: <d120d5000710121323w563cf328s315f95eb6a857b75@mail.gmail.com>
References: <1192174727.6247.20.camel@roc-laptop>
	 <20071012164131.GA12559@Ahmed>
	 <d120d5000710121029q400d05d8s38ae8769f2f44b15@mail.gmail.com>
	 <20071012192111.GB12559@Ahmed>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071012192111.GB12559@Ahmed>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Bryan Wu <bryan.wu@analog.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

On 10/12/07, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> On Fri, Oct 12, 2007 at 01:29:31PM -0400, Dmitry Torokhov wrote:
> >
> > > Isn't disabling device interrupts from the begining of the ISR "ad7142_interrupt"
> > > till the kthread "ad7142_thread" got waked-up and scheduled a long time,
> > > espicially if there's a high load on the userspace side ?
> > >
> >
> > It is OK - you disable a specific interrupt line preventing it from
> > raising any more IRQs until current one is serviced.
>
> Won't this affect system responsiveness if the IRQ line was shared ?

You are right, this would not work in case of shared IRQs. Hovewer
this driver is for an embedded arch and the line is not shared.

>
> >
> > This is different from disabling interrupts on CPU.
> >
>
> mm, Why disabling interrupts in general. Doesn't IRQ hanlers of the same kind got
> executed in a serialized fashion even on SMPs ?. If so, why not just wakeup our
> custom-thread or use workqueues and let them do their business ?

Because you don't want CPU to be continually interrupted while untill
right thread gets scheduled. I think using work[queue] is the best
solution for this driver, but you still want to mask that particular
IRQ off until you do the read.

-- 
Dmitry
