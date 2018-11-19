From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [LKP] dad4f140ed [ 7.709376] WARNING:suspicious_RCU_usage
Date: Sun, 18 Nov 2018 17:19:04 -0800
Message-ID: <20181119011904.GE7861@bombadil.infradead.org>
References: <20181119010820.GM18977@shao2-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119010820.GM18977@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <rong.a.chen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 19, 2018 at 09:08:20AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is

Umm.  I don't see a 'suspicious RCU usage' message in here.  I see a
lot of vmalloc warnings ... ?

> [    7.699777] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.724561] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.737925] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.750283] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.777903] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.787175] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
> [    7.796181] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
> [    7.804841] swapper: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO), nodemask=(null)
