From: Philip Li <philip.li@intel.com>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Date: Fri, 30 Aug 2019 23:00:02 +0800
Message-ID: <20190830150002.GA6931@intel.com>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
 <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
 <20190830143645.GA4784@intel.com>
 <20190830144628.GC30413@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830144628.GC30413@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 04:46:28PM +0200, Borislav Petkov wrote:
> On Fri, Aug 30, 2019 at 10:36:45PM +0800, Philip Li wrote:
> > yes, we monitor the repo pub/scm/linux/kernel/git/tip/tip.git, and will
> > send build status of head
> 
> ... and what you call "head" is the "master" branch on that repo, right?
Hi Boris, you are right. It is the head of monitored branch, here master branch is
one of the branches on this repo that we monitor.

Early on, there's requirement to blacklist a few branches, which is configured
as below
	blacklist_branch: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus

Except the blacklist branches, we will monitor all other branches. We also
support pull request to update the configuration or email us to update.
Refer to https://github.com/intel/lkp-tests/blob/master/repo/linux/tip.

Thanks

> Just making sure you got that right.
> 
> > (like BUILD SUCCESS or REGRESSION), also provide bisect report of
> > unique error for first bad commit.
> 
> Perfect!
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
