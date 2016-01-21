From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] usbhid: replace inappropriate ENOSYS with ENODEV
Date: Thu, 21 Jan 2016 09:42:30 -0800
Message-ID: <CAKdAkRT7imctXF_p0nyvpO8ikriBm3dkq7h1YqS+4x2ZWujcVg@mail.gmail.com>
References: <56A0028C.9080308@gmail.com>
	<alpine.LNX.2.00.1601211516510.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36376 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965648AbcAURmb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 12:42:31 -0500
Received: by mail-oi0-f53.google.com with SMTP id o124so30985791oia.3
        for <linux-input@vger.kernel.org>; Thu, 21 Jan 2016 09:42:31 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1601211516510.21446@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 21, 2016 at 6:18 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 20 Jan 2016, Heiner Kallweit wrote:
>
>> Primary meaning of ENOSYS is "system call not available" but it's also used
>> with meaning "function not implemented". Both are not applicable here.
>>
>> Typically this error occurs when the device was unplugged.
>> usbhid_raw_request returns -ENODEV in such a case what seems to be more
>> reasonable. Therefore use -ENODEV also here.
>>
>> Primary motivation for this change is a change in the LED subsystem to
>> ignore -ENODEV if the device was most likely unplugged.
>
> I believe POSIX defines ENOSYS as "Function not implemented". In this
> case, we are signalling there is no "URB OUT" function.
>

Well, it looks like ENOSYS is really reserved for unimplemented system calls:

commit 91c9afaf97ee554d2cd3042a5ad01ad21c99e8c4
Author: Andy Lutomirski <luto@amacapital.net>
Date:   Thu Apr 16 12:44:44 2015 -0700

    checkpatch.pl: new instances of ENOSYS are errors

    ENOSYS means that a nonexistent system call was called.  We have a
    bad habit of using it for things like invalid operations on
    otherwise valid syscalls.  We should avoid this in new code.

    Pervasive incorrect usage of ENOSYS came up at the kernel summit ABI
    review discussion.  Let's see if checkpatch can help.

    I'll submit a separate patch for include/uapi/asm-generic/errno.h.

    Signed-off-by: Andy Lutomirski <luto@amacapital.net>
    Cc: Pavel Machek <pavel@ucw.cz>
    Cc: Michael Kerrisk <mtk.manpages@gmail.com>
    Cc: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

> I don't have strong preference either way, but ENODEV doesn't seem to be
> particularly good fit for this purpose either.

If there is no urbout during normal operation then -EINVAL I think is
applicable - upper layers are trying to send request to the device
that can not be executed, i.e. invalid request. If it happens during
removal then it is either a) there is a race or b) we are not actually
racing with whomever is resetting urbout to NULL but we need to check
if device is actually gone and return -ENXIO in this case.

Thanks.

-- 
Dmitry
