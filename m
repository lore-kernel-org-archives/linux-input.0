From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 0/6] hid: Introduce device groups
Date: Mon, 23 Apr 2012 17:21:15 +0200
Message-ID: <CAN+gG=F82KBEtf74S10tD+KBnqHVFdxz2+7vX70x0F1wd_HqhA@mail.gmail.com>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62012 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2DWPVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:21:16 -0400
In-Reply-To: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Henrik,

Thanks for handling this. I still won't have the time to review this
patch set before early may as I'm out of my office. Also sorry for not
answering the previous mails, I did not had a reliable internet
connection during my holidays.

Thanks,
Benjamin

Le 23 avr. 2012 12:03, "Henrik Rydberg" <rydberg@euromail.se> a =E9crit=
=A0:
>
> Hi Jiri.
>
> Here is the third version of the extension to the device-driver
> matching mechanism. AFAICT, there are no outstanding issues. I think
> we are getting close. :-)
>
> Building on the report fixup patches, this patchset brings a bit of
> transparency to the hid bus, by the addition of device groups. =A0Thi=
s
> allows a more versatile handling of hid drivers in userland, and
> simplifies the logic in the kernel.
>
> In particular, there can be one generic module per device group, and
> those modules are handled automatically by udev. Dynamic rebinding of
> drivers is fully supported. For instance, to load a special
> out-of-tree driver instead of the a generic one, simply unbind the
> device and load the new module. One can also keep _all_ generic
> drivers as modules, significantly simplifying the process of adding
> and testing new features.
>
> And, of course, auto-loading of new multitouch drivers works, since
> that was what triggered this patchset to begin with. :-)
>
> The second patch contains a simple descriptor scanner that is
> new. The last patch unifies the generic drivers into a single,
> loadable module.
>
> Enjoy,
> Henrik
>
> Henrik Rydberg (6):
> =A0hid: Add device group to modalias
> =A0hid: Scan the device for group info before adding it
> =A0hid: Allow bus wildcard matching
> =A0hid: Create a generic device group
> =A0hid-multitouch: Switch to device groups
> =A0hid: Create a common generic driver
>
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +++
> =A0drivers/hid/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 =A0 =A0| =A0172 +++++++++++++++=
+++++-------------------
> =A0drivers/hid/hid-generic.c =A0 =A0 =A0 | =A0 53 ++++++++++++
> =A0drivers/hid/hid-input.c =A0 =A0 =A0 =A0 | =A0 11 ---
> =A0drivers/hid/hid-multitouch.c =A0 =A0| =A0 =A03 +-
> =A0drivers/hid/usbhid/hid-core.c =A0 | =A0 16 ----
> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20 +++--
> =A0include/linux/mod_devicetable.h | =A0 =A04 +-
> =A0net/bluetooth/hidp/core.c =A0 =A0 =A0 | =A0 27 +-----
> =A0scripts/mod/file2alias.c =A0 =A0 =A0 =A0| =A0 =A05 +-
> =A011 files changed, 180 insertions(+), 145 deletions(-)
> =A0create mode 100644 drivers/hid/hid-generic.c
>
> --
> 1.7.10
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
