From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: reserve 2 events code because of HID
Date: Thu, 4 Oct 2018 12:01:19 -0700
Message-ID: <20181004190119.GB233675@dtor-ws>
References: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2018 at 02:34:30PM +0200, Benjamin Tissoires wrote:
> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MT_SLOT-1 (ABS_MISC+6) was never assigned a code, and
> so libinput can detect fake multitouch devices from genuine ones by
> checking if ABS_MT_SLOT-1 is set.
> 
> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+6 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Dmitry, I did not take your Acked-by, as I added 2 new events and wanted to
> be sure you are still OK.

Yes, this is still fine.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Jiri, this will still need to go through your tree, as the input-event-codes
> changes that introduce REL_WHEEL_HI_RES are in your for-4.20/logitech-highres.
> 
> Cheers,
> Benjamin
> 
>  include/uapi/linux/input-event-codes.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 29fb891ea337..b5e0e9856c47 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,7 +708,15 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> -#define REL_WHEEL_HI_RES	0x0a
> +/*
> + * 0x0a is reserved and should not be used in input drivers.
> + * It was used by HID as REL_MISC+1 and userspace needs to detect if
> + * the next REL_* event is correct or is just REL_MISC + n.
> + * We define here REL_RESERVED so userspace can rely on it and detect
> + * the situation described above.
> + */
> +#define REL_RESERVED		0x0a
> +#define REL_WHEEL_HI_RES	0x0b
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> @@ -745,6 +753,15 @@
>  
>  #define ABS_MISC		0x28
>  
> +/*
> + * 0x2e is reserved and should not be used in input drivers.
> + * It was used by HID as ABS_MISC+6 and userspace needs to detect if
> + * the next ABS_* event is correct or is just ABS_MISC + n.
> + * We define here ABS_RESERVED so userspace can rely on it and detect
> + * the situation described above.
> + */
> +#define ABS_RESERVED		0x2e
> +
>  #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
> -- 
> 2.14.3
> 

-- 
Dmitry
