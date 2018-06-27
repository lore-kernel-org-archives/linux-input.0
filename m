From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v3 01/12] input: add MT_TOOL_DIAL
Date: Wed, 27 Jun 2018 10:54:08 +1000
Message-ID: <20180627005408.GA25847@jelly>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-2-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621120908.16706-2-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 21, 2018 at 02:08:57PM +0200, Benjamin Tissoires wrote:
> A dial is a tool you place on a multitouch surface which reports its
> orientation or a relative angle of rotation when rotating its knob.
> 
> Some examples are the Dell Totem (on the Canvas 27"), the Microsoft Dial,
> or the Griffin Powermate, though the later can't be put on a touch surface.
> 
> We give some extra space to account for other types of fingers if we need
> (MT_TOOL_THUMB)
> 
> Slightly change the documentation to not make it mandatory to update each
> MT_TOOL we add.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v2 (extracted from previous series in its own patch)
> 
> changes in v3:
> - re-insert the change in include/uapi/linux/input.h
> ---
>  Documentation/input/multi-touch-protocol.rst | 12 ++++++------
>  include/uapi/linux/input.h                   |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
> index b51751a0cd5d..6be70342e709 100644
> --- a/Documentation/input/multi-touch-protocol.rst
> +++ b/Documentation/input/multi-touch-protocol.rst
> @@ -310,12 +310,12 @@ ABS_MT_TOOL_Y
>  ABS_MT_TOOL_TYPE
>      The type of approaching tool. A lot of kernel drivers cannot distinguish
>      between different tool types, such as a finger or a pen. In such cases, the
> -    event should be omitted. The protocol currently supports MT_TOOL_FINGER,
> -    MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_. For type B devices, this event is
> -    handled by input core; drivers should instead use
> -    input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may change over
> -    time while still touching the device, because the firmware may not be able
> -    to determine which tool is being used when it first appears.
> +    event should be omitted. The protocol currently mainly supports
> +    MT_TOOL_FINGER, MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_.
> +    For type B devices, this event is handled by input core; drivers should
> +    instead use input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may
> +    change over time while still touching the device, because the firmware may
> +    not be able to determine which tool is being used when it first appears.
>  
>  ABS_MT_BLOB_ID
>      The BLOB_ID groups several packets together into one arbitrarily shaped
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 7288a7c573cc..e931b0468b6d 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -273,7 +273,8 @@ struct input_mask {
>  #define MT_TOOL_FINGER		0
>  #define MT_TOOL_PEN		1
>  #define MT_TOOL_PALM		2
> -#define MT_TOOL_MAX		2
> +#define MT_TOOL_DIAL		10
> +#define MT_TOOL_MAX		10

sorry for the late comment here: I'd prefer MAX to be greater than the 
actually used highest value. This isn't strictly technically necessary
because tools *should* be able to deal with FOO == MAX but there are some
corner-cases that get more quirky. e.g. converting the string "SW_MAX" to
value is 0xf, but 0xf to name is "SW_PEN_INSERTED". Compare that to
"REL_MAX" -> 0xf -> "REL_MAX".

I know this case needs to be handled etc but not having max as an already
used value papers over some of the quirks needed.

Either way, Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

>  
>  /*
>   * Values describing the status of a force-feedback effect
> -- 
> 2.14.3
> 
