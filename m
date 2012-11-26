From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Mon, 26 Nov 2012 18:56:27 +0100
Message-ID: <20121126185627.7bff1f84@neptune.home>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:37245 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab2KZSHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 13:07:22 -0500
In-Reply-To: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Andrew,

[CCing David Herrmann]


On Sun, 25 November 2012 Andrew de los Reyes wrote:
> Benjamin Tissoires and Nestor Lopez Casado have been helping me to add
> Linux support for new Logitech Touch Mice (T620, T400). After running
> into a road-block in hid-core, and solving it with this patch, we
> thought it was good to show the community and see if this is okay, or
> if there's a better solution that we've missed.
> 
> Thanks for your comments,
> -andrew
> 
> This patch separates struct hid_device's driver_lock into two. The
> goal is to allow hid device drivers to receive input during their
> probe() function call. This is necessary because some drivers need to
> communicate with the device to determine parameters needed during
> probe (e.g., size of a multi-touch surface).
> 
> Historically, three functions used driver_lock:
> 
> - hid_device_probe: blocks to acquire lock
> - hid_device_remove: blocks to acquire lock
> - hid_input_report: if locked returns -EBUSY, else acquires lock
> 
> This patch adds another lock (driver_input_lock) which is used to
> block input from occurring. The lock behavior is now:
> 
> - hid_device_probe: blocks to acq. driver_lock, then driver_input_lock
> - hid_device_remove: blocks to acq. driver_lock, then driver_input_lock
> - hid_input_report: if driver_input_lock locked returns -EBUSY, else
>   acquires driver_input_lock
> 
> This results in no behavior change for existing devices and
> drivers. However, during a probe() function call in a driver, that
> driver may now selectively unlock driver_input_lock to let input
> events come through, then re-lock.

That is more or less a new approach to release the restriction added in
commit 4ea5454203d991ec85264f64f89ca8855fce69b0
(HID: Fix race condition between driver core and ll-driver).

>From your suggested change the question could be if releasing the input
lock should be connected to hw_start() / hw_stop() calls...

Though connecting those together would certainly require some review of
existing drivers in order not to reopen the can of worms closed by above
mentioned commit.

Bruno
