From: Borislav Petkov <bp@alien8.de>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Date: Fri, 30 Aug 2019 21:35:57 +0200
Message-ID: <20190830193557.GF30413@zn.tnic>
References: <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
 <20190830143645.GA4784@intel.com>
 <20190830144628.GC30413@zn.tnic>
 <20190830150002.GA6931@intel.com>
 <20190830150856.GB6931@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830150856.GB6931@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Li <philip.li@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kbuild test robot <lkp@intel.com>, linux-input@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>, x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org, pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@redhat.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 11:08:56PM +0800, Philip Li wrote:
> hi Boris, for the build status notification, we currently send to below
> address, is it still valid? If not, can you suggest one for us?

Sure, here's an update patch ontop of your master branch:

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 30 Aug 2019 21:33:29 +0200
Subject: [PATCH] repo/linux/tip: Update tip tree contact information

Replace hpa with Borislav and change contact mail address.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 repo/linux/tip | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/repo/linux/tip b/repo/linux/tip
index 4fc5d88176fd..96a7dec66f97 100644
--- a/repo/linux/tip
+++ b/repo/linux/tip
@@ -2,11 +2,11 @@ url: https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git
 integration_testing_branches: auto-latest
 mail_cc:
 - linux-kernel@vger.kernel.org
-- tipbuild@zytor.com
+- x86@kernel.org
 owner:
 - Ingo Molnar <mingo@kernel.org>
-- H. Peter Anvin <hpa@zytor.com>
 - Thomas Gleixner <tglx@linutronix.de>
+- Borislav Petkov <bp@suse.de>
 subsystems:
 - x86
 - fpu
@@ -16,4 +16,4 @@ subsystems:
 - locking
 blacklist_branch: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus
 notify_build_success_branch: .*
-build_success_mail_to: tip build status <tipbuild@zytor.com>
+build_success_mail_to: x86-ml <x86@kernel.org>
-- 
2.21.0

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
