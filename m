From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 11:58:31 -0400
Message-ID: <20150319155830.GB18134@mail.corp.redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbbCSP6e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 11:58:34 -0400
Content-Disposition: inline
In-Reply-To: <20150319152526.GA3651@balvenie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> On Thu, Mar 19, 2015 at 10:46:27AM -0400, Benjamin Tissoires wrote:
> > On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > > So I have two questions/remarks about this:
> > > 
> > > - if I don't use the touchpad, do I need xf86-input-synaptics at all?
> > 
> > Wether you use it or not, with the current kernel patch set, there will
> > be no modifications to do in xf86-input-synaptics. Legacy versions will
> > work just fine and the trackstick/touchpads are seen like they were in
> > the past (lik ein the thinkpads t410 .. t430).
> > 
> > So I would advice to just revert to whatever Xorg / xf86-input-synaptics
> > / configuration you had from your distribution, apply the patches (or
> > wait for 4.0-rc5), and you are done.
> 
> So to summarize: both patchsets are enough for complete
> touchpad+trackpoint operations, having both is not useful but not
> harmful either, and it's better to have the kernel one.

Hmm, sorry, looks like I was not clear enough in my reply.

- the kernel patch is the fix.
- the xf86-input-synaptics patch has been reverted upstream [1]. See
  Peter's explanations on his blog post [2]

The main problem with the xorg approach was that the middle button was
not working and the buttons were released immediately after the press.

This buttons problems have been marked for stable because they are
actually bug fix. The re-routing is not because we already backported
many things in the synaptics driver that have fired back now, so I
prefer asking the distributions to backport it themselves. If they don't
want, they can still revert the revert in xf86-synaptics, but this is
not a nice fix.

One more reason for not asking to backport the re-routing is that
broadwell laptops needs a recent kernel, and possibly backport other
patches from 4.0, so things will get settle once 4.0 gets in the main
distributions.

> 
> Am I right? Thanks for the information, I'll also try to point our
> kernel maintainers to that thread and ask them if it's possible to
> backport them to the 3.16 kernel for Jessie.

Yes, please do. For the record, they are already in Fedora.

> > 
> > > - how can I have the BIOS setting respected by the psmouse/synaptics
> > >   kernel module (like when using psmouse)
> > 
> > I was confused at first so I double checked. If you use the
> > psmouse.proto=imps boot parameter, then the bios setting is respected.
> > 
> > If the trackpad is enabled, it is barely usable, but that's what you get
> > :)
> 
> Oh ok. I didn't try to boot with touchpad enabled in BIOS and
> psmouse.proto=imps, so I missed that.
> 
> But that doesn't really answer my question. Can the BIOS setting be
> handled correctly, so I don't have to disable the touchpad from xinput
> or something?
> 

Again, sorry, I thought I answered it. With the kernel patches applied:
- disabled in the bios without psmouse.proto=imps -> touchpad still
  enabled, trackstick + buttons working
- disabling in the bios + psmouse.proto=imps -> touchpad disabled,
  trackstick + buttons working
- enabled in the bios + psmouse.proto=imps -> touchpad barely usable,
  trackstick + buttons working

That should cover all the cases :)

Cheers,
Benjamin


[1] http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/commit/?id=5378a020a003cbdfa565d43c9e01997b570059c9
[2] http://who-t.blogspot.com/2015/01/lenovos-x1-carbon-3rd-touchpad-woes.html
