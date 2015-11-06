From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 0/3] fix y2038 problem in input_event
Date: Fri, 06 Nov 2015 14:11:54 +0100
Message-ID: <4644556.DuUDfrqJ6V@wuerfel>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org> <20151103014304.GA32018@dtor-ws> <CE84BDAA-1EBC-490C-8EFE-200B3B4EC7C0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59964 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932912AbbKFNL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Nov 2015 08:11:58 -0500
In-Reply-To: <CE84BDAA-1EBC-490C-8EFE-200B3B4EC7C0@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y2038@lists.linaro.org
Cc: Pingbo Wen <pingbo.wen@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wednesday 04 November 2015 11:35:20 Pingbo Wen wrote:
> > =E5=9C=A8 2015=E5=B9=B411=E6=9C=883=E6=97=A5=EF=BC=8C09:43=EF=BC=8C=
Dmitry Torokhov <dmitry.torokhov@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Mon, Nov 02, 2015 at 09:35:36PM +0800, WEN Pingbo wrote:
> >> Before this, I have discussed this problem with Arnd. And Arnd hav=
e
> >> an idea that by converting timeval to long / long in input_event, =
so that
> >> input_event structure size will be unchanged, and timeval structur=
e will
> >> removed entirely. But we also need to avoid using CLOCK_REALTIME i=
n
> >> userland, to keep the new input_event structure y2038 safe.
> >>=20
> >> The input_event will only support monotonic time in Arnd's idea. A=
nd
> >> we still need to add wall time support for old 32-bit binary.=20
> >>=20
> >> Those patches try to keep original input capacity, and resolve y20=
38
> >> problem in input_event radically.
> >>=20
> >> struct input_event is only used between kernel and userspace
> >> communication (except uinput). So that we can replace input_event
> >> with input_event64 in kernel entirely, and add a conversion in
> >> input_event_from/to_user() to keep compatible with old 32-bits bin=
ary.
> >>=20
> >> userland can switch to input_event64, which is y2038 safe, via ioc=
tl.
> >=20
> > If we are forcing userspace to change the protocol I'd rather explo=
re
> > whether we need to transmit the timestamp in each and every event. =
I
> > would much rather drop it and instead introduce new event code for
> > timestamp (we already have MSC_TIMESTAMP for hardware-generated
> > timestamps, maybe we can introduce new ones for kernel-generated
> > timestamps).
>=20
> Yes, we can do that by replacing all input_event with input_value in =
kernel,
> and injecting a timestamp event after every normal event (maybe we ca=
n give
> userspace a option here).
>=20
> But we still need do some conversion work in input_event_from/to_user=
 to
> be compatible with old binary. And we need extend value field in
> =E2=80=99struct input_value=E2=80=99 to s64, so the timestamp can be =
passed safely.

Right, that would be equivalent to Pingbo's approach (fixing the y2038
problem by requiring user space changes that are incompatible with
old kernels), but with a nicer interface.

The approach of leaving the event timestamps as 32 bit but requiring
montonic times in contrast would require only user space to change when
it cares about time stamps and doesn't already use montonic times.
Importantly, the modified user space would remain compatible with older
kernels as long as they support monotonic times. Those were introduced
by John Stultz in a80b83b7b8 ("Input: add infrastructure for selecting
clockid for event time stamps") and merged into linux-3.3, and are
generally a good idea because of time jumps.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
