From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Date: Thu, 26 Sep 2019 15:22:11 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com> <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Wed, 25 Sep 2019, Dexuan Cui wrote:

> > We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event() 
> > call does not prevent the system from entering hibernation: the 
> > hibernation is a relatively long process, which can be aborted by the 
> > call pm_wakeup_hard_event(), which is invoked upon mouse events.
> > 
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> > 
> > This patch is basically a pure Hyper-V specific change and it has a
> > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> > Implement
> > suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> > Hyper-V tree's hyperv-next branch [ ... snipped ...]
> > 
> > I request this patch should go through Sasha's tree rather than the
> > input subsystem's tree.
> > 
> > Hi Jiri, Benjamin, can you please Ack?
> 
> Hi Jiri, Benjamin,
> Can you please take a look at the patch?

Hi Dexuan,

I am planning to process it once 5.4 merge window is over and thus hid.git 
is open again for 5.5 material.

Thanks,

-- 
Jiri Kosina
SUSE Labs
