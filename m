From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Thu, 15 Dec 2011 10:01:52 +0100
Message-ID: <201112151001.52761.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <201112141222.41006.oneukum@suse.de> <CAGS+omB8kmALYg+m__WpiGzcpTdFEzHz1x3gFFkyqofpnANvNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omB8kmALYg+m__WpiGzcpTdFEzHz1x3gFFkyqofpnANvNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 15. Dezember 2011, 07:43:09 schrieb Daniel Kurtz:

Hi,

> I'm sorry, I'm not seeing how using a workqueue to set the LEDs
> changes anything with respect to how the driver deals with USB reset.

You are unfortunately right. This means that the driver currently is already
buggy.
 
> With or without a workqueue, LED control urbs are being queued and/or
> submitted asynchronously to reset.  AFAICT, the only thing that
> changes here is exactly when __usbhid_submit_report() is called.  In
> the original case, this happens directly in the input event handler.
> In the workqueue case, it happens in a system worker thread some short
> time after the input handler finishes.

The current driver kills the ctrl URB in cease_io() which is not enough
to prevent new IO.

> Could you please be more specific about what this patch breaks and
> perhaps give some guidance on how to fix it?

It breaks nothing. It just continues a bug and I assumed it was not present.
Basically the work queue must do nothing after pre_reset() and post_reset()
ought to rerun the work in case some request came down during that time.

	Regards
		Oliver
