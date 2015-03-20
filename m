From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Fri, 20 Mar 2015 14:59:37 +0100
Message-ID: <20150320135936.GA2904@balvenie>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
 <20150319152526.GA3651@balvenie>
 <20150319155830.GB18134@mail.corp.redhat.com>
 <20150319164746.GA1648@balvenie>
 <20150319170649.GE18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.194.244.226] ([78.194.244.226]:51093 "EHLO molly.corsac.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbbCTOAf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2015 10:00:35 -0400
Content-Disposition: inline
In-Reply-To: <20150319170649.GE18134@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 19, 2015 at 01:06:49PM -0400, Benjamin Tissoires wrote:
> To solve your problem, your desktop environment must have a "disable
> touchpad" switch in the configuration panel. At least, gnome has. This
> way, your settings should come back at each login.
> And if this is not sufficient enough, you can always add a xorg.conf.d
> snippet which disables the touchpad when X starts.

In the end, I did it that way. Using psmouse.proto=imps also means I
lose the speed/sensitivity settings on the TrackPoint, and the new
defaults are not really usable for me (following the advice in that
thread, I've set them to 105 and 160, now I need to cook an udev rule or
something to set them at boot).

I tried to generate i8042.debug logs for:

- BIOS touchpad disable / psmouse.proto=imps
- BIOS touchpad enable  / psmouse.proto=imps
- BIOS touchpad disable
- BIOS touchpad enable

but the logs for the two last ones are imcomplete, I get:

Mar 20 12:53:21 balvenie systemd-journal[368]: Missed 2672 kernel
messages

so I miss the initialization which I guess is the most useful part.

Regards,
-- 
Yves-Alexis
