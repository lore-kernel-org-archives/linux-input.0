From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's
 issue
Date: Mon, 7 Nov 2016 12:59:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611071255020.29400@cbobk.fhfr.pm>
References: <1478515138-1922-1-git-send-email-hn.chen@weidahitech.com> <alpine.LNX.2.00.1611071147580.29400@cbobk.fhfr.pm> <22498D53301C4D4A8FFA8F02C7C3C7C06DDE5462@mail02.WHT.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56449 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbcKGL7H (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Nov 2016 06:59:07 -0500
In-Reply-To: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE5462@mail02.WHT.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 7 Nov 2016, Hn Chen wrote:

> Since I don't have any experience to add a quirk, may I have a sample 
> code for reference ? It should be a HID quirk, right ?

Generic HID quirk might be over-stretching it, as i2c_hid_set_power() is 
being called from various places, so generalizing this requirement out 
into HID core wouldn't be clean either.

You can special-case this behavior by looking at wVendorID / wProductID / 
wVersionID from the report descriptor, can't you?

There is not a quirk mechanism for i2c-hid yet. If things start exploding 
like in usb-hid space, we'd definitely want to have a generic quirk 
mechanism one day. But if this has been a single case over the existence 
of the hid-over-i2c, I wouldn't bother (yet).

-- 
Jiri Kosina
SUSE Labs

