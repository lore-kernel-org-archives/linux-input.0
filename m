From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting
 kernel
Date: Fri, 26 May 2017 07:24:37 +1000
Message-ID: <20170526072437.46499fbd@canb.auug.org.au>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
        <8760gp9jjl.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:51545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970258AbdEYVYl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 17:24:41 -0400
In-Reply-To: <8760gp9jjl.fsf@concordia.ellerman.id.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, sachinp <sachinp@linux.vnet.ibm.com>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>

Hi Michael,

On Thu, 25 May 2017 23:02:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It'll be:
> 
> ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")

And Andrew has asked me to drop that patch from linux-next which will
happen today.

-- 
Cheers,
Stephen Rothwell
