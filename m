From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting
 kernel
Date: Thu, 25 May 2017 11:08:32 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705251106220.26873@cbobk.fhfr.pm>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34833 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932550AbdEYJIg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 05:08:36 -0400
In-Reply-To: <1495700957.9020.43.camel@abdul.in.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>

On Thu, 25 May 2017, Abdul Haleem wrote:

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
> starting version 222
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin:
> Running /scripts/local-top ... done.
> chvt: can't open console
> Gave up waiting for root device.  Common problems:
>  - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
>    - Check root= (did the system wait for the right device?)
>  - Missing modules (cat /proc/modules; ls /dev)
> chvt: can't open console
> ALERT!  /dev/disk/by-uuid/3aee8de3-5b8f-4a89-9e89-108efe213983 does not
> exist.  Dropping to a shell!

Seems like the by-uuid node for your harddrive containing rootfs didn't 
show up.

The EBUSY from mount(/dev) seems like the biggest suspect.

These:

> hid: module verification failed: signature and/or required key missing -
> tainting kernel
> hidraw: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver

are for sure unrelated.

Please focus on figuring out why mounting /dev doesn't succeed.

-- 
Jiri Kosina
SUSE Labs

