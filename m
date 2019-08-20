From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add support for polling to input devices
Date: Tue, 20 Aug 2019 12:05:46 -0700
Message-ID: <20190820190546.GP121898@dtor-ws>
References: <20190809173548.GA32693@dtor-ws>
 <CAO-hwJL1Jq5XjqV32fD7+_nMpi3PhUbrB5QQ+EEs3N6=mBy-1g@mail.gmail.com>
 <20190812171135.GA178933@dtor-ws>
 <CAO-hwJKfHCwLkEDWrzJHejjaB+vY=0RsfY-=xfdRUSQPpeUVAg@mail.gmail.com>
 <8624c907-6d7e-3301-1044-113bb108ba9e@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8624c907-6d7e-3301-1044-113bb108ba9e@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 20, 2019 at 01:56:53PM +0200, Michal Vokáč wrote:
> On 13. 08. 19 16:04, Benjamin Tissoires wrote:
> > On Mon, Aug 12, 2019 at 7:11 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > 
> > > Hi Benjamin,
> > > 
> > > On Mon, Aug 12, 2019 at 06:50:38PM +0200, Benjamin Tissoires wrote:
> > > > Hi Dmitry,
> > > > 
> > > > On Fri, Aug 9, 2019 at 7:35 PM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > 
> > > > > Separating "normal" and "polled" input devices was a mistake, as often we
> > > > > want to allow the very same device work on both interrupt-driven and
> > > > > polled mode, depending on the board on which the device is used.
> > > > > 
> > > > > This introduces new APIs:
> > > > > 
> > > > > - input_setup_polling
> > > > > - input_set_poll_interval
> > > > > - input_set_min_poll_interval
> > > > > - input_set_max_poll_interval
> > > > > 
> > > > > These new APIs allow switching an input device into polled mode with sysfs
> > > > > attributes matching drivers using input_polled_dev APIs that will be
> > > > > eventually removed.
> > > > 
> > > > Are you sure that using sysfs is the correct way here?
> > > > I would think using generic properties that can be overwritten by the
> > > > DSDT or by the device tree would make things easier from a driver
> > > > point of view.
> > > 
> > > Couple of points: I wanted it to be compatible with input-polldev.c so
> > > the sysfs attributes must match (so that we can convert existing drivers
> > > and zap input-polldev).
> > 
> > Oh, I missed that. Good point.
> > 
> > > I also am not sure if polling parameters are
> > > property of board, or it is either fundamental hardware limitation or
> > > simply desired system behavior.
> > 
> > I think it's a combination of everything: sometimes the board misses
> > the capability to not do IRQs for that device, and using properties
> > would be better here: you can define them where you need (board,
> > platform or device level), and have a working platfrom from the kernel
> > description entirely.
> > However, it doesn't solve the issue of input-polldev, so maybe
> > properties should be added on top of this sysfs.
> > 
> > > If Rob is OK with adding device
> > > properties I'd be fine adding them as a followup, otherwise we can have
> > > udev adjust the behavior as needed for given box shortly after boot.
> > 
> > Fair enough.
> > 
> > > 
> > > > 
> > > > Also, checkpatch complains about a few octal permissions that are
> > > > preferred over symbolic ones, and there is a possible 'out of memory'
> > > > nessage at drivers/input/input-poller.c:75.
> > > 
> > > Yes, there is. It is there so we would know what device we were trying
> > > to set up when OOM happened. You can probable decipher the driver from
> > > the stack trace, but figuring particular device instance is harder.
> > 
> > Could you add a comment there explaining this choice? I have a feeling
> > you'll have to refuse a few patches of people running coccinelle
> > scripts and be too happy to send a kernel patch.

Done.

> > 
> > Other than that:
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> 
> Hi Dmitry,
> 
> what is the status of this patch? Are we still waiting for Rob to
> comment on the device properties or is this ready to land?

I applied it just now.

> 
> Little bit OT question: what tree/branch do you use to apply patches?
> According to the mailing list you recently applied some patches but
> I can not find them here [1].

Patches that go into current cycle will be in 'for-linus' branch.
Patches that will be merged in the next merge window (like this one)
will end up in 'next' branch.

Thanks.

-- 
Dmitry
