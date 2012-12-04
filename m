From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 02/14] HID: i2c-hid: fix memory corruption due to
 missing hid declaration
Date: Tue, 4 Dec 2012 22:42:05 +0100
Message-ID: <20121204224205.58420e3f@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-3-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354634875-5182-3-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue,  4 Dec 2012 16:27:43 +0100, Benjamin Tissoires wrote:
> HID descriptors contains 4 bytes of reserved field.
> The previous implementation was overriding the next fields in struct i2c_hid.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 0fbb229..ad771a7 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -68,6 +68,7 @@ struct i2c_hid_desc {
>  	__le16 wVendorID;
>  	__le16 wProductID;
>  	__le16 wVersionID;
> +	__le32 reserved;
>  } __packed;
>  
>  struct i2c_hid_cmd {
> @@ -778,7 +779,7 @@ static int __devinit i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
>  	}
>  
>  	dsize = le16_to_cpu(hdesc->wHIDDescLength);
> -	if (!dsize || dsize > HID_MAX_DESCRIPTOR_SIZE) {
> +	if (!dsize || dsize > sizeof(struct i2c_hid_desc)) {

Shouldn't !dsize rather be dsize < 4? You're reading hdesc->bcdVersion,
which is only defined if dsize >= 4 if I understand the code correctly.

>  		dev_err(&client->dev, "weird size of HID descriptor (%u)\n",
>  			dsize);
>  		return -ENODEV;


-- 
Jean Delvare
