From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] usbhid: replace inappropriate ENOSYS with ENODEV
Date: Fri, 22 Jan 2016 15:35:03 -0800
Message-ID: <CALCETrWGGah8vgMoP+uOO=u0yhJ=sFOiUVNtoUOwrZ4JV19onQ@mail.gmail.com>
References: <56A0028C.9080308@gmail.com> <alpine.LNX.2.00.1601211516510.21446@cbobk.fhfr.pm>
 <CAKdAkRT7imctXF_p0nyvpO8ikriBm3dkq7h1YqS+4x2ZWujcVg@mail.gmail.com> <alpine.LNX.2.00.1601230028090.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34301 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbcAVXfY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 18:35:24 -0500
Received: by mail-oi0-f47.google.com with SMTP id k206so57916590oia.1
        for <linux-input@vger.kernel.org>; Fri, 22 Jan 2016 15:35:23 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1601230028090.21446@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Jan 22, 2016 at 3:30 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 21 Jan 2016, Dmitry Torokhov wrote:
>
>> On Thu, Jan 21, 2016 at 6:18 AM, Jiri Kosina <jikos@kernel.org> wrote:
>> > On Wed, 20 Jan 2016, Heiner Kallweit wrote:
>> >
>> >> Primary meaning of ENOSYS is "system call not available" but it's also used
>> >> with meaning "function not implemented". Both are not applicable here.
>> >>
>> >> Typically this error occurs when the device was unplugged.
>> >> usbhid_raw_request returns -ENODEV in such a case what seems to be more
>> >> reasonable. Therefore use -ENODEV also here.
>> >>
>> >> Primary motivation for this change is a change in the LED subsystem to
>> >> ignore -ENODEV if the device was most likely unplugged.
>> >
>> > I believe POSIX defines ENOSYS as "Function not implemented". In this
>> > case, we are signalling there is no "URB OUT" function.
>> >
>>
>> Well, it looks like ENOSYS is really reserved for unimplemented system calls:
>>
>> commit 91c9afaf97ee554d2cd3042a5ad01ad21c99e8c4
>> Author: Andy Lutomirski <luto@amacapital.net>
>> Date:   Thu Apr 16 12:44:44 2015 -0700
>>
>>     checkpatch.pl: new instances of ENOSYS are errors
>>
>>     ENOSYS means that a nonexistent system call was called.  We have a
>>     bad habit of using it for things like invalid operations on
>>     otherwise valid syscalls.  We should avoid this in new code.
>>
>>     Pervasive incorrect usage of ENOSYS came up at the kernel summit ABI
>>     review discussion.  Let's see if checkpatch can help.
>>
>>     I'll submit a separate patch for include/uapi/asm-generic/errno.h.
>
> Let's add Andy to CC.
>
> Andy, my understanding of POSIX is that ENOSYS is "function not
> implemented", meaning whatever internal function of kernel, not strictly
> just syscall entrypoint.
>
> Where does your explanation of ENOSYS as "syscall not implemented" come
> from, please?
>

Userspace likes to be able to tell whether a given syscall is
implemented by the running kernel.  Unimplemented syscalls return
-ENOSYS, and having syscalls that *are* implemented return -ENOSYS can
confuse things.

--Andy
