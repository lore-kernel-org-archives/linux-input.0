From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Dell XPS 13 9350 touchpad is busted in 4.12-rc
Date: Thu, 25 May 2017 00:26:45 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705250023170.26873@cbobk.fhfr.pm>
References: <CALCETrW3fuwiV82JrFkZ5ytb+VRPwpHDOvWBD4Q5zcWF_1ePcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161529AbdEXW0r (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 May 2017 18:26:47 -0400
In-Reply-To: <CALCETrW3fuwiV82JrFkZ5ytb+VRPwpHDOvWBD4Q5zcWF_1ePcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Benjamin Tissoires <btissoir@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Allen Hung <allen_hung@dell.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Ping Cheng <pingc@wacom.com>

On Wed, 24 May 2017, Andy Lutomirski wrote:

> I just build from Linus' tree from Saturday (ef82f1ad), and touchpad
> input is busted on my laptop.  The device is still there and evtest
> still shows events, but something is wrong and libinput either thinks
> I'm not moving at all or I'm trying to teleport to the edge of the
> screen.
> 
> Is this a known problem or should I try to track it down?

Did this work properly in 4.11?

Is this G11 based chipset? (IOW, is this device driven by wacom driver?). 
If so, 6f107fab8 and/or 60a2218698 might be potential candidates.

Adding Jason, Aaron and Ping to CC.

-- 
Jiri Kosina
SUSE Labs

