From: "Li, Yan I" <yan.i.li@intel.com>
Subject: Re: [PATCH] Input: Lenovo S10-3t's touchpad support
Date: Tue, 30 Nov 2010 16:09:17 +0800
Message-ID: <20101130080915.GB17830@thyme.bj.intel.com>
References: <aefc1833eeede37ae6ea4a9ddeaa602eb7d31101.1290823698.git.yan.i.li@intel.com>
 <20101127075528.GA28667@core.coreip.homeip.net>
 <20101130021833.GA8369@thyme.bj.intel.com>
 <s5hfwujp9nf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59219 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab0K3IJU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 03:09:20 -0500
Content-Disposition: inline
In-Reply-To: <s5hfwujp9nf.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Ding, Jian-feng" <jian-feng.ding@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "meego-kernel@lists.meego.com" <meego-kernel@lists.meego.com>, Christopher Heiny <christopherheiny@gmail.com>

On Tue, Nov 30, 2010 at 03:12:36PM +0800, Takashi Iwai wrote:
> > It could only handle those "1 button clickpad", which emits solely
> > BTN_MIDDLE (and the kernel sends it out as BTN_LEFT instead). It can't
> > handle "2 button clickpad" correctly.
> 
> The "normal" clickpad also reports that bit.  I don't see any
> difference between Lenovo and HP machines wrt caps values.
> It shows the exact same numbers below:
> 
> Synaptics Touchpad, model: 1, fw: 7.4, id: 0x1e0b1, caps:
> 0xd04771/0xe40000/0x5a0400

My S10-3t shows this:
model: 1, fw: 7.4, id: 0x1e0b1, caps: 0xd04771/0xa40000/0x4a0500

-- 
Best regards,
Li, Yan

MeeGo Team, Opensource Technology Center, SSG, Intel
Office tel.: +86-10-82171695 (inet: 8-758-1695)
OpenPGP key: 5C6C31EF
IRC: yanli on network irc.freenode.net
