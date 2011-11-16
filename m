From: Cedric Sodhi <manday@gmx.net>
Subject: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 10:50:30 +0100
Message-ID: <20111116095030.GC3335@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54803 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753478Ab1KPJut (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 04:50:49 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everyone,

the context for this problem is getting the eGalax USB Touchscreen, ID
056a:0090, to work as such, as it is discussed on the linuxwacom-devel
list (see [1]).

Quickly summarized:

Adding the device as USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5, in line with
the ..._MULTITOUCH[1-4], succeeds in thus far, as that it appears as a
HID Touchscreen. However, as of 3.1.x, clicking, id est touching "jams"
as in the click is never released.

Updating to 3.2.x-torvalds' kernel should have resolved that jamming,
but instead no clicks or releases are recognized at all.

The real problem with debugging that, though, is that

/sys/kernel/debug/hid/<eGalax>/events

remains dead, in any kernel, 3.1.x-gentoo, 3.1.x-vanilla and
3.2.x-torvalds alike.

I hope that you may have an idea as for any of the problems, especially
why there appears no output on the ./events node (the according node for
my keyboard reports events just fine).

Pasted is .config [2] for 3.2.x-torvalds and ./hid/<eGalax>/rdesc [3] on
3.2.x-torvalds.

[1]
http://sourceforge.net/mailarchive/forum.php?thread_name=CAGzDe_Y2cSMxVPm-rcNSrMsew2V5Y0vbVyhXJBFCKraq7EaZ8g@mail.gmail.com&forum_name=linuxwacom-devel
[2] http://paste.pocoo.org/show/508548/
[3] http://paste.pocoo.org/show/508550/
