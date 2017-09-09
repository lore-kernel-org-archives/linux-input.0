From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Sat, 09 Sep 2017 09:35:52 +0200
Message-ID: <1504942552.10395.2.camel@suse.com>
References: <20170908174337.GA13616@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55273 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751548AbdIIHjL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 9 Sep 2017 03:39:11 -0400
In-Reply-To: <20170908174337.GA13616@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Am Freitag, den 08.09.2017, 10:43 -0700 schrieb Dmitry Torokhov:
> From: Benson Leung <bleung@chromium.org>
> 
> usbhid->intf->needs_remote_wakeup is set when a device is opened, and is
> cleared when a device is closed.
> 
> In usbhid_open, usb_autopm_get_interface is called before setting the
> needs_remote_wakeup flag, and usb_autopm_put_interface is called after
> hid_start_in. However, when the device is closed in usbhid_close, we
> simply reset the flag and the device stays awake even though it could be
> suspended.

Hi,

but if the device is asleep, we do not want to wake it just to reset
the flag. Please use the no resume varieties. They did not exist when this
code was written and that is the reason behind the current code.

As it is your patch does more harm than good.

	Regards
		Oliver

