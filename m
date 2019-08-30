From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the backdoor
 call with support for new instructions
Date: Fri, 30 Aug 2019 09:58:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1908300957450.1933@nanos.tec.linutronix.de>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2> <201908292325.aLXyyzEx%lkp@intel.com> <20190829163353.GC2132@zn.tnic> <20190830010349.GD857@intel.com> <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de> <20190830062053.GA2598@intel.com>
 <20190830063326.GB2598@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830063326.GB2598@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Li <philip.li@intel.com>
Cc: Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 30 Aug 2019, Philip Li wrote:
> On Fri, Aug 30, 2019 at 02:20:53PM +0800, Philip Li wrote:
> > thanks for your patience. I just realize we actually block tip-bot, but
> > not tip-bot2. I will update the logic to avoid this issue, and we will
> > keep monitor for a while to fix new issue if any.
>
> BTW: the related service need some time to be upgraded after code change,
> some already fetched patches will continue sending out noisy mails until
> they are consumed. Sorry about this.

All good. I'll just redirect them to /dev/null.

Thanks,

	tglx
