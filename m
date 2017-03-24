From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Fri, 24 Mar 2017 15:15:32 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703241459510.31814@cbobk.fhfr.pm>
References: <20170211050004.GA3944@gmail.com>,<alpine.LSU.2.20.1703211506060.31814@cbobk.fhfr.pm>,<1DD62093774CEE42AFC16E785A10880489C9FF8A@USCULXMSG08.am.sony.com> <1DD62093774CEE42AFC16E785A10880489C9FFB9@USCULXMSG08.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52855 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965697AbdCXOP4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 10:15:56 -0400
In-Reply-To: <1DD62093774CEE42AFC16E785A10880489C9FFB9@USCULXMSG08.am.sony.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Cc: Todd Kelner <tsopdump@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Frank Praznik <frank.praznik@gmail.com>, Simon Wood <simon@mungewell.org>

On Wed, 22 Mar 2017, Colenbrander, Roelof wrote:

> On a sidenote I'm starting to wonder how we should deal with multiple 
> devices in this driver in the future. The driver is starting to support 
> many different kinds of devices (mostly game controllers) and a few 
> other devices (vaio). They are all HID, but behave very differently and 
> some share concepts e.g. LEDs, touchpads or motion sensors. It is 
> starting to become more and more painful to handle many very different 
> devices in kind of one driver even though they are not really related. 
> There are layers of abstractions to dispatch to the right 'subdriver' 
> e.g. in sony_raw_event and many other places. There is a shared driver 
> structure (sony_sc), but some portions like function pointers or work 
> structs only apply to some devices.

If this is going to become a real problem, the most straightforward 
solution to me would be to actually separate the driver into completely 
different 'sub-drivers', but have them link at the end of the day into one 
'hid-sony', mostly for compatibility reasons (but also to keep following 
the general pattern we have).

> Also thinking a bit in how to use this driver in actual products. We may 
> only want certain pieces (e.g. game controller support) and not support 
> for the other devices either because we already have another driver for 
> it or we don't want to include this code as we don't intend to support 
> it (and verify behaviour) on said product. It is in nobody's interest to 
> have multiple code bases.

You can always blacklist/unbind the device if you're going to ship some 
out-of-tree driver, but I don't think we should really optimize the 
in-kernel code for that.

Thanks,

-- 
Jiri Kosina
SUSE Labs

