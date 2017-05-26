From: Rob Landley <rob@landley.net>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting kernel
Date: Fri, 26 May 2017 01:24:48 -0500
Message-ID: <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526072437.46499fbd@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, sachinp <sachinp@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On 05/25/2017 04:24 PM, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Thu, 25 May 2017 23:02:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> It'll be:
>>
>> ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")
>
> And Andrew has asked me to drop that patch from linux-next which will
> happen today.

What approach do the kernel developers suggest I take here?

I would have thought letting it soak in linux-next for a release so
people could fix userspace bugs would be the next step, but this sounds
like that's not an option?

Is the behavior the patch implements wrong?

Rob
