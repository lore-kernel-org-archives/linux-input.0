From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: prevent buffer overflow in early IRQ
Date: Thu, 11 Dec 2014 20:17:39 -0500
Message-ID: <20141212011739.GA14905@mail.corp.redhat.com>
References: <1418342565-22161-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418342565-22161-1-git-send-email-gwendal@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jkosina@suse.cz, stable@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Dec 11 2014 or thereabouts, Gwendal Grignou wrote:
> Before ->start() is called, bufsize size is set to HID_MIN_BUFFER_SIZE,
> 64 bytes. While processing the IRQ, we were asking to receive up to
> wMaxInputLength bytes, which can be bigger than 64 bytes.
> 
> Later, when ->start is run, a proper bufsize will be calculated.
> 
> Given wMaxInputLength is said to be unreliable in other part of the
> code, set to receive only what we can even if it results in truncated
> reports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Cc: stable@vger.kernel.org
> ---

Yep, well spotted. Makes sense to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 226375e..d32037c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -370,7 +370,7 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
>  {
>  	int ret, ret_size;
> -	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
> +	int size = ihid->bufsize;
>  
>  	ret = i2c_master_recv(ihid->client, ihid->inbuf, size);
>  	if (ret != size) {
> -- 
> 2.2.0.rc0.207.ga3a616c
> 
