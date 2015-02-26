From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/4] HID: uclogic: present only the working interfaces on
 the Huion tablets
Date: Thu, 26 Feb 2015 12:02:47 -0500
Message-ID: <20150226170247.GA7092@mail.corp.redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424822730-14938-4-git-send-email-benjamin.tissoires@redhat.com>
 <54EE38F1.10202@gmail.com>
 <20150225213050.GD3097@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbbBZRDE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 12:03:04 -0500
Content-Disposition: inline
In-Reply-To: <20150225213050.GD3097@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Feb 25 2015 or thereabouts, Benjamin Tissoires wrote:
> On Feb 25 2015 or thereabouts, Nikolai Kondrashov wrote:
> > On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> > >The Huion tablets show 3 interfaces. Only the first and the third
> > >are currently used.
> > >Also remove HID_QUIRK_MULTI_INPUT for the third interface to not
> > >create more than needed input nodes.
> > >
> > >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >---
> > >  drivers/hid/hid-uclogic.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > >diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> > >index 397f1df..c03e076 100644
> > >--- a/drivers/hid/hid-uclogic.c
> > >+++ b/drivers/hid/hid-uclogic.c
> > >@@ -840,6 +840,11 @@ static int uclogic_probe(struct hid_device *hdev,
> > >  				hid_err(hdev, "tablet enabling failed\n");
> > >  				return rc;
> > >  			}
> > >+		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
> > >+			hdev->quirks &= ~HID_QUIRK_MULTI_INPUT;
> > >+		} else {
> > >+			/* Ignore all unused interfaces */
> > >+			return -ENODEV;
> > >  		}
> > >  		break;
> > >  	}
> > >
> > 
> > I would hesitate to remove the mouse interface as there are relatively fresh
> > UC-Logic tablets [1] out there which have a mouse, and which could respond to
> > the initialization. These mice are of questionable usefulness, true, but
> > leaving the interface enabled could make it easier for other people to
> > experiment with using this driver with their tablets.
> 
> OK, I will just remove the quirk for the mouse interface then.
> 

I ended up removing this patch in the series. Having
HID_QUIRK_MULTI_INPUT set allows a fine tuning of the names of the input
nodes so we can just enhance the list of suffix and get something
sensible for the users.

The only concern is that there will be a second "Pen" interface, but
that can be removed based on the PID (or fixed with a report descriptor).
I'll add an extra patch for that too.

Cheers,
Benjamin
