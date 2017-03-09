From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/1] HID: clamp input to logical range if no null state
Date: Thu, 9 Mar 2017 09:16:06 +0100
Message-ID: <20170309081606.GA28052@mail.corp.redhat.com>
References: <20170308215211.24263-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170308215211.24263-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 08 2017 or thereabouts, Tomasz Kramkowski wrote:
> This patch fixes an issue in drivers/hid/hid-input.c where values
> outside of the logical range are not clamped when "null state" bit of
> the input control is not set.
> 
> This was discussed on the lists [1] and this change stems from the fact
> due to the ambiguity of the HID specification it might be appropriate to
> follow Microsoft's own interpretation of the specification. As noted in
> Microsoft's documentation [2] in the section titled "Required HID usages
> for digitizers" it is noted that values reported outside the logical
> range "will be considered as invalid data and the value will be changed
> to the nearest boundary value (logical min/max)."
> 
> This patch fixes an issue where the (1292:4745) Innomedia INNEX
> GENESIS/ATARI reports out of range values for its X and Y axis of the
> DPad which, due to the null state bit being unset, are forwarded to
> userspace as is. Now these values will get clamped to the logical range
> before being forwarded to userspace. This device was also used to test
> this patch.
> 
> This patch expands on commit 3f3752705dbd ("HID: reject input outside
> logical range only if null state is set").
> 
> [1]: http://lkml.kernel.org/r/20170307131036.GA853@gaia.local
> [2]: https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
> 
> Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
> ---
>  drivers/hid/hid-input.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index cf8256aac2bd..cf38ff79cfe9 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1157,12 +1157,15 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  	 * don't specify logical min and max.
>  	 */
>  	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
> -	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
>  	    (field->logical_minimum < field->logical_maximum) &&
>  	    (value < field->logical_minimum ||
>  	     value > field->logical_maximum)) {
> -		dbg_hid("Ignoring out-of-range value %x\n", value);
> -		return;
> +		if (field->flags & HID_MAIN_ITEM_NULL_STATE) {
> +			dbg_hid("Ignoring out-of-range value %x\n", value);
> +			return;
> +		}
> +		value = value < field->logical_minimum ?
> +			field->logical_minimum : field->logical_maximum;

We have a "clamp()" function in the kernel that does the job directly
and which is more readable. Also, this makes testing the out of range
values twice.

How about:

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cf8256a..781f400 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1150,19 +1150,26 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	/*
 	 * Ignore out-of-range values as per HID specification,
-	 * section 5.10 and 6.2.25.
+	 * section 5.10 and 6.2.25, when NULL state bit is present.
+	 * When it's not, clamp the value to match Microsoft's input
+	 * driver as mentioned in "Required HID usages for digitizers":
+	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
 	 *
 	 * The logical_minimum < logical_maximum check is done so that we
 	 * don't unintentionally discard values sent by devices which
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
-	    (field->logical_minimum < field->logical_maximum) &&
-	    (value < field->logical_minimum ||
-	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+	    (field->logical_minimum < field->logical_maximum)) {
+		if (!(field->flags & HID_MAIN_ITEM_NULL_STATE)) {
+			value = clamp(value,
+				      field->logical_minimum,
+				      field->logical_maximum);
+		} else if (value < field->logical_minimum ||
+			   value > field->logical_maximum) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
 	}
 
 	/*
---

Cheers,
Benjamin

>  	}
>  
>  	/*
> -- 
> 2.12.0
> 
