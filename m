From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 01/25] HID: break out hid_extract_field
Date: Mon, 28 Jan 2013 16:04:29 +0100
Message-ID: <20130128150429.GA3465@polaris.bitmath.org>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
 <1359120190-18281-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359120190-18281-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> Breaking out this function allows third parties hid drivers to retrieve
> the data fields of a hid report in the raw_event callback.
> 
> No functional changes, only exports the function.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-core.c | 60 ++++++++++++++++++++++++++++++++++----------------
>  include/linux/hid.h    |  1 +
>  2 files changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5ae2cb1..ea478f5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -962,6 +962,45 @@ static void implement(const struct hid_device *hid, __u8 *report,
>  }
>  
>  /*
> + * Extract and allocate a data field from a little endian report (bit array).
> + */
> +
> +s32 *hid_extract_field(const struct hid_device *hid, struct hid_field *field,
> +		       __u8 *data)
> +{
> +	unsigned n;
> +	unsigned count = field->report_count;
> +	unsigned offset = field->report_offset;
> +	unsigned size = field->report_size;
> +	__s32 min = field->logical_minimum;
> +	__s32 max = field->logical_maximum;
> +	__s32 *value;
> +
> +	value = kmalloc(sizeof(__s32) * count, GFP_ATOMIC);
> +	if (!value)
> +		return value;
> +
> +	for (n = 0; n < count; n++) {
> +
> +		value[n] = min < 0 ?
> +			snto32(extract(hid, data, offset + n * size, size),
> +			       size) :
> +			extract(hid, data, offset + n * size, size);
> +
> +		/* Ignore report if ErrorRollOver */
> +		if (!(field->flags & HID_MAIN_ITEM_VARIABLE) &&
> +		    value[n] >= min && value[n] <= max &&
> +		    field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1) {
> +			kfree(value);
> +			return NULL;
> +		}
> +	}
> +
> +	return value;
> +}
> +EXPORT_SYMBOL_GPL(hid_extract_field);
> +

I would rather see the extensive use of malloc go away than extend its
usage to drivers.

Thanks,
Henrik
