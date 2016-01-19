From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: fix out of bound access in extract and implement
Date: Tue, 19 Jan 2016 12:31:18 +0100
Message-ID: <20160119113118.GA20099@mail.corp.redhat.com>
References: <20160119064037.GA18052@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119064037.GA18052@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jan 18 2016 or thereabouts, Dmitry Torokhov wrote:
> extract() and implement() access buffer containing reports in 64-bit
> chunks, but there is no guarantee that buffers are padded to 64 bit
> boundary. In fact, KASAN has caught such OOB access with i2c-hid and
> Synaptics touch controller.
> 
> Instead of trying to hunt all parties that allocate buffers and make
> sure they are padded, let's switch extract() and implement() to byte
> access. It is a bit slower, bit we are not dealing with super fast
> devices here.
> 
> Also let's fix link to the HID spec while we are at it.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Dmitry!

Speaking about KASAN, I recently had a weird bug report for a Logitech
T650 which switched by itself back into the mouse emulation mode. I run
KASAN today and found a followup patch in hid_input_field() which
prevent some out of bound readings. I'll send this this afternoon.

Cheers,
Benjamin

> ---
>  drivers/hid/hid-core.c | 90 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9e182e4..9f1019d 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1075,7 +1075,7 @@ static u32 s32ton(__s32 value, unsigned n)
>   * Extract/implement a data field from/to a little endian report (bit array).
>   *
>   * Code sort-of follows HID spec:
> - *     http://www.usb.org/developers/devclass_docs/HID1_11.pdf
> + *     http://www.usb.org/developers/hidpage/HID1_11.pdf
>   *
>   * While the USB HID spec allows unlimited length bit fields in "report
>   * descriptors", most devices never use more than 16 bits.
> @@ -1083,20 +1083,37 @@ static u32 s32ton(__s32 value, unsigned n)
>   * Search linux-kernel and linux-usb-devel archives for "hid-core extract".
>   */
>  
> -__u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
> -		     unsigned offset, unsigned n)
> -{
> -	u64 x;
> +static u32 __extract(u8 *report, unsigned offset, int n)
> +{
> +	unsigned int idx = offset / 8;
> +	unsigned int bit_nr = 0;
> +	unsigned int bit_shift = offset % 8;
> +	int bits_to_copy = 8 - bit_shift;
> +	u32 value = 0;
> +	u32 mask = n < 32 ? (1U << n) - 1 : ~0U;
> +
> +	while (n > 0) {
> +		value |= ((u32)report[idx] >> bit_shift) << bit_nr;
> +		n -= bits_to_copy;
> +		bit_nr += bits_to_copy;
> +		bits_to_copy = 8;
> +		bit_shift = 0;
> +		idx++;
> +	}
> +
> +	return value & mask;
> +}
>  
> -	if (n > 32)
> +u32 hid_field_extract(const struct hid_device *hid, u8 *report,
> +			unsigned offset, unsigned n)
> +{
> +	if (n > 32) {
>  		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
>  			 n, current->comm);
> +		n = 32;
> +	}
>  
> -	report += offset >> 3;  /* adjust byte index */
> -	offset &= 7;            /* now only need bit offset into one byte */
> -	x = get_unaligned_le64(report);
> -	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
> -	return (u32) x;
> +	return __extract(report, offset, n);
>  }
>  EXPORT_SYMBOL_GPL(hid_field_extract);
>  
> @@ -1106,31 +1123,56 @@ EXPORT_SYMBOL_GPL(hid_field_extract);
>   * The data mangled in the bit stream remains in little endian
>   * order the whole time. It make more sense to talk about
>   * endianness of register values by considering a register
> - * a "cached" copy of the little endiad bit stream.
> + * a "cached" copy of the little endian bit stream.
>   */
> -static void implement(const struct hid_device *hid, __u8 *report,
> -		      unsigned offset, unsigned n, __u32 value)
> +
> +static void __implement(u8 *report, unsigned offset, int n, u32 value)
> +{
> +	unsigned int idx = offset / 8;
> +	unsigned int size = offset + n;
> +	unsigned int bit_shift = offset % 8;
> +	int bits_to_set = 8 - bit_shift;
> +	u8 bit_mask = 0xff << bit_shift;
> +
> +	while (n - bits_to_set >= 0) {
> +		report[idx] &= ~bit_mask;
> +		report[idx] |= value << bit_shift;
> +		value >>= bits_to_set;
> +		n -= bits_to_set;
> +		bits_to_set = 8;
> +		bit_mask = 0xff;
> +		bit_shift = 0;
> +		idx++;
> +	}
> +
> +	/* last nibble */
> +	if (n) {
> +		if (size % 8)
> +			bit_mask &= (1U << (size % 8)) - 1;
> +		report[idx] &= ~bit_mask;
> +		report[idx] |= (value << bit_shift) & bit_mask;
> +	}
> +}
> +
> +static void implement(const struct hid_device *hid, u8 *report,
> +		      unsigned offset, unsigned n, u32 value)
>  {
> -	u64 x;
> -	u64 m = (1ULL << n) - 1;
> +	u64 m;
>  
> -	if (n > 32)
> +	if (n > 32) {
>  		hid_warn(hid, "%s() called with n (%d) > 32! (%s)\n",
>  			 __func__, n, current->comm);
> +		n = 32;
> +	}
>  
> +	m = (1ULL << n) - 1;
>  	if (value > m)
>  		hid_warn(hid, "%s() called with too large value %d! (%s)\n",
>  			 __func__, value, current->comm);
>  	WARN_ON(value > m);
>  	value &= m;
>  
> -	report += offset >> 3;
> -	offset &= 7;
> -
> -	x = get_unaligned_le64(report);
> -	x &= ~(m << offset);
> -	x |= ((u64)value) << offset;
> -	put_unaligned_le64(x, report);
> +	__implement(report, offset, n, value);
>  }
>  
>  /*
> -- 
> 2.6.0.rc2.230.g3dd15c0
> 
> 
> -- 
> Dmitry
