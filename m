From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 5/6] hid-multitouch: Switch to device groups
Date: Tue, 1 May 2012 08:35:48 +0200
Message-ID: <20120501063548.GA2154@polaris.bitmath.org>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
 <1335175627-2270-6-git-send-email-rydberg@euromail.se>
 <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
 <20120430183023.GA5585@polaris.bitmath.org>
 <CAN+gG=Ekz8HMBP0ZOSts5ek9x38FW7v177K-p-kVBvCCkh6kOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:56584 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab2EAGbX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 May 2012 02:31:23 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=Ekz8HMBP0ZOSts5ek9x38FW7v177K-p-kVBvCCkh6kOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <Benjamin_Tissoires@logitech.com>, Stephane Chatty <chatty@enac.fr>

On Mon, Apr 30, 2012 at 08:51:28PM +0200, Benjamin Tissoires wrote:
> On Mon, Apr 30, 2012 at 20:30, Henrik Rydberg <rydberg@euromail.se> wrote:
> >> I remarked a small regression in this patch: the detection of the
> >> serial protocol is not handled anymore. I was indeed relying on the
> >> fact that the parameter "id" in mt_probe was null to know that the
> >> device was not already in the list of known devices.
> >
> > I see. Will this suffice?
> 
> Yes, but I'd rather do the test against either id->product or
> id->driver_data as we may use HID_ANY_ID for vendors specific
> handling. For instance, I had the confirmation from EETI (eGalax) that
> they will always use the same protocol for their usb products, thus
> the same quirks could be handled by HID_DEVICE(BUS_USB,
> HID_GROUP_MULTITOUCH, USB_VENDOR_ID_DWAV, HID_ANY_ID).

Sounds good. I am sending out a fourth version of the patch which will
enable this possibility as well.

On a different note, I wonder why the various slot allocations, sysfs
entries and post-parse settings are done after the device has been
started?

Thanks for testing,
Henrik
