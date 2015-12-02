From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [Linux-graphics-maintainer] [PATCH 3/6] Input: Update vmmouse.c
 to use the common VMW_PORT macros
Date: Wed, 2 Dec 2015 08:07:04 +0100
Message-ID: <565E9898.3020204@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
 <1449008332-9394-1-git-send-email-syeh@vmware.com>
 <1449008332-9394-3-git-send-email-syeh@vmware.com>
 <20151201222414.GH3740@dtor-ws> <20151201223255.GA10753@syeh-linux>
 <CAKdAkRTVJ_DWD6uYhp+qd1uYwe3rPguDFAMXpa5=8CwVuO16NQ@mail.gmail.com>
 <20151201225420.GA11210@syeh-linux> <20151202000408.GB5363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:40425 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846AbbLBHHK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 02:07:10 -0500
In-Reply-To: <20151202000408.GB5363@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sinclair Yeh <syeh@vmware.com>
Cc: X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 12/02/2015 01:04 AM, Greg Kroah-Hartman wrote:
> On Tue, Dec 01, 2015 at 02:54:20PM -0800, Sinclair Yeh wrote:
>> Hi,
>>
>> On Tue, Dec 01, 2015 at 02:45:27PM -0800, Dmitry Torokhov wrote:
>>> On Tue, Dec 1, 2015 at 2:32 PM, Sinclair Yeh <syeh@vmware.com> wrote:
>>>> Hi,
>>>>
>> <snip>
>>
>>>>>>   */
>>>>>> -#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)      \
>>>>>> -({                                                 \
>>>>>> -   unsigned long __dummy1, __dummy2;               \
>>>>>> -   __asm__ __volatile__ ("inl %%dx" :              \
>>>>>> -           "=a"(out1),                             \
>>>>>> -           "=b"(out2),                             \
>>>>>> -           "=c"(out3),                             \
>>>>>> -           "=d"(out4),                             \
>>>>>> -           "=S"(__dummy1),                         \
>>>>>> -           "=D"(__dummy2) :                        \
>>>>>> -           "a"(VMMOUSE_PROTO_MAGIC),               \
>>>>>> -           "b"(in1),                               \
>>>>>> -           "c"(VMMOUSE_PROTO_CMD_##cmd),           \
>>>>>> -           "d"(VMMOUSE_PROTO_PORT) :               \
>>>>>> -           "memory");                              \
>>>>>> +#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)                 \
>>>>>> +({                                                            \
>>>>>> +   unsigned long __dummy1 = 0, __dummy2 = 0;                  \
>>>>> Why do we need to initialize dummies?
>>>> Because for some commands those parameters to VMW_PORT() can be both
>>>> input and outout.
>>> The vmmouse commands do not use them as input though, so it seems we
>>> are simply wasting CPU cycles setting them to 0 just because we are
>>> using the new VMW_PORT here. Why do we need to switch? What is the
>>> benefit of doing this?
>> There are two reasons.  One is to make the code more readable and
>> maintainable.  Rather than having mostly similar inline assembly
>> code sprinkled across multiple modules, we can just use the macros
>> and document that.
> But the macro is only used here, and the variables aren't used at all,
> so it makes no sense in this file.
>

IMO, this makes a lot of sense because we now get a single definition of
VMW_PORT in the platform code that a developer can refer to to
understand things like 32-64 bit compatibilty, and usage conditions and
it also forces the developer to adopt the good practice of clearing
currently unused input variables rather than to leave them undefined. In
addition, if something needs to be changed we have one single place to
change rather than a lot of places scattered all over various kernel
modules.

Things that we (I) previously, for example, didn't get quite right in
the vmmouse module despite spending a considerable amount of time on the
subject.

Thanks,
Thomas


 


