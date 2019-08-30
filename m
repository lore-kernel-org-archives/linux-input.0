From: Philip Li <philip.li@intel.com>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Date: Fri, 30 Aug 2019 22:36:45 +0800
Message-ID: <20190830143645.GA4784@intel.com>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
 <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830080650.GA30413@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 10:06:50AM +0200, Borislav Petkov wrote:
> On Fri, Aug 30, 2019 at 02:20:53PM +0800, Philip Li wrote:
> > thanks for your patience. I just realize we actually block tip-bot, but
> > not tip-bot2. I will update the logic to avoid this issue, and we will
> > keep monitor for a while to fix new issue if any.
> 
> ... and just to reiterate: it would be a *lot-lot* more useful if you
> guys tested the single tip branches or the combined tip/master on a
> daily basis as that is the x86 queue that goes to Linus eventually. That
yes, we monitor the repo pub/scm/linux/kernel/git/tip/tip.git, and will
send build status of head (like BUILD SUCCESS or REGRESSION), also provide
bisect report of unique error for first bad commit.

> is, if you do not test it already. But we don't get any "we tested this
> branch" email so I'm thinking you don't...
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
