From: Tracey Dent <tdent48227@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hid: Makefile: Cleaned up Makefile
Date: Wed, 17 Nov 2010 13:18:46 -0500
Message-ID: <AANLkTinCKEYvOj0CB=BpyezYnX41UchwqVLBy4LBSSG2@mail.gmail.com>
References: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
	<alpine.LNX.2.00.1011151557510.7420@pobox.suse.cz>
	<AANLkTikKTLpzafaE9oxRz1f_ZE9zv1eL6K8aAkYmR+TB@mail.gmail.com>
	<20101117072117.GC7046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62250 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933148Ab0KQSSs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 13:18:48 -0500
In-Reply-To: <20101117072117.GC7046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, spbnick@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/17/10, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 16, 2010 at 10:28:19PM -0500, Tracey Dent wrote:
>> On 11/15/10, Jiri Kosina <jkosina@suse.cz> wrote:
>> > On Sun, 7 Nov 2010, Tracey Dent wrote:
>> >
>> >> Changed Makefile to use <modules>-y instead of <modules>-objs because
>> >> -objs is deprecated and should now be switched. According to
>> >> (documentation/kbuild/makefiles.txt).
>> >
>> > Actually, where exactly does this file document it?
>> >
>>
>> It documents how it should be done in the section entitled --- 3.7
>> Compilation flags (which starts on line 284).
>>
>
> Actually the only reference I could find is in 3.3:
>
>         If a kernel module is built from several source files, you specify
>         that you want to build a module in the same way as above; however,
>         kbuild needs to know which object files you want to build your
>         module from, so you have to tell it by setting a $(<module_name>-y)
>         variable.
>
> See commit 4f8272802739f5c6ce6b0a548810a181d2f1b652 for reasoning behind
> the change.
>

You're right, I was thinking I changed to use ccflags-y flags. Sorry :(

> Thanks.
>
> --
> Dmitry
>

Thanks

Tracey Dent
