From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the backdoor
 call with support for new instructions
Date: Fri, 30 Aug 2019 08:06:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2> <201908292325.aLXyyzEx%lkp@intel.com> <20190829163353.GC2132@zn.tnic> <20190830010349.GD857@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830010349.GD857@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Li <philip.li@intel.com>
Cc: Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

Philip,

On Fri, 30 Aug 2019, Philip Li wrote:

> > wanna test trees, I'd suggest simply testing TIP's tip/master branch
> > which gets redone on a daily basis instead of testing patches in the
> > tip-bot{,2} notification mails.
>
> Thanks Boris for the input. Besides the repo monitoring, we also check the patches
> in mailing lists, and try to apply patch to a suitable base. Do you think we can
> skip the mailing list of tip-bot{,2}?

As I just explained in a reply to another random build failure caused by this.

tip-bot2 is a notification mechanism to let people know that a particular
patch has been merged into one of the tip tree branches. These mails are
also properly threaded most of the time and reply to the patch which was
sent to the mailing list.

So yes, randomly picking patches from tip-bot2 is not useful at all. The
mails contain the information to which tip branch the patch has been
applied, so the only useful information for your bot is to select the
branch which got the new patches and start testing on that one.

Thanks,

	tglx
