From: anish singh <anish198519851985@gmail.com>
Subject: Re: [PATCH] Input: twl4030 power button: don't lose presses on resume
Date: Thu, 26 Apr 2012 08:36:12 +0530
Message-ID: <CAK7N6voY+8NkB_T0V82M22CMx5Zz693u_t=U3nvKdtma4eY+Pg@mail.gmail.com>
References: <20120425122139.512c6890@notabene.brown>
	<20120425050919.GB27843@core.coreip.homeip.net>
	<20120425152603.3d24547f@notabene.brown>
	<1335372965.1571.15.camel@anish-Inspiron-N5050>
	<20120426065803.59b96cb3@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60255 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2DZDGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 23:06:13 -0400
In-Reply-To: <20120426065803.59b96cb3@notabene.brown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 26, 2012 at 2:28 AM, NeilBrown <neilb@suse.de> wrote:
> On Wed, 25 Apr 2012 22:26:05 +0530 anish kumar <anish198519851985@gma=
il.com>
> wrote:
>
>> On Wed, 2012-04-25 at 15:26 +1000, NeilBrown wrote:
>> > On Tue, 24 Apr 2012 22:09:19 -0700 Dmitry Torokhov
>> > <dmitry.torokhov@gmail.com> wrote:
>> >
>> > > Hi Neil,
>> > >
>> > > On Wed, Apr 25, 2012 at 12:21:39PM +1000, NeilBrown wrote:
>> > > >
>> > > > If we press and release the power button before the press inte=
rrupt is
>> > > > handled - as can happen on resume - we lose the press event so=
 the
>> > > > release event is ignored and we don't know what happened to ca=
use the
>> > > > wakeup.
>> I didn't understand this.If power button is waking up the device the=
n
>> obviously power button interrupt handler is called right?If yes then=
 how
>> can we lose the press event?Is user space not ready to take the even=
t?
>> May be I didn't understand it properly.Can you kindly explain?
>
> Yes, the interrupt handler is running.
>
> However the way the driver is currently written, an interrupt is not =
enough
> to generate an "button press" event.
> What happens is when the kernel-thread half of the interrupt handler =
finally
> runs, it samples the state of the button and generates an event based=
 on that
> level. =C2=A0So if the button has been released again by the time the=
 ISR runs,
> then only a "button release" event is generated.
>
> When this gets to the input layer, the input later *knows* that the b=
utton is
> currently released so it suppresses the new "button release" event.
> A "sync" event does still get through to the App, but they can come a=
t all
> sorts of time even when nothing is happening to the button, so they a=
re best
> ignored (when by themselves).
>
> What the driver needs to do is acknowledge that just getting an inter=
rupt
> means =C2=A0that something changed, and to ensure that a change gets =
passed up to
> the input layer.
>
> Is that clearer?
Perfect explanation.Thanks a ton.
>
> Thanks,
> NeilBrown
>
>
>> > >
>> > > What kind of latency do you observe?
>> >
>> > When I have debugging enabled, hundreds of milliseconds.
>> >
>> > When I don't have debugging enabled ... it doesn't tell me, but I'=
m fairly
>> > sure it is several tens of milliseconds and the button press can b=
e quicker
>> > than that.
>> >
>> > If it will help I can try to instrument the driver and get some ti=
mings.
>> >
>> > >
>> > > >
>> > > > So make sure that each interrupt handled does generate an even=
t.
>> > > > Because twl4030 queues interrupt events we will see two interr=
upts
>> > > > for a press-release even if we handle the first one later. =C2=
=A0This means
>> > > > that such a sequence will be reported as two button presses. =C2=
=A0This
>> > > > is unfortunate but is better than no button presses.
>> > > > Possibly we could set the PENDDIS_MASK to disable queuing of
>> > > > interrupts, but that might adversely affect other interrupt so=
urces.
>> > > >
>> > >
>> > > It looks like we'd have to modify every driver to ensure consist=
ent
>> > > behavior as we do not have any guarantees on how long resume tak=
es.
>> > > Maybe this is something that input core needs to implement?
>> >
>> > Well if every driver is buggy....
>> >
>> > I don't see how this could be implemented in the input core. =C2=A0=
And even if it
>> > was, you'd probably need to change each driver to interact with th=
is new
>> > functionality which would be much the same work as changing them t=
o work with
>> > the current functionality....
>> > But maybe I have no imagination - if you can suggest a way that th=
e input core
>> > could support this without changing the drivers, I'm happy to try =
it out.
>> >
>> > Thanks,
>> > NeilBrown
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
