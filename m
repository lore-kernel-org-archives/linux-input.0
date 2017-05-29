From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module verification failed: signature and/or required key missing - tainting kernel
Date: Mon, 29 May 2017 15:06:58 +1000
Message-ID: <87r2z86ykt.fsf@concordia.ellerman.id.au>
References: <1495700957.9020.43.camel@abdul.in.ibm.com> <8760gp9jjl.fsf@concordia.ellerman.id.au> <20170526072437.46499fbd@canb.auug.org.au> <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdE2FHA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 01:07:00 -0400
In-Reply-To: <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Landley <rob@landley.net>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, sachinp <sachinp@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

Rob Landley <rob@landley.net> writes:

> On 05/25/2017 04:24 PM, Stephen Rothwell wrote:
>> Hi Michael,
>> 
>> On Thu, 25 May 2017 23:02:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>
>>> It'll be:
>>>
>>> ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")
>>
>> And Andrew has asked me to drop that patch from linux-next which will
>> happen today.
>
> What approach do the kernel developers suggest I take here?

Well I'm just *a* kernel developer, but rule #1 is don't break userspace.

> I would have thought letting it soak in linux-next for a release so
> people could fix userspace bugs would be the next step, but this sounds
> like that's not an option?

You say they're userspace bugs, userspace will say it's a bug that the
kernel has changed its behaviour.

> Is the behavior the patch implements wrong?

Yes, because it breaks existing setups for no particularly good reason.

If CONFIG_DEVTMPFS_MOUNT had always meant devtmpfs was mounted in the
initramfs then that would have been fine.

But because it didn't, there are now systems out there that depend on
the existing behaviour, and changing it is therefore wrong IMHO.

As I said in another mail you can avoid breaking existing setups by
adding a new config option to control mounting devtmpfs in the
initramfs. It's a pity to need yet another config option, but such is
life.

cheers
