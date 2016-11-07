From: Hn Chen <hn.chen@weidahitech.com>
Subject: RE: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's
 issue
Date: Mon, 7 Nov 2016 13:35:37 +0000
Message-ID: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE648F@mail02.WHT.local>
References: <1478515138-1922-1-git-send-email-hn.chen@weidahitech.com>
 <alpine.LNX.2.00.1611071147580.29400@cbobk.fhfr.pm>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDE5462@mail02.WHT.local>,<alpine.LNX.2.00.1611071255020.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2526 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcKGNfz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2016 08:35:55 -0500
In-Reply-To: <alpine.LNX.2.00.1611071255020.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

HI Jiri,

Ok. I see.  
I will do simple vid/pid filter to see if it's weida's controller.
Send the extra command if the answer is true.

hn.chen
________________________________________
From: Jiri Kosina [jikos@kernel.org]
Sent: Monday, November 07, 2016 7:59 PM
To: Hn Chen
Cc: benjamin.tissoires@redhat.com; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
Subject: RE: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's issue

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

