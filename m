From: Thomas Poussevin <thomas.poussevin@parrot.com>
Subject: Re: Input sync flag when registering.
Date: Wed, 27 Aug 2014 11:12:43 +0200
Message-ID: <53FDA10B.8010601@parrot.com>
References: <53FAF963.9020403@parrot.com> <20140825181906.GA35881@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:60217 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaH0JMq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 05:12:46 -0400
In-Reply-To: <20140825181906.GA35881@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Le 25/08/2014 20:19, Dmitry Torokhov a =E9crit :
> Hi Thomas,
>
> On Mon, Aug 25, 2014 at 10:52:51AM +0200, Thomas Poussevin wrote:
>> Hi,
>> I noticed that with touchscreen drivers that don't explicitly call a
>> input_sync after input_register_device, suspend to ram is blocked if
>> no event is sent, because the input_dev created is considered as not
>> synchronized. The problem was seen with Atmel mxt driver. When any
>> event is sent, the driver explicitly ask a sync, so the problem is
>> solved.
>> The problem occurs only when the screen has never send any event
>> before suspend to ram.
>> I solved it setting the sync element to true (when input dev is
>> created, no element is pending).
>> Is there a better way to solve the problem ?
> It is not clear to me what the problem is. The kernel as far as I
> remember never checked state of 'sync' field when executing suspend
> callbacks. Moreover there is no longer 'sync' field at all in mainlin=
e.
>
> It sounds like some userspace code makes assumptions that are not alw=
ays
> valid.
>
> Thanks.
>

Indeed, there is no longer 'sync' field in mainline. I realized i misse=
d=20
some commits, specifically  "Input: Send events one packet at a time" o=
ne.

Before theses commits, there used to be this problem, that is not=20
relevant anymore :
It happened when Atmel mxt driver goes to suspend. mxt_stop func send a=
=20
"input_sync" to mxt input device.
A input_sync has never been send before in input events.
The input_sync consists in : input_event(dev, EV_SYN, SYN_REPORT, 0);
In input_handle_event, if (!dev->sync) , then dev->sync =3D true;=20
disposition =3D INPUT_PASS_TO_HANDLERS; . So finally there is a call to=
=20
input_pass_event(dev, type, code, value);
But the input device created by mxt driver is allready suspending.
Suspend is canceled.

So i have 2 solutions (other than kernel update): either, in mxt driver=
,=20
sending a input_sync after creating input device in order than the=20
suspend sync call is not the first one (dev->sync will be true next=20
time). Either, in the input driver, the default value of sync field is=20
true (coherent with a just created device). I choosed this one.

Thanks.
Thomas.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
