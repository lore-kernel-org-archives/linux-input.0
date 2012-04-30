From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 5/6] hid-multitouch: Switch to device groups
Date: Mon, 30 Apr 2012 20:30:23 +0200
Message-ID: <20120430183023.GA5585@polaris.bitmath.org>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
 <1335175627-2270-6-git-send-email-rydberg@euromail.se>
 <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:60080 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab2D3S0C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 14:26:02 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <Benjamin_Tissoires@logitech.com>, Stephane Chatty <chatty@enac.fr>

> I remarked a small regression in this patch: the detection of the
> serial protocol is not handled anymore. I was indeed relying on the
> fact that the parameter "id" in mt_probe was null to know that the
> device was not already in the list of known devices.

I see. Will this suffice?

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 125c1e7..507981e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -673,8 +673,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
        if (ret)
                goto fail;
 
-       if (!id && td->touches_by_report == 1) {
-               /* the device has been sent by hid-generic */
+       /* unknown serial devices need special quirks */
+       if ((!id || id->product == HID_ANY_ID) && td->touches_by_report == 1) {
                mtclass = &td->mtclass;
                mtclass->quirks |= MT_QUIRK_ALWAYS_VALID;
                mtclass->quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;

Cheers,
Henrik
