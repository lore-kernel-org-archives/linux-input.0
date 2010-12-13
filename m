From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 1/2] hid-mosart: ignore buttons report
Date: Mon, 13 Dec 2010 09:51:23 -0800
Message-ID: <4D065D1B.7060504@canonical.com>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr> <1292252353-3029-2-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:33925 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758575Ab0LMRvf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 12:51:35 -0500
In-Reply-To: <1292252353-3029-2-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On 12/13/2010 06:59 AM, Benjamin Tissoires wrote:
> This commit allows the device to be recognized as a touchscreen, and not a
> touchpad by xf86-input-evdev.
> 
> The device has 2 modes. The first one is an emulation of a touchscreen by
> sending left and right button, and the second mode is the one used in
> dual-touch (sending trackingID, touch and else).
> 
> That's why there is a hid report containing left and right buttons
> (9000001 and 9000002). The point is that xorg relies on these fields to
> determine if it's a touchpad or a touchscreen.
> Clearing the report (return -1) makes xorg detecting it out of the box
> as a quite pleasant (dual)touchscreen.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Acked-by: Chase Douglas <chase.douglas@canonical.com>

Please add "Cc: stable@kernel.org" to the SOB area so this is picked up
for previous kernels too.

Thanks!

-- Chase
