From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT
 macros
Date: Wed, 2 Dec 2015 10:58:48 -0800
Message-ID: <20151202185848.GC15531@dtor-ws>
References: <1449008332-9394-3-git-send-email-syeh@vmware.com>
 <20151201222414.GH3740@dtor-ws>
 <20151201223255.GA10753@syeh-linux>
 <CAKdAkRTVJ_DWD6uYhp+qd1uYwe3rPguDFAMXpa5=8CwVuO16NQ@mail.gmail.com>
 <20151201225420.GA11210@syeh-linux>
 <20151202000408.GB5363@kroah.com>
 <20151202022106.GA6471@syeh-linux>
 <20151202153124.GC29557@kroah.com>
 <20151202172634.GA15531@dtor-ws>
 <20151202184528.GA23182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33611 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbbLBS6x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 13:58:53 -0500
Content-Disposition: inline
In-Reply-To: <20151202184528.GA23182@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sinclair Yeh <syeh@vmware.com>, X86 ML <x86@kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Dec 02, 2015 at 10:45:28AM -0800, Greg Kroah-Hartman wrote:
> On Wed, Dec 02, 2015 at 09:26:34AM -0800, Dmitry Torokhov wrote:
> > On Wed, Dec 02, 2015 at 07:31:24AM -0800, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 01, 2015 at 06:21:06PM -0800, Sinclair Yeh wrote:
> > > > On Tue, Dec 01, 2015 at 04:04:08PM -0800, Greg Kroah-Hartman wrote:
> > > > > On Tue, Dec 01, 2015 at 02:54:20PM -0800, Sinclair Yeh wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Tue, Dec 01, 2015 at 02:45:27PM -0800, Dmitry Torokhov wrote:
> > > > > > > On Tue, Dec 1, 2015 at 2:32 PM, Sinclair Yeh <syeh@vmware.com> wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > 
> > > > > > <snip>
> > > > > > 
> > > > > > > >> >   */
> > > > > > > >> > -#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)      \
> > > > > > > >> > -({                                                 \
> > > > > > > >> > -   unsigned long __dummy1, __dummy2;               \
> > > > > > > >> > -   __asm__ __volatile__ ("inl %%dx" :              \
> > > > > > > >> > -           "=a"(out1),                             \
> > > > > > > >> > -           "=b"(out2),                             \
> > > > > > > >> > -           "=c"(out3),                             \
> > > > > > > >> > -           "=d"(out4),                             \
> > > > > > > >> > -           "=S"(__dummy1),                         \
> > > > > > > >> > -           "=D"(__dummy2) :                        \
> > > > > > > >> > -           "a"(VMMOUSE_PROTO_MAGIC),               \
> > > > > > > >> > -           "b"(in1),                               \
> > > > > > > >> > -           "c"(VMMOUSE_PROTO_CMD_##cmd),           \
> > > > > > > >> > -           "d"(VMMOUSE_PROTO_PORT) :               \
> > > > > > > >> > -           "memory");                              \
> > > > > > > >> > +#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)                 \
> > > > > > > >> > +({                                                            \
> > > > > > > >> > +   unsigned long __dummy1 = 0, __dummy2 = 0;                  \
> > > > > > > >>
> > > > > > > >> Why do we need to initialize dummies?
> > > > > > > >
> > > > > > > > Because for some commands those parameters to VMW_PORT() can be both
> > > > > > > > input and outout.
> > > > > > > 
> > > > > > > The vmmouse commands do not use them as input though, so it seems we
> > > > > > > are simply wasting CPU cycles setting them to 0 just because we are
> > > > > > > using the new VMW_PORT here. Why do we need to switch? What is the
> > > > > > > benefit of doing this?
> > > > > > 
> > > > > > There are two reasons.  One is to make the code more readable and
> > > > > > maintainable.  Rather than having mostly similar inline assembly
> > > > > > code sprinkled across multiple modules, we can just use the macros
> > > > > > and document that.
> > > > > 
> > > > > But the macro is only used here, and the variables aren't used at all,
> > > > > so it makes no sense in this file.
> > > > 
> > > > Maybe it's because I didn't CC you on the rest of the series.  I wasn't
> > > > sure what the proper distribution list is for each part.
> > > 
> > > Use scripts/get_maintainer.pl, that's what it is there for.  A number of
> > > those patches should go through me, if not all of them, if you want them
> > > merged...
> > > 
> > > > 
> > > > This new macro is also used in arch/x86/kernel/cpu/vmware.c and
> > > > vmw_balloon.c
> > > 
> > > And it's used inconsistantly in those patches (you don't set the dummy
> > > variables to 0 in all of them...)  Now maybe that's just how the asm
> > > functions work, but it's not very obvious as to why this is at all.
> > > 
> > > > > > The second reason is this organization makes some on-going future
> > > > > > development easier.
> > > > > 
> > > > > We don't plan for "future" development other than a single patch series,
> > > > > as we have no idea what that development is, nor if it will really
> > > > > happen.  You can always change this file later if you need to, nothing
> > > > > is keeping that from happening.
> > > > 
> > > > So the intent of this series is to centralize similar lines of inline
> > > > assembly code that are currently used by 3 different kernel modules
> > > > to a central place.  The new vmware.h [patch 0/6] becomes the one header
> > > > to include for common guest-host communication needs.
> > > 
> > > Why can't it go into vmw_vmci_defs.h instead, or your other .h file, why
> > > create yet-another-.h-file for your bus?  You already have 2, this would
> > > make it 3, which seems like a lot...
> > 
> > Umm, you are not saying that vmmouse should include vmci header file(s),
> > are you? Because the 2 are unrelated and vmci does not use the
> > hypervisor port to communicate with host IIRC.
> 
> vmmouse should include some type of "vmware bus" .h file, if it's not
> the vmw_* files, what are they for?

I see:
dtor@dtor-ws:~/kernel/work$ ls include/linux/vmw*
include/linux/vmw_vmci_api.h  include/linux/vmw_vmci_defs.h

so they are for VMCI.

>  My point being, I didn't see the
> need to add another .h file when we should probably already have one for
> this bus, right?

You keep saying "bus" and I am confused. There is not really a bus there
as (unfortunately) VMware did not come with a unified interface for
host/guest communication, but rather let each group come up with their
own way of doing things. So we have vmmouse and, as I was reminded,
userspace agent using one virtual IO port to communicate, vmballoon is
using another IO port, pvscsi, vmxnet3 and vmci are virtual PCI devices
and Thomas can tell more about vmwgfx as I never looked at it closely.

So if we want to consolidate the hypervisor port accessors (which I am
not entirely convinced is worthwhile as the set of arguments/returned
values/registers used depends on command sent through the port and these
unified macros now require unneeded initializations of dummy variables)
then we indeed need a new header.

Thanks.

-- 
Dmitry
