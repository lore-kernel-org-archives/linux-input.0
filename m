From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/6] Large scancode handling
Date: Mon, 13 Sep 2010 18:26:41 -0700
Message-ID: <20100914012641.GB2491@core.coreip.homeip.net>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
 <20100908143121.GD22323@redhat.com>
 <20100908153435.GA4190@core.coreip.homeip.net>
 <AANLkTikV9jWWPhK0C-1ipFei18pHUg86Yj1Pm10010An@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikV9jWWPhK0C-1ipFei18pHUg86Yj1Pm10010An@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Jarod Wilson <jarod@redhat.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Jiri Kosina <jkosina@suse.cz>, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 13, 2010 at 01:48:14PM -0400, Jarod Wilson wrote:
> On Wed, Sep 8, 2010 at 11:34 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Sep 08, 2010 at 10:31:21AM -0400, Jarod Wilson wrote:
> >> On Wed, Sep 08, 2010 at 12:41:38AM -0700, Dmitry Torokhov wrote:
> ...
> >> > Ville, do you still have the hardware to try our ati_remote2 changes?
> >>
> >> If not, I've got the hardware. (Speaking of which, porting ati_remote*
> >> over to {ir,rc}-core is also on the TODO list, albeit with very very
> >> low priority at the moment).
> >
> > Ok, then we'' pencil you in for testing if we do not hear from Ville ;)
> 
> We've heard from Ville, but I went ahead and did some testing anyway.
> My RWII with the default mode (didn't try any of the others) works
> just fine after applying this patch atop 2.6.36-rc3-git1, as do my
> imon and mceusb receivers. Ran into some problems with streamzap, but
> I'm fairly sure they're not the fault of this patchset.
> 

Thank you Jarod, I'll add Tested-by: you then.

-- 
Dmitry
