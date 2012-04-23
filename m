From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 0/6] hid: Introduce device groups
Date: Mon, 23 Apr 2012 12:51:27 +0200
Message-ID: <CAN+gG=GJFNgFHqn9O8e+5MoVWRLRJB8a=r2OuUNuEtomqTjQRQ@mail.gmail.com>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58892 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab2DWKva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 06:51:30 -0400
In-Reply-To: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Henrik,

Thanks for handling this. I still won't have the time to review this
patch set before early may as I'm out of my office till then. Also
sorry for not answering the previous mails, I did not had a reliable
internet connection during my holidays.

Thanks,
Benjamin

Le 23 avr. 2012 12:03, "Henrik Rydberg" <rydberg@euromail.se> a =E9crit=
 :
>
> Hi Jiri.
>
> Here is the third version of the extension to the device-driver
> matching mechanism. AFAICT, there are no outstanding issues. I think
> we are getting close. :-)
>
> Building on the report fixup patches, this patchset brings a bit of
> transparency to the hid bus, by the addition of device groups.  This
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
>  hid: Add device group to modalias
>  hid: Scan the device for group info before adding it
>  hid: Allow bus wildcard matching
>  hid: Create a generic device group
>  hid-multitouch: Switch to device groups
>  hid: Create a common generic driver
>
>  drivers/hid/Kconfig             |   12 +++
>  drivers/hid/Makefile            |    2 +
>  drivers/hid/hid-core.c          |  172 ++++++++++++++++++++---------=
----------
>  drivers/hid/hid-generic.c       |   53 ++++++++++++
>  drivers/hid/hid-input.c         |   11 ---
>  drivers/hid/hid-multitouch.c    |    3 +-
>  drivers/hid/usbhid/hid-core.c   |   16 ----
>  include/linux/hid.h             |   20 +++--
>  include/linux/mod_devicetable.h |    4 +-
>  net/bluetooth/hidp/core.c       |   27 +-----
>  scripts/mod/file2alias.c        |    5 +-
>  11 files changed, 180 insertions(+), 145 deletions(-)
>  create mode 100644 drivers/hid/hid-generic.c
>
> --
> 1.7.10
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
