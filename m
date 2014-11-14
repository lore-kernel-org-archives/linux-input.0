From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Fri, 14 Nov 2014 10:08:30 +0100
Message-ID: <1415956110.2640.5.camel@linux-0dmf.site>
References: <1415909806-23848-1-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415909806-23848-1-git-send-email-bleung@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: johan@kernel.org, jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, snanda@chromium.org
List-Id: linux-input@vger.kernel.org

On Thu, 2014-11-13 at 12:16 -0800, Benson Leung wrote:

> In usbhid_open, usb_autopm_get_interface is called
> before setting the needs_remote_wakeup flag, and
> usb_autopm_put_interface is called after hid_start_in.
> 
> However, when the device is closed in usbhid_close, the same
> protection isn't there when clearing needs_remote_wakeup. This will
> add that to usbhid_close as well as usbhid_stop.

Interesting, but this has the side effect of waking devices
that are asleep just to remove the flag.

	Regards
		Oliver

-- 
Oliver Neukum <oneukum@suse.de>
