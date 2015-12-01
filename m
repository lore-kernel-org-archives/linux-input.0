From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/6] Input: Update vmmouse.c to use the common VMW_PORT macros
Date: Tue, 1 Dec 2015 14:45:27 -0800
Message-ID: <CAKdAkRTVJ_DWD6uYhp+qd1uYwe3rPguDFAMXpa5=8CwVuO16NQ@mail.gmail.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-1-git-send-email-syeh@vmware.com>
	<1449008332-9394-3-git-send-email-syeh@vmware.com>
	<20151201222414.GH3740@dtor-ws>
	<20151201223255.GA10753@syeh-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34323 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468AbbLAWp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 17:45:28 -0500
In-Reply-To: <20151201223255.GA10753@syeh-linux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: X86 ML <x86@kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-graphics-maintainer@vmware.com" <linux-graphics-maintainer@vmware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Dec 1, 2015 at 2:32 PM, Sinclair Yeh <syeh@vmware.com> wrote:
> Hi,
>
> On Tue, Dec 01, 2015 at 02:24:14PM -0800, Dmitry Torokhov wrote:
>> On Tue, Dec 01, 2015 at 02:18:49PM -0800, Sinclair Yeh wrote:
>> > v2:
>> > Instead of replacing existing VMMOUSE defines, only modify enough
>> > to use the new VMW_PORT define.
>> >
>> > v3:
>> > Use updated VMWARE_PORT() which requires hypervisor magic as an added
>> > parameter
>> >
>> > Signed-off-by: Sinclair Yeh <syeh@vmware.com>
>> > Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
>> > Reviewed-by: Alok N Kataria <akataria@vmware.com>
>> > Cc: pv-drivers@vmware.com
>> > Cc: linux-graphics-maintainer@vmware.com
>> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: virtualization@lists.linux-foundation.org
>> > Cc: linux-input@vger.kernel.org
>> > ---
>> >  drivers/input/mouse/vmmouse.c | 22 +++++++---------------
>> >  1 file changed, 7 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
>> > index e272f06..d34e3e4 100644
>> > --- a/drivers/input/mouse/vmmouse.c
>> > +++ b/drivers/input/mouse/vmmouse.c
>> > @@ -19,6 +19,7 @@
>> >  #include <linux/slab.h>
>> >  #include <linux/module.h>
>> >  #include <asm/hypervisor.h>
>> > +#include <asm/vmware.h>
>> >
>> >  #include "psmouse.h"
>> >  #include "vmmouse.h"
>> > @@ -84,21 +85,12 @@ struct vmmouse_data {
>> >   * implementing the vmmouse protocol. Should never execute on
>> >   * bare metal hardware.
>> >   */
>> > -#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)      \
>> > -({                                                 \
>> > -   unsigned long __dummy1, __dummy2;               \
>> > -   __asm__ __volatile__ ("inl %%dx" :              \
>> > -           "=a"(out1),                             \
>> > -           "=b"(out2),                             \
>> > -           "=c"(out3),                             \
>> > -           "=d"(out4),                             \
>> > -           "=S"(__dummy1),                         \
>> > -           "=D"(__dummy2) :                        \
>> > -           "a"(VMMOUSE_PROTO_MAGIC),               \
>> > -           "b"(in1),                               \
>> > -           "c"(VMMOUSE_PROTO_CMD_##cmd),           \
>> > -           "d"(VMMOUSE_PROTO_PORT) :               \
>> > -           "memory");                              \
>> > +#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)                 \
>> > +({                                                            \
>> > +   unsigned long __dummy1 = 0, __dummy2 = 0;                  \
>>
>> Why do we need to initialize dummies?
>
> Because for some commands those parameters to VMW_PORT() can be both
> input and outout.

The vmmouse commands do not use them as input though, so it seems we
are simply wasting CPU cycles setting them to 0 just because we are
using the new VMW_PORT here. Why do we need to switch? What is the
benefit of doing this?

Thanks.

-- 
Dmitry
