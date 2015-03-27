From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: quirk ALWAYS_POLL needed with an unexpectedly high number of mice
Date: Fri, 27 Mar 2015 09:18:11 -0400
Message-ID: <CAN+gG=FMXPmFGqdF8QR-0iSV3Y5tHr4GgfHLWPPqiZ6FStu8Pg@mail.gmail.com>
References: <1427448571.5783.41.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34754 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbC0NSM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 09:18:12 -0400
Received: by qgep97 with SMTP id p97so132770165qge.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 06:18:11 -0700 (PDT)
In-Reply-To: <1427448571.5783.41.camel@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Johan Hovold <johan@kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, jdelvare@suse.com

On Fri, Mar 27, 2015 at 5:29 AM, Oliver Neukum <oneukum@suse.de> wrote:
> Hi,
>
> I am getting reports from a customer running an unintentional
> stress test for this quirk. I would have to add a dozen mice
> in the medium term. Is that desirable?
> Should we make the quirk the default? Or add a module parameter
> to let the pessimistic users with multiple desktop rodents
> select the quirk as default? Or just carry on?
> Comments?
>

usbhid/hid-core.c already sets HID_QUIRK_NOGET for regular mice/keyboards [1].
Maybe adding ALLWAYS_POLL to those would make sense and solve your problem?

BTW I am against having this quirk as the general default because we
rely on the usb autosuspend to shut off the touchscreens when no one
listen to them, and the touchscreens are draining a lot of power.

Cheers,
Benjamin

[1] https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/tree/drivers/hid/usbhid/hid-core.c#n988
