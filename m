From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 03/63] Input: atmel_mxt_ts - only read messages in
 mxt_acquire_irq() when necessary
Date: Wed, 21 Aug 2019 10:54:22 -0700
Message-ID: <20190821175422.GE76194@dtor-ws>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
 <20190816082952.17985-4-jiada_wang@mentor.com>
 <20190816171622.GF121898@dtor-ws>
 <558e1227-7671-0838-d4e0-f234833c0973@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558e1227-7671-0838-d4e0-f234833c0973@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

On Wed, Aug 21, 2019 at 10:26:31PM +0900, Jiada Wang wrote:
> Hi Dmitry
> 
> On 2019/08/17 2:16, Dmitry Torokhov wrote:
> > On Fri, Aug 16, 2019 at 05:28:52PM +0900, Jiada Wang wrote:
> > > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > > 
> > > The workaround of reading all messages until an invalid is received is a
> > > way of forcing the CHG line high, which means that when using
> > > edge-triggered interrupts the interrupt can be acquired.
> > > 
> > > With level-triggered interrupts the workaround is unnecessary.
> > > 
> > > Also, most recent maXTouch chips have a feature called RETRIGEN which, when
> > > enabled, reasserts the interrupt line every cycle if there are messages
> > > waiting. This also makes the workaround unnecessary.
> > > 
> > > Note: the RETRIGEN feature is only in some firmware versions/chips, it's
> > > not valid simply to enable the bit.
> > 
> > Instead of trying to work around of misconfiguration for IRQ/firmware,
> > can we simply error out of probe if we see a level interrupt with
> > !RETRIGEN firmware?
> > 
> I think for old firmwares, which doesn't support RETRIGEN feature, this
> workaround is needed, otherwise we will break all old firmwares, which
> configured with edge-triggered IRQ

Do you know if there are any? I know Chrome OS firmware have RETRIGEN
activated and they are pretty old (original Pixel is from 2013). But if
we indeed have devices with edge interrupt and old not firmware that
does not retrigger, I guess we'll have to keep it... 

Thanks.

-- 
Dmitry
