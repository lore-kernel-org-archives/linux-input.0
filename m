From: "Li, Yan I" <yan.i.li@intel.com>
Subject: Re: [PATCH] Input: Lenovo S10-3t's touchpad support
Date: Tue, 30 Nov 2010 10:18:40 +0800
Message-ID: <20101130021833.GA8369@thyme.bj.intel.com>
References: <aefc1833eeede37ae6ea4a9ddeaa602eb7d31101.1290823698.git.yan.i.li@intel.com>
 <20101127075528.GA28667@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16272 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab0K3CSn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Nov 2010 21:18:43 -0500
Content-Disposition: inline
In-Reply-To: <20101127075528.GA28667@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, "Ding, Jian-feng" <jian-feng.ding@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "meego-kernel@lists.meego.com" <meego-kernel@lists.meego.com>, Christopher Heiny <christopherheiny@gmail.com>

On Sat, Nov 27, 2010 at 03:55:28PM +0800, Dmitry Torokhov wrote:
> > So far we've found that the S10-3ts are shipped with two slightly
> > different models of touchpads, of which the 0x0c cap is either
> > 0x5a0400 or 0x4a0500. They are not Clickpad and return BTN_LEFT and
> > BTN_RIGHT normally.
> 
> Hmm, this is weird. According to my data:
> 
> >> Treat it as a two-bit field.
> >>   0x00 == not a clickpad
> >>   0x01 == 1 button clickpad
> >>   0x02 == 2 button clickpad
> >>   0x03 == reserved

Wait, you said there are "2 button clickpad"? If so the current way
the kernel handles clickpad is totally wrong:

    if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
        /* Clickpads report only left button */
        __clear_bit(BTN_RIGHT, dev->keybit);
        __clear_bit(BTN_MIDDLE, dev->keybit);
    }

It could only handle those "1 button clickpad", which emits solely
BTN_MIDDLE (and the kernel sends it out as BTN_LEFT instead). It can't
handle "2 button clickpad" correctly.

So I think the touchpad installed on the S10-3t is a "2 button
clickpad" and it emits BTN_LEFT and BTN_RIGHT as usual.

Also IIRC the current X synaptics driver detects clickpad by checking
whether it has one button only, obviously this could not work with 2
button clickpad either.

-- 
Best regards,
Li, Yan

MeeGo Team, Opensource Technology Center, SSG, Intel
Office tel.: +86-10-82171695 (inet: 8-758-1695)
OpenPGP key: 5C6C31EF
IRC: yanli on network irc.freenode.net
