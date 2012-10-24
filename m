From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Support Elan Touchscreen eKTF product.
Date: Wed, 24 Oct 2012 11:13:23 -0700
Message-ID: <20121024181323.GA18122@core.coreip.homeip.net>
References: <1351042903-27538-1-git-send-email-scott.liu@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351042903-27538-1-git-send-email-scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jesse <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Vincent Wang <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Paul <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Scott,

On Wed, Oct 24, 2012 at 09:41:43AM +0800, Scott Liu wrote:
> This patch is for Elan eKTF Touchscreen product, I2C adpater module.
> 
> Signed-off-by: Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
> ---
> 
> Hi,
>         v2 revision I have fixed some bug as your advise.
>         1. To target the mainline
>         2. No Android dependency
>         3. reuse those duplication code from Henrik's patchset.
>                 (input_mt_sync_frame()  / input_mt_get_slot_by_key())

Just a quick run through the code, so:

- please remove polling support, it is not useful in production;
- why do you need a separate probe work instead of doing what you
  need in elants_probe()
- it is not a good idea to register input device first and then
  allocating memory for MT handling.
- I do not understand why kfifo is needed
- please remove the rest of the custom threads
- you do not need to call input_mt_destroy_slots() explicitly
- use request_firmware() instead of special character device to upload
  firmware.
- please use standard kernel-doc markup.
- consider what attributes are there only for debugging and move them to
  debugfs.
- I find the use of enums in this driver quite unconventional, just
  standard #defines would probably be more straightforward.

Thanks.

-- 
Dmitry
