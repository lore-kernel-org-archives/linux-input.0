From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: reserve 2 events code because of HID
Date: Sat, 8 Sep 2018 11:44:42 +1000
Message-ID: <20180908014442.GA16029@jelly>
References: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 07, 2018 at 10:51:15AM +0200, Benjamin Tissoires wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MISC+1 was never assigned a code, and so libinput
> can detect fake multitouch devices from genuine ones by checking is
> ABS_MISC+1 is set.

sorry, this isn't quite correct. we use ABS_MT_SLOT - 1 (0x2e) for the
detection of fake MT devices, i.e.
  if (ABS_MT_SLOT and not ABS_MT_SLOT-1) then multitouch

That gives you up to ABS_MISC + 6 for legitimate usage. this is handled by
libevdev, not libinput directly. libevdev adjusts the various bits on "is
this device an MT device" based on whether ABS_MT_SLOT-1 is set.

I can change this to also check for (ABS_MISC and not ABS_MISC+1) but that
obviously will depend on updated libraries then. Though I guess it won't
really be an issue until we fill up the other codes up to including 0x2e
with real values and expect userspace to handle those.

None of the bits I maintain have special code for REL_MISC+n so that bit
works fine, IMO.

One request though: instead of just having the value reserved, can we make
it REL_RESERVED and ABS_RESERVED please? Or ABS_CANARY :) Much easier than
hardcoding the numeric value.

Cheers,
   Peter


> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+1 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> while reviewing my local tree, I realize that we might want to be able
> to differentiate older kernels from new ones that export REL_WHEEL_HI_RES.
> 
> I know Dmitry was against adding several REL_MISC, so I hope just moving
> REL_WHEEL_HI_RES by one and reserving the faulty event codes would be good
> this time.
> 
> This patch applies on top of the branch for-4.20/logitech-highres from
> Jiri's tree. It should go through Jiri's tree as well.
> 
> Cheers,
> Benjamin
> 
>  include/uapi/linux/input-event-codes.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 29fb891ea337..30149939249a 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,7 +708,12 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> -#define REL_WHEEL_HI_RES	0x0a
> +/*
> + * 0x0a is reserved and should not be used.
> + * It was used by HID as REL_MISC+1 and usersapce needs to detect if
> + * the next REL_* event is correct or is just REL_MISC + n.
> + */
> +#define REL_WHEEL_HI_RES	0x0b
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> @@ -745,6 +750,12 @@
>  
>  #define ABS_MISC		0x28
>  
> +/*
> + * 0x29 is reserved and should not be used.
> + * It was used by HID as ABS_MISC+1 and usersapce needs to detect if
> + * the next ABS_* event is correct or is just ABS_MISC + n.
> + */
> +
>  #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
> -- 
> 2.14.3
> 
