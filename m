From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Limit reads to wMaxInputLength bytes for
 input events
Date: Fri, 20 Feb 2015 14:38:30 -0500
Message-ID: <20150220193830.GB15471@mail.corp.redhat.com>
References: <1424454311-70750-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbbBTTii (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 14:38:38 -0500
Content-Disposition: inline
In-Reply-To: <1424454311-70750-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Feb 20 2015 or thereabouts, Seth Forshee wrote:
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

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!
Benjamin

> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
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
> -- 
> 1.9.1
> 
