From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH v3 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 24 Nov 2015 15:34:01 +0100
Message-ID: <CANsc=4V0my49VZ8cGj0_X+wmXqiW4X8yHzcWH11LEiLvBBWq3w@mail.gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
	<1448372948-8861-1-git-send-email-adrienverge@gmail.com>
	<1448372948-8861-3-git-send-email-adrienverge@gmail.com>
	<CAN+gG=Fb0GD0K0pyiJ6bbK82-fa+xYhWKSjhH-DYp2BH3h2iDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33783 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbKXOeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 09:34:02 -0500
In-Reply-To: <CAN+gG=Fb0GD0K0pyiJ6bbK82-fa+xYhWKSjhH-DYp2BH3h2iDg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

2015-11-24 15:11 GMT+01:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:

> Instead of adding a second table, I'd rather have a match on
> HID_ANY_ID for the product ID.

Thanks Benjamin, the way you propose is much cleaner. (I actually
looked for such a *wildcard* product id, but apparently didn't looked
deep enough!)
