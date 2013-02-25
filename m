From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Mon, 25 Feb 2013 14:15:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302251414130.2128@pobox.suse.cz>
References: <CAG_cf+dOuB-Xi9zDdXguj9S_-PpB98wi2v1LqbR7msPD+DSwgA@mail.gmail.com> <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz> <alpine.LNX.2.00.1302251403250.2128@pobox.suse.cz> <CANq1E4QR42NyPe=SZGCpHL7Mzcic9YYxXG3v=G+WV9oNq+34oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47416 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757517Ab3BYNPW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 08:15:22 -0500
In-Reply-To: <CANq1E4QR42NyPe=SZGCpHL7Mzcic9YYxXG3v=G+WV9oNq+34oQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>

On Mon, 25 Feb 2013, David Herrmann wrote:

> >> Please provide your Signed-off-by line; without that, the patch can't be
> >> accepted.
> >
> > Andrew, please ... ?
> 
> I got the new PATCH with the sign-off. Maybe you missed it?
> 
> Subject: [PATCH 1/3] HID: Separate struct hid_device's driver_lock
> into two locks.
> Date:	Mon, 18 Feb 2013 09:20:21 -0800
> Message-Id: <1361208023-11500-2-git-send-email-andrew-vger@gizmolabs.org>

Ah, thanks for the pointer, apparently I wasn't CCed, which increases the 
likelyhood of patches getting lost significantly.

I'll take them from linux-input@ and add to my TODO.

-- 
Jiri Kosina
SUSE Labs
