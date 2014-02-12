From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and
 device_type.release() to free storage.
Date: Wed, 12 Feb 2014 09:09:11 -0800
Message-ID: <20140212170910.GC1706@sonymobile.com>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com>
 <20140212015929.GZ1706@sonymobile.com>
 <52FAD9D5.5070900@synaptics.com>
 <20140212024940.GA1706@sonymobile.com>
 <52FAE7E7.4090905@synaptics.com>
 <20140212045452.GB1706@sonymobile.com>
 <20140212064342.GB15855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:1405 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751703AbaBLRH1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 12:07:27 -0500
Content-Disposition: inline
In-Reply-To: <20140212064342.GB15855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Feb 12, 2014 at 07:43:42AM +0100, Dmitry Torokhov wrote:
> On Tue, Feb 11, 2014 at 08:54:53PM -0800, Courtney Cavin wrote:
> > On Wed, Feb 12, 2014 at 04:17:59AM +0100, Christopher Heiny wrote:
> > > On 02/11/2014 06:49 PM, Courtney Cavin wrote:
> > > > On Wed, Feb 12, 2014 at 03:17:57AM +0100, Christopher Heiny wrote:
> > > >> On 02/11/2014 05:59 PM, Courtney Cavin wrote:
> > > >>> On Wed, Feb 12, 2014 at 12:13:30AM +0100, Christopher Heiny wrote:
> > > >>>> For rmi_sensor and rmi_function device_types, use put_device() and
> > > >>>> the assocated device_type.release() function to clean up related
> > > >>>> structures and storage in the correct and safe order.
> > > >>>>
> > > >>>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> > > >>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >>>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >>>> Cc: Linux Walleij <linus.walleij@linaro.org>
> > > >>>> Cc: David Herrmann <dh.herrmann@gmail.com>
> > > >>>> Cc: Jiri Kosina <jkosina@suse.cz>
> > > >>>> Cc: Courtney Cavin <courtney.cavin@sonymobile.com>
> > > >>>
> > > >>> I'm not a huge fan of you taking my patches, re-formatting them and
> > > >>> sending them as your own.  More out of principle then actually caring
> > > >>> about ownership.  You at least cc'd me on this one....
> > > >>
> > > >> Sorry - no slight was intended at all!  I wasn't sure what the protocol
> > > >> was for picking up an idea from someone else's patch and building on
> > > >> that idea, so I just went with the CC.  I definitely prefer to attribute
> > > >> sources correctly - if you could clarify what should be done (beyond the
> > > >> CC) to acknowledge the author of the original patch, I'd appreciate it.
> > > >
> > > > Sure.  In short, follow Documentation/SubmittingPatches , esp. section
> > > > 12) Sign your work.
> > > >
> > > > Generally the patch should read something like the following:
> > > >
> > > >   From: Original Author <original.author@example.org>
> > > >
> > > >   *BLURB*
> > > >
> > > >   Signed-off-by: Original Author <original.author@example.org>
> > > >   [additional.author@example.org: changed x and y]
> > > >   Signed-off-by: Additional Author <additional.author@example.org>
> > > >
> > > > Assuming the original author actually signed-off the patch in the first
> > > > place, of course.  The square bracket part is optional, but can be
> > > > helpful for reviewers.
> > > >
> > > > I'm somewhat surprised that you are not aware of this procedure, as this
> > > > is how Dmitry has replied to some of your patches in the past.'
> > > 
> > > Thanks very much.
> > > 
> > > I was actually aware of that, but thought the work was sufficiently 
> > > different from your original patch that applying your Signed-off-by: to 
> > > it wouldn't be appropriate (I dislike being signed off on things I don't 
> > > necessarily agree with as much as lack of attribution).  I'll be less 
> > > paranoid about that in the future.
> > 
> > I don't see how they were different enough, when clearly these two
> > patches attempt to fix the same bugs, using the same methods with
> > slightly modified flow.  Perhaps the patches may be small enough
> > to be interpreted either way, but at the very least reported-by (since
> > this is a bug-fix) or suggested-by is more appropriate than Cc.  This is
> > a public list, so I'm sure someone will tell you when you are wrong, if
> > nothing else.
> > 
> > Along the same topic, I guess I should also mention that it is typically
> > frowned upon to takeover someone else's patches without giving them
> > due-time to fix any outstanding review comments.
> > 
> > In both of these cases, you neither asked for me to submit the patches
> > separately, outside of my DT-series, nor to make any specific changes.
> > I was under the impression that you were still participating in the
> > discussion for that series.
> > 
> > While it is apparent that we have differing views on how this particular
> > driver development should proceed, and we should definitely discuss
> > them, please do not think that I'm not willing to apply my patches
> > individually to what's in tree now.
> > 
> > My main concern here is that I cannot actually properly test this driver
> > without DT, non-gpio irq, and regulator support.  Likewise, pre-3.7 is
> > ancient, and would require back-porting hundreds of changes.
> 
> I can rebase to something more recent; I just did not want to cause
> additional work for Chris. Once he finishes pushing his code I was going
> to rebase anyway.

That would be great! Thanks.

-Courtney
