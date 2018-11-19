From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [LKP] dad4f140ed [ 7.709376] WARNING:suspicious_RCU_usage
Date: Mon, 19 Nov 2018 06:39:18 -0800
Message-ID: <20181119143918.GB394@bombadil.infradead.org>
References: <20181119010820.GM18977@shao2-debian>
 <20181119011904.GE7861@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119011904.GE7861@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <rong.a.chen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-input@vger.kernel.org

On Sun, Nov 18, 2018 at 05:19:04PM -0800, Matthew Wilcox wrote:
> On Mon, Nov 19, 2018 at 09:08:20AM +0800, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> Umm.  I don't see a 'suspicious RCU usage' message in here.  I see a
> lot of vmalloc warnings ... ?

Never mind, the RCU warnings were in one of the attached dmesg files.
I found the problem; it's in the test-suite and not something that could
lead to any real problems today.

Thanks for the report!
