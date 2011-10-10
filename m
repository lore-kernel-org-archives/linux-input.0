From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 16:06:37 +0200
Message-ID: <201110101606.37878.oneukum@suse.de>
References: <1318254086-22752-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36947 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab1JJOGU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:06:20 -0400
In-Reply-To: <1318254086-22752-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, dtor@mail.ru

Am Montag, 10. Oktober 2011, 15:41:26 schrieb Matthew Garrett:
> The bcm5974 code takes a USB autosuspend reference on device open and
> releases it on device close. This means that the hardware won't sleep when
> anything holds it open. This is sensible for input devices that don't
> support remote wakeups on normal use (like most mice), but this hardware
> trigger wakeups on touch and so can suspend transparently to the user. Doing
> so allows the USB host controller to sleep when the machine is idle, giving
> measurable power savings.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> 
> Got rid of the unbalanced put on the close path, and added usb_mark_last_busy()
> calls to make sure the device doesn't go to sleep while in use. This works fine
> on my hardware now, and I don't see any warning messages being generated.

This is odd, because the hardware shouldn't generate remote wakeups unless you
request them, like this (usbhid)

int usbhid_open(struct hid_device *hid)
{
        struct usbhid_device *usbhid = hid->driver_data;
        int res;

        mutex_lock(&hid_open_mut);
        if (!hid->open++) {
                res = usb_autopm_get_interface(usbhid->intf);
                /* the device must be awake to reliably request remote wakeup */
                if (res < 0) {
                        hid->open--;
                        mutex_unlock(&hid_open_mut);
                        return -EIO;
                }
                usbhid->intf->needs_remote_wakeup = 1;

	Regards
		Oliver
