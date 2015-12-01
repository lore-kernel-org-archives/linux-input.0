From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT macros
Date: Tue, 1 Dec 2015 15:56:39 -0800
Message-ID: <CAKdAkRThOqXpVPYbSTE305_6=sOK8Kfbxfof_ybvJxvm4ge9Kg@mail.gmail.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-3-git-send-email-syeh@vmware.com>
	<20151201222414.GH3740@dtor-ws>
	<20151201223255.GA10753@syeh-linux>
	<CAKdAkRTVJ_DWD6uYhp+qd1uYwe3rPguDFAMXpa5=8CwVuO16NQ@mail.gmail.com>
	<20151201225420.GA11210@syeh-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35417 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbbLAX4k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 18:56:40 -0500
In-Reply-To: <20151201225420.GA11210@syeh-linux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: X86 ML <x86@kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Dec 1, 2015 at 2:54 PM, Sinclair Yeh <syeh@vmware.com> wrote:
> Hi,
>
> On Tue, Dec 01, 2015 at 02:45:27PM -0800, Dmitry Torokhov wrote:
>> On Tue, Dec 1, 2015 at 2:32 PM, Sinclair Yeh <syeh@vmware.com> wrote:
>> > Hi,
>> >
>
> <snip>
>
>> >> >   */
>> >> > -#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)      \
>> >> > -({                                                 \
>> >> > -   unsigned long __dummy1, __dummy2;               \
>> >> > -   __asm__ __volatile__ ("inl %%dx" :              \
>> >> > -           "=a"(out1),                             \
>> >> > -           "=b"(out2),                             \
>> >> > -           "=c"(out3),                             \
>> >> > -           "=d"(out4),                             \
>> >> > -           "=S"(__dummy1),                         \
>> >> > -           "=D"(__dummy2) :                        \
>> >> > -           "a"(VMMOUSE_PROTO_MAGIC),               \
>> >> > -           "b"(in1),                               \
>> >> > -           "c"(VMMOUSE_PROTO_CMD_##cmd),           \
>> >> > -           "d"(VMMOUSE_PROTO_PORT) :               \
>> >> > -           "memory");                              \
>> >> > +#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)                 \
>> >> > +({                                                            \
>> >> > +   unsigned long __dummy1 = 0, __dummy2 = 0;                  \
>> >>
>> >> Why do we need to initialize dummies?
>> >
>> > Because for some commands those parameters to VMW_PORT() can be both
>> > input and outout.
>>
>> The vmmouse commands do not use them as input though, so it seems we
>> are simply wasting CPU cycles setting them to 0 just because we are
>> using the new VMW_PORT here. Why do we need to switch? What is the
>> benefit of doing this?
>
> There are two reasons.  One is to make the code more readable and
> maintainable.  Rather than having mostly similar inline assembly
> code sprinkled across multiple modules, we can just use the macros
> and document that.

At the cost of wasting cycles though :(.

Oh well, it is not like we are polling the backdoor here, so if you do
not care about a few wasted cycles I don't have to either ;)

>
> The second reason is this organization makes some on-going future
> development easier.
>
> Hope this helps.
>
> Sinclair

-- 
Dmitry
