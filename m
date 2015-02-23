From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: Limit reads to wMaxInputLength bytes for
 input events
Date: Mon, 23 Feb 2015 15:10:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231510460.19920@pobox.suse.cz>
References: <1424454311-70750-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424454311-70750-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, 20 Feb 2015, Seth Forshee wrote:

> d1c7e29e8d27 (HID: i2c-hid: prevent buffer overflow in early IRQ)
> changed hid_get_input() to read ihid->bufsize bytes, which can be
> more than wMaxInputLength. This is the case with the Dell XPS 13
> 9343, and it is causing events to be missed. In some cases the
> missed events are releases, which can cause the cursor to jump or
> freeze, among other problems. Limit the number of bytes read to
> min(wMaxInputLength, ihid->bufsize) to prevent such problems.
> 
> Fixes: d1c7e29e8d27 "HID: i2c-hid: prevent buffer overflow in early IRQ"
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index d43e967..5e72fc2 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -370,7 +370,10 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  static void i2c_hid_get_input(struct i2c_hid *ihid)
>  {
>  	int ret, ret_size;
> -	int size = ihid->bufsize;
> +	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
> +
> +	if (size > ihid->bufsize)
> +		size = ihid->bufsize;
>  
>  	ret = i2c_master_recv(ihid->client, ihid->inbuf, size);
>  	if (ret != size) {

-- 
Jiri Kosina
SUSE Labs
