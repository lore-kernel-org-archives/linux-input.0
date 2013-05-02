From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 02 May 2013 13:49:59 -0700
Message-ID: <1712127.2Y7J819muB@dtor-d630.eng.vmware.com>
References: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com> <20130502201807.GE28625@core.coreip.homeip.net> <CAFmpkyg9WHn4Kt5mYUUmvR8HXZ+1=smcfqc0UHXArqaDTxVKoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:45982 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761949Ab3EBUuE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 16:50:04 -0400
Received: by mail-da0-f53.google.com with SMTP id o9so480508dan.12
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 13:50:02 -0700 (PDT)
In-Reply-To: <CAFmpkyg9WHn4Kt5mYUUmvR8HXZ+1=smcfqc0UHXArqaDTxVKoA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thursday, May 02, 2013 04:30:01 PM Todd Showalter wrote:
> On Thu, May 2, 2013 at 4:18 PM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > No, I do not think so. Kernel provides a level of abstraction, but so
> > does X, ALSA, given desktop environment and so forth. If a task does not
> > require hardware access (and translating input events form one type to
> > another does not) one should think really hard whether it should be
> > done in kernel.
> 
>     What's the scope of acceptable changes in-kernel?  I'd like to fix
> as much of this as possible in the kernel; if the rest has to happen
> in a library, so be it.
> 
>     Would you be open to considering some sort of ioctl() that exports
> a mapping table?  The PS3 controller mappings are completely wonky,
> and even the xbox and xbox 360 controllers are less than ideal.  If we
> could pull a mapping table out of the dev node at least it would let
> us fix the common cases.

What information does kernel have in this case than userspace does not? Having 
a static table compiled in kernel and available via ioctl and having the same 
data in a file on disk is no different, with the exception that data on disk 
does not take kernel memory and user can much more easily "play" with it.

I am pretty sure it should be also much more easy to have a distribution pick 
up a new mapping than to convince them to take a kernel patch.

Thanks.

-- 
Dmitry
