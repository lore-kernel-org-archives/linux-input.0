From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 11/11] HID: hid-multitouch: get rid of usbhid
 depedency for general path
Date: Mon, 5 Nov 2012 13:57:31 +0100
Message-ID: <20121105125731.GA814@polaris.bitmath.org>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
 <1351241067-9521-12-git-send-email-benjamin.tissoires@gmail.com>
 <20121029225748.GA15632@polaris.bitmath.org>
 <CAN+gG=GNucfg4-wCBZQtz0yJDjpTD_56Js3d68nm8VFi1UhZAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:33462 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab2KEMwI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 07:52:08 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=GNucfg4-wCBZQtz0yJDjpTD_56Js3d68nm8VFi1UhZAA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> >> This patch factorizes the hid set_feature command by using
> >> hid_device->hid_output_raw_report instead of direclty relying on
> >> usbhid. This makes the driver usb independant.
> >>
> >> However I still can't remove the 2 usb related headers because the
> >> function mt_resume has a specific patch for usb devices.
> >>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> >> ---
> >>  drivers/hid/hid-multitouch.c | 63 ++++++++++++++++++++++++++------------------
> >>  1 file changed, 37 insertions(+), 26 deletions(-)
> >
> > In my drawer, I have a patchset that aims to remove all usbhid
> > dependence, from all the drivers. Perhaps the attached patch is
> > something to consider here?
> 
> yep, removing usbhid dependencies is a good thing.
> See my review below :)

I have a tentative patch taking your comments into account, and it is
likely that we want to go that way. However, as to not hold up your
patchset, perhaps we could do without it for now.

Regarding the hardwired usbhid dependency, I think the solution is to
move that code to usbhid itself.

Thanks,
Henrik
