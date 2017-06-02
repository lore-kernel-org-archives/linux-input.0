From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Fri, 2 Jun 2017 15:47:03 +0200
Message-ID: <20170602134702.GQ1293@mail.corp.redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
 <1496345185.2570.3.camel@hadess.net>
 <20170602072907.GK1293@mail.corp.redhat.com>
 <1496408048.2570.11.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28851 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdFBNrL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Jun 2017 09:47:11 -0400
Content-Disposition: inline
In-Reply-To: <1496408048.2570.11.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dave Hansen <dave.hansen@intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 02 2017 or thereabouts, Bastien Nocera wrote:
> On Fri, 2017-06-02 at 09:29 +0200, Benjamin Tissoires wrote:
> > 
> <snip>
> > Bastien, is is possible to have a simple udev rule that tells upower
> > to
> > ignore the battery device if builtin_power_supply is there?
> > That way we can tell people running old upower to use this to be sure
> > to
> > ignore the kernel device and just rely on the upower hidpp support?
> 
> I'm not sure where we'd ship that in a way that would make it work
> differently based on the version of UPower. In UPower? Well, UPower
> 0.99.x is the stable track for UPower, and the git master already has
> support for this feature.
> 
> I'm not sure what else would need to be done.

I was more thinking at a snippet that we drop on this mailing list
(here) that users can carefully copy/paste in their /etc and remove
themself once they upgrade the system.
Though OTOH, that's relying on users remembering that they have a
special conf that need to be removed in a later update.

Cheers,
Benjamin
