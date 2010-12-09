From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] input: mt updates for 2.6.38
Date: Thu, 9 Dec 2010 01:08:26 -0800
Message-ID: <20101209090826.GB8821@core.coreip.homeip.net>
References: <4CFF49BC.8030202@euromail.se>
 <20101209085814.GA8821@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101209085814.GA8821@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 09, 2010 at 12:58:14AM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 08, 2010 at 10:02:52AM +0100, Henrik Rydberg wrote:
> > Dmitry,
> > 
> > Please pull from
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next
> > 
> > to receive input-mt updates for 2.6.38.
> > 
> > The tree contains core changes as well as dependent changes to hid drivers. You
> > also find the new hid-egalax driver in there, signed off by Jiri.
> 
> Pulled, thank you Henrik.
> 
> I wonder if we should move input-mt.h into input/mt.h (and if someone
> would bother to input-polldev.h there that would be great too).
> 
> Also I try to sync with mainline once per release, at -rc1, unless I
> know that my changes will conflict with some other work. I'd recommend
> you do the same so that when I pull from you I am getting just your
> changes and not the rest of stuff from mainline.
> 
> BTW, we need to document dev->trkid to avoid complaints from 'make
> htmldocs' and friends. I wonder if the patch below will do.
> 
> Thanks.
> 

And I think we need this one as well:

Input: include MT library as source for kerneldoc

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/DocBook/device-drivers.tmpl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/Documentation/DocBook/device-drivers.tmpl b/Documentation/DocBook/device-drivers.tmpl
index 22edcbb..467beee 100644
--- a/Documentation/DocBook/device-drivers.tmpl
+++ b/Documentation/DocBook/device-drivers.tmpl
@@ -304,6 +304,10 @@ X!Idrivers/video/console/fonts.c
 !Edrivers/input/ff-core.c
 !Edrivers/input/ff-memless.c
      </sect1>
+     <sect1><title>Multitouch Library</title>
+!Iinclude/linux/input-mt.h
+!Edrivers/input/input-mt.c
+     </sect1>
      <sect1><title>Polled input devices</title>
 !Iinclude/linux/input-polldev.h
 !Edrivers/input/input-polldev.c

-- 
Dmitry
