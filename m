From: Bernhard Seibold <mail@bernhard-seibold.de>
Subject: Re: [PATCH] HID: Driver for Lenovo Keyboard w/ Trackpoint
Date: Mon, 13 Jun 2011 16:15:05 +0200
Message-ID: <20110613161505.2d402c62@bernhard-seibold.de>
References: <1306512263-8796-1-git-send-email-mail@bernhard-seibold.de>
	<alpine.LNX.2.00.1106131521550.22872@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mcp.e404.de ([78.47.239.181]:45918 "EHLO mcp.e404.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab1FMOPI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 10:15:08 -0400
In-Reply-To: <alpine.LNX.2.00.1106131521550.22872@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Mon, 13 Jun 2011 15:24:58 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Fri, 27 May 2011, Bernhard Seibold wrote:
> 
> > This patch adds support for setting the trackpoint sensitivity
> > of the "Lenovo ThinkPad USB Keyboard with Trackpoint".
> 
> As you are adding sysfs attribute, we'd like to have it documented as
> well Documentation/ABI somewhere.
>

Will do. Is there a generic way to make this setting available in
XInput? I feel this should show up as a device property when doing
something along the lines of "xinput list-props <DEV-ID>".

> 
> Why is this empty stub needed?

That's an oversight. I added support for microphone mute key here, but
removed it for patch submission since the patch adding KEY_MICMUTE
seems to be unapplied as of now (at least i didn't find any git tree
containing it)

The patch in question is:

[PATCH] Add KEY_MICMUTE and enable it on Lenovo X220
http://www.spinics.net/lists/linux-input/msg15394.html

> > +static ssize_t pointer_sensitivity_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	struct hid_device *hdev;
> > +	struct hid_report *report;
> > +	hdev = container_of(dev, struct hid_device, dev);
> > +
> > +	if (hdev == NULL)
> > +		return -ENODEV;
> > +
> > +	report =
> > hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
> > +	usbhid_submit_report(hdev, report, USB_DIR_IN);
> > +	usbhid_wait_io(hdev);
> 
> usbhid_wait_io() returns -1 in case it times out.
>

Whats the correct way to handle this? Since I'm a kernel-newbie I used
hid-ntrig.c among others as "inspiration" and there the return value
isn't checked either.

Frankly I'm not sure if the wait_io is necessary at all.

> > +static ssize_t pointer_sensitivity_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf,
> > +		size_t count)
> > +{
> > +	struct hid_device *hdev;
> > +	struct hid_report *report;
> > +	int value;
> > +
> > +	if (kstrtoint(buf, 10, &value) || value < 1 || value > 255)
> > +		return -EINVAL;
> > +
> > +	hdev = container_of(dev, struct hid_device, dev);
> > +	if (hdev == NULL)
> > +		return -ENODEV;
> > +
> > +	report =
> > hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
> > +	usbhid_submit_report(hdev, report, USB_DIR_IN);
> > +	usbhid_wait_io(hdev);
> 
> The same here.
> 
> Thanks,
> 

Thanks for your comments.

Should I just include KEY_MICMUTE in my patch or wait for that other
patch to show up somewhere in git before posting an updated version?

