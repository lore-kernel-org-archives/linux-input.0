From: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/2] Provide a driver for the Apple Magic Mouse
Date: Tue, 09 Feb 2010 08:10:48 -0500
Message-ID: <87y6j2eeqv.fsf_-_@troilus.org>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	<dd18b0c31002082322m4238a4a6m73fc30752ba30447@mail.gmail.com>
	<1265710460.2383.5685.camel@localhost.localdomain>
	<201002090736.55576.edt@aei.ca>
	<alpine.LNX.2.00.1002091339190.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1002091339190.30967-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org> (Jiri
	Kosina's message of "Tue, 9 Feb 2010 13:40:58 +0100 (CET)")
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

I think this patch is ready for real review.  The Magic Mouse requires
that a driver send an unlock Report(Feature) command, similar to the
Wacom wireless tablet and Sixaxis controller quirks.  This turns on an
Input Report that isn't published in the input Report descriptor that
contains touch data (and usually overrides the normal motion and click
Report).

Because the mouse has only one switch and no scroll wheel, the driver
(under control of parameters) emulates a middle button and scroll wheel.
User space could also ignore and/or re-synthesize those events based on
the reported events.

The first patch exports hid_register_report() so the driver can turn on
the multitouch report.  The second patch adds the device ID and the
driver.  Some user-space tools to talk to the mouse directly (that is,
when it is not associated with the host's HIDP stack) are at
http://github.com/entrope/linux-magicmouse .
