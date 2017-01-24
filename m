From: Jonathan Clarke <jonathan.a.clarke@gmail.com>
Subject: hid-multitouch: change for touch height/width
Date: Tue, 24 Jan 2017 21:47:18 +0000
Message-ID: <CAFW_ifxfBoN=gVQQiE+9-bLTtDFGjP-HMvWxXTVztOgma+JdqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36734 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdAXVsK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 16:48:10 -0500
Received: by mail-wm0-f43.google.com with SMTP id c85so147002wmi.1
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2017 13:48:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?Q?St=C3=A9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, benjamin.tissoires@redhat.com

Hi all,

I'd like to get your opinion on a proposal for a small change to the
hid-multitouch driver.  As you probably know this driver supports
multi touch input for various touchscreen/touchpad devices.

The change relates to lines 654 & 655 of "hid-multitouch.c" - I would
like to remove the "division by 2" applied to the "touch width" and
"touch height" values received from the input device.  These values
represent the width and height of the area occupied by a finger
touching the input device.

https://github.com/torvalds/linux/blame/master/drivers/
hid/hid-multitouch.c#L654

This division by 2 was added along with the the touch width/height
fields 6 years ago so that those fields "match the visual scale of the
touch" for a specific device (3M PCT) - see comment & associated
commit log for line 653.

I don't think that this scaling is appropriate for all the other devices
that this driver now supports.  On my screen for example (Elan
multitouch screen), the touch width and height reported bear no
relation to the "visual scale of the touch" with or without this /2
scaling applied.  I suspect that the scale of touch width/height
values reported are different for every device (though I've not
checked any other device).

The scaling is also discarding information about touch size (1 bit for
each of width/height) which is useful for any application that wants
to know about it.

So in summary I think the main questions for you are:
1. would making this change have a negative effect on any existing
applications that use this information?
2. does it seem sensible to (continue to) provide touch width/height
values that bear no relation to screen/pixel dimensions?

I delved into this because I wanted to get as much precision on touch
width/height as possible and was surprised at the low resolution of
sizes output by my touchscreen.  I got an extra 2 bits of precision
from my search!

Cheers & thanks for reading.  Jonathan
