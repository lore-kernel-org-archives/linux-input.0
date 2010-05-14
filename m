From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Fri, 14 May 2010 16:38:42 +0100
Message-ID: <20100514153842.GA6398@srcf.ucam.org>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org> <20100513160117.GB22238@core.coreip.homeip.net> <alpine.LFD.2.00.1005130943460.3711@i5.linux-foundation.org> <20100513171639.GA23708@core.coreip.homeip.net> <alpine.LFD.2.00.1005131017070.3711@i5.linux-foundation.org> <20100513181002.GB23708@core.coreip.homeip.net> <alpine.LFD.2.00.1005131253310.3711@i5.linux-foundation.org> <m1aas2kjb6.fsf@fess.ebiederm.org> <alpine.LFD.2.00.1005140751300.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005140751300.3711@i5.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
List-Id: linux-input@vger.kernel.org

On Fri, May 14, 2010 at 07:54:53AM -0700, Linus Torvalds wrote:

> But the issue here is that on a "legacy PC", we can't just say "ACPI 
> doesn't mention this device, so it can't exist". Because in a legacy PC 
> model, that simply isn't true. All those motherboard devices can easily 
> exist (and do!) even if ACPI/PnP don't mention them.

I think that's true except in the case where the Leading Other OS won't 
use a device unless it's present in ACPI - that kind of enforcement 
tends to concentrate vendors' minds, even if they'd otherwise be busy 
filling data tables with garbage.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
