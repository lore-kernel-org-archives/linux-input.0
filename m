From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Thu, 8 Oct 2015 12:40:57 +0300
Message-ID: <20151008094057.GN1506@lahna.fi.intel.com>
References: <alpine.LNX.2.00.1510061606440.2758@pobox.suse.cz>
 <1444221223-33481-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151007133409.GA25728@mail.corp.redhat.com>
 <20151007155620.GB118995@ubuntu-hedt>
 <5615C30A.5060503@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40769 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbbJHJlG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Oct 2015 05:41:06 -0400
Content-Disposition: inline
In-Reply-To: <5615C30A.5060503@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Seth Forshee <seth.forshee@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 07, 2015 at 06:12:42PM -0700, Andrew Duggan wrote:
> I can confirm that it is working on the Dell XPS 13 and the buttonpad
> property is set correctly. However, I also tried it on an older non
> production precision touchpad and it didn't work. It reports that it fails
> to fetch feature 8 and then doesn't report any input. I'm concerned that
> some of the early PTPs in some Dell and Acer systems might not work with
> this change. I'll test this tomorrow on a few more systems to see if the
> problem is isolated to just this one non production touchpad.

Thanks for testing.

> [ 2969.222125] usb 1-1: New USB device found, idVendor=06cb, idProduct=2393
> [ 2969.222128] usb 1-1: New USB device strings: Mfr=0, Product=2,
> SerialNumber=0
> [ 2969.222130] usb 1-1: Product: Synaptics T Pad V 01.31
> [ 2974.223578] hid-multitouch 0003:06CB:2393.0008: failed to fetch feature 8
> [ 2979.226037] hid-multitouch 0003:06CB:2393.0008: failed to fetch feature 8
> [ 2979.226137] input: Synaptics T Pad V 01.31 UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:06CB:2393.0008/input/input34
> [ 2979.226431] hid-multitouch 0003:06CB:2393.0008: input,hiddev0,hidraw2:
> USB HID v1.11 Mouse [Synaptics T Pad V 01.31] on usb-0000:00:14.0-1/input0

Without the patch is it successfully retrieving feature 8?

It may be that it has HID_QUIRK_NO_INIT_REPORTS set via quirks in usbhid
which causes the driver to fetch the report in mt_feature_mapping() and
previously it did not do that.
