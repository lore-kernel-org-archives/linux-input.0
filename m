From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module verification failed: signature and/or required key missing - tainting kernel
Date: Thu, 25 May 2017 23:02:06 +1000
Message-ID: <8760gp9jjl.fsf@concordia.ellerman.id.au>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:39237 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765915AbdEYNCJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 09:02:09 -0400
In-Reply-To: <1495700957.9020.43.camel@abdul.in.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> Test : boot
> Machine : Power 8 PowerVM LPAR
> Kernel version : 4.12.0-rc2-next-20170524
> Toolchain : gcc version 5.2.1
> Config : attached
>
> next-20170517 was last good version where we did not see the failure.
> from next-20170519 to today's next-20170524, we see the problem
> everyday.
>
> Kernels fails to boot on PowerVM LPAR with these errors;
>
> Freeing unused kernel memory: 4416K
> This architecture does not have kernel memory protection.
> Loading, please wait...
> mount: mounting udev on /dev failed: Device or resource busy
> W: devtmpfs not available, falling back to tmpfs for /dev

It'll be:

ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")

cheers
