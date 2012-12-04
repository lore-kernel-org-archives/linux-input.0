From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 05/14] HID: i2c-hid: fix i2c_hid_dbg macro
Date: Tue, 4 Dec 2012 22:49:50 +0100
Message-ID: <20121204224950.6ebd7346@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-6-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354634875-5182-6-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue,  4 Dec 2012 16:27:46 +0100, Benjamin Tissoires wrote:
> This avoids the problematic case:
> 
> if (condition)
> 	i2c_hid_dbg(ihid, "Blah blah %d\n", i);
> else
> 	do_something_very_important();
> 
> Which looks correct, however with the previous macro definition,
> this expands to the unexpected:
> 
> if (condition) {
> 	if (debug)	\
> 		dev_printk(KERN_DEBUG, &ihid->client->dev,
> 				"Blah blah %d\n", i);
> 	else
> 		do_something_very_important();
> }
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 9ee6555..54950be 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -50,9 +50,11 @@ static bool debug;
>  module_param(debug, bool, 0444);
>  MODULE_PARM_DESC(debug, "print a lot of debug information");
>  
> -#define i2c_hid_dbg(ihid, fmt, arg...)	\
> -	if (debug)			\
> -		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg)
> +#define i2c_hid_dbg(ihid, fmt, arg...)					  \
> +do {									  \
> +	if (debug)							  \
> +		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg); \
> +} while (0)
>  
>  struct i2c_hid_desc {
>  	__le16 wHIDDescLength;

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
