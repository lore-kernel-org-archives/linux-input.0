From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Commit c64f6f934c7490faff76faf96217066a1b3570a0 breaks my MosArt
 touchscreen
Date: Wed, 9 Mar 2011 13:28:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103091321080.19969@pobox.suse.cz>
References: <AANLkTinngODj8K0feoJdwoq7T0RX9vbhJazf_9WNbTGB@mail.gmail.com> <AANLkTinuDb8Yreiw+H3E1D-W5S0BSstbi6OGYOUgn3z+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33653 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209Ab1CIM2u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 07:28:50 -0500
In-Reply-To: <AANLkTinuDb8Yreiw+H3E1D-W5S0BSstbi6OGYOUgn3z+@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: James Sharam <james.sharam@googlemail.com>, Greg KH <gregkh@suse.de>, linux-input <linux-input@vger.kernel.org>, stable@kernel.org

On Wed, 9 Mar 2011, Benjamin Tissoires wrote:

> Ouch, sorry for that. In fact, hid-mosart is buggy since its creation
> for the relative/absolute behavior you are observing.
> A patch corrects this and has been included in 2.6.38, but it has not
> been backported to 2.6.37.
> The name of the patch is "HID: hid-mosart: ignore buttons report".
> 
> Jiri, Greg, do you think we can include this in the stable queue?

Absolutely. Adding stable@kernel.org to CC: and inlcuding the patch below.



[ upstream commit ad6d42670279d ]

From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH] HID: hid-mosart: ignore buttons report

This commit allows the device to be recognized as a touchscreen, and not a
touchpad by xf86-input-evdev.

The device has 2 modes. The first one is an emulation of a touchscreen by
sending left and right button, and the second mode is the one used in
dual-touch (sending trackingID, touch and else).

That's why there is a hid report containing left and right buttons
(9000001 and 9000002). The point is that xorg relies on these fields to
determine if it's a touchpad or a touchscreen.
Clearing the report (return -1) makes xorg detecting it out of the box
as a quite pleasant (dual)touchscreen.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Acked-by: Chase Douglas <chase.douglas@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-mosart.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-mosart.c b/drivers/hid/hid-mosart.c
index ac5421d..acd8a49 100644
--- a/drivers/hid/hid-mosart.c
+++ b/drivers/hid/hid-mosart.c
@@ -90,6 +90,10 @@ static int mosart_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case 0xff000000:
 		/* ignore HID features */
 		return -1;
+
+	case HID_UP_BUTTON:
+		/* ignore buttons */
+		return -1;
 	}
 
 	return 0;
-- 
1.7.3.1

