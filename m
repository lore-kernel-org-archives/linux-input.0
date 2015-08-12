From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: gembird: add new driver to fix Gembird
 JPD-DualForce 2
Date: Wed, 12 Aug 2015 13:34:08 -0400
Message-ID: <20150812173408.GB31728@mail.corp.redhat.com>
References: <1439307348-5184-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150812013255.31ea3b7e@orivej.orivej.org>
 <20150812144028.GA31257@mail.corp.redhat.com>
 <20150812165105.3bfd4516@orivej.orivej.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221AbbHLReL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2015 13:34:11 -0400
Content-Disposition: inline
In-Reply-To: <20150812165105.3bfd4516@orivej.orivej.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Orivej Desh <orivej@gmx.fr>
Cc: linux-input@vger.kernel.org

On Aug 12 2015 or thereabouts, Orivej Desh wrote:
> -linux-kernel@vger.kernel.org
> -jkosina@suse.com
> 
> * Benjamin Tissoires
> > Hmm... This was actually my first shot, and I noticed that the
> > flickering original Z axis was now taking over the correct X axis. So
> > that's why I added some complexity to ignore at the HID level this axis.
> > I just forgot to update the comment :)
> 
> How did you notice that?  Is there a tool in hid-replay?  I did not test

I used evemu-record (package evemu) to see at the raw outputs from the
kernel.

> my edition of the patch extensively because I did not expect such a
> subtle difference.  Yet I did not observe flickering when joypad was
> idle.

There might be filtering on the userspace side for X/Y, that would
explain.

> 
> I assumed that the commit that hid Rx axis in 3.18 by calling
> "map_abs_clear(usage->hid & 0xf);" effectively removed any influence of
> repeated axes in report description, but now it seems I am wrong.  Would
> you explain what it really did?

It did remove the repeated axes. When you call map_abs(), it tries to
map the given HID axis to the corresponding evdev axis. But if this axis
is already mapped to an existing HID axis, it tries the next one. This
works OK for miscellaneous axes, but not for the ones that are actually
used and have a true semantic. By calling map_abs_clear(), the evdev
axis is left untouched, so the next time it is mapped, it does not try
the next one.

> 
> > If you think this patch is good enough (you will get flickering X), we
> > can carry on this one, but I think the one I submitted (with the comment
> > edited) would provide a better experience.
> 
> In this case I certainly prefer your original patch.

OK. I'll amend the comment in the patch and resubmit then.

Cheers,
Benjamin

