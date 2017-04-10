From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Crash caused by hid-rmi and no longer working touchscreen
Date: Mon, 10 Apr 2017 15:18:03 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704101515380.28004@cbobk.fhfr.pm>
References: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48179 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbdDJNSG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 09:18:06 -0400
In-Reply-To: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: aduggan@synaptics.com, benjamin.tissoires@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>


[ a couple more people from "the other regression thread" added to CC ]

On Mon, 10 Apr 2017, Gabriele Mazzotta wrote:

> Hi,
> 
> I'm having troubles with hid-rmi using 4.11-rc6. I'm getting some
> "rmi_hid_read_block: timeout elapsed" errors and ultimately the
> crash you can see at the end of this mail. I will reply to this
> mail with a full log that shows all the errors.
> 
> The problem seems to be caused by commit 279967a65b320d174a507498ae
> ("HID: rmi: Handle all Synaptics touchpads using hid-rmi").
> 
> My laptop has a Synaptics touchpad and a Synaptics touchscreen.
> Because of that commit, hid-rmi is used for both the devices, while
> it has always been used only for the touchpad. Needless to say that
> the touchscreen no longer works.
> 
> If I revert that commit, everything goes back to normal.

Alright, given this is a second regression cause by this switch, I suggest 
to revert this one for 4.11 still, and work on fixing this properly for 
4.12.

If noone raises any objections (a few more people added to Cc), I'll queue 
a 4.11-rc revert tomorrow.

-- 
Jiri Kosina
SUSE Labs

