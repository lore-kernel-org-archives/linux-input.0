From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 6/6] HID: uclogic: actually invert the in-range bit
 for huion tablets only
Date: Mon, 2 Mar 2015 17:25:40 -0500
Message-ID: <20150302222540.GA19116@mail.corp.redhat.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424977049-18648-7-git-send-email-benjamin.tissoires@redhat.com>
 <54F1C9BD.2070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbbCBWZy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2015 17:25:54 -0500
Content-Disposition: inline
In-Reply-To: <54F1C9BD.2070805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Feb 28 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/26/2015 08:57 PM, Benjamin Tissoires wrote:
> >This hack is only needed for Huion tablets. It does not seem to have
> >any effect on the other tablets handled by this device right now, but
> >it's better to check for the product id sooner than discovering that
> >we have messed up one tablet later.
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >---
> >
> >New in v2
> >
> >  drivers/hid/hid-uclogic.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> >index f44e72b..5f5c16e 100644
> >--- a/drivers/hid/hid-uclogic.c
> >+++ b/drivers/hid/hid-uclogic.c
> >@@ -930,7 +930,8 @@ static int uclogic_raw_event(struct hid_device *hdev, struct hid_report *report,
> >  	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> >
> >  	/* If this is a pen input report */
> >-	if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
> >+	if (hdev->product == USB_DEVICE_ID_HUION_TABLET &&
> >+	    intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
> >  	    report->type == HID_INPUT_REPORT &&
> >  	    report->id == 0x07 && size >= 2)
> >  		/* Invert the in-range bit */
> 
> Right, I completely forgot about this. That's why it's important to put these
> things out for testing.

yes, and no. A thorough review can help detect these while it's a pain
to ask each and every users to test every possible device :)

> 
> However, this should be inverted not just for Huion tablets, but rather for
> all "enabled" tablets. The UC-Logic TWHA60 v3 inverts that bit as well when
> enabled, IIRC. We can filter enabled tablets by drvdata->rdesc != NULL, or add
> an explicit flag.

I like the flag. It will remove the dependency to usb in raw_event()
which is always a plus.

Speaking of which. I started looking at these dependencies in the hid
subtree (like every year, in spring, these dependencies itches me).
I think we can find a preventive solution which would allow to reinject
through uhid any device even if the driver wants to talk to the usb
layer. This will require some more effort on my side but will allow us
to have at least some regressions tests in hid-uclogic too.

Cheers,
Benjamin

