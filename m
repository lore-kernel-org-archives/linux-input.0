From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [PATCH 0/3] fix y2038 problem in input_event
Date: Wed, 4 Nov 2015 11:35:20 +0800
Message-ID: <CE84BDAA-1EBC-490C-8EFE-200B3B4EC7C0@linaro.org>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org> <20151103014304.GA32018@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36846 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbKDDf0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 22:35:26 -0500
Received: by pacdm15 with SMTP id dm15so14208884pac.3
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2015 19:35:26 -0800 (PST)
In-Reply-To: <20151103014304.GA32018@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pingbo Wen <pingbo.wen@linaro.org>, linux-input@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de


> =D4=DA 2015=C4=EA11=D4=C23=C8=D5=A3=AC09:43=A3=ACDmitry Torokhov <dmi=
try.torokhov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Mon, Nov 02, 2015 at 09:35:36PM +0800, WEN Pingbo wrote:
>> Before this, I have discussed this problem with Arnd. And Arnd have
>> an idea that by converting timeval to long / long in input_event, so=
 that
>> input_event structure size will be unchanged, and timeval structure =
will
>> removed entirely. But we also need to avoid using CLOCK_REALTIME in
>> userland, to keep the new input_event structure y2038 safe.
>>=20
>> The input_event will only support monotonic time in Arnd's idea. And
>> we still need to add wall time support for old 32-bit binary.=20
>>=20
>> Those patches try to keep original input capacity, and resolve y2038
>> problem in input_event radically.
>>=20
>> struct input_event is only used between kernel and userspace
>> communication (except uinput). So that we can replace input_event
>> with input_event64 in kernel entirely, and add a conversion in
>> input_event_from/to_user() to keep compatible with old 32-bits binar=
y.
>>=20
>> userland can switch to input_event64, which is y2038 safe, via ioctl=
=2E
>=20
> If we are forcing userspace to change the protocol I'd rather explore
> whether we need to transmit the timestamp in each and every event. I
> would much rather drop it and instead introduce new event code for
> timestamp (we already have MSC_TIMESTAMP for hardware-generated
> timestamps, maybe we can introduce new ones for kernel-generated
> timestamps).

Yes, we can do that by replacing all input_event with input_value in ke=
rnel,
and injecting a timestamp event after every normal event (maybe we can =
give
userspace a option here).

But we still need do some conversion work in input_event_from/to_user t=
o
be compatible with old binary. And we need extend value field in
=A1=AFstruct input_value=A1=AF to s64, so the timestamp can be passed s=
afely.

Pingbo--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
