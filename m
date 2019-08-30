From: Borislav Petkov <bp@alien8.de>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Date: Fri, 30 Aug 2019 17:06:53 +0200
Message-ID: <20190830150653.GD30413@zn.tnic>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
 <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
 <20190830143645.GA4784@intel.com>
 <20190830144628.GC30413@zn.tnic>
 <20190830150002.GA6931@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830150002.GA6931@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Li <philip.li@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 11:00:02PM +0800, Philip Li wrote:
> Early on, there's requirement to blacklist a few branches, which is configured
> as below
> 	blacklist_branch: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus

Looks about right.

> Except the blacklist branches, we will monitor all other branches.

Ok, good to know. Just as an optimization to your workflow, in case
you're interested: the tip/master branch merges all tip branches so if
you're trying to prioritize which branches to test first due to resource
constraints, I'd go with tip/master first and then, when I have free
cycles, I'd do the topic branches.

Just as an idea...

> We also support pull request to update the
> configuration or email us to update. Refer to
> https://github.com/intel/lkp-tests/blob/master/repo/linux/tip.

Ok, cool. I'll talk to tglx about it and might even send you a pull
request.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
