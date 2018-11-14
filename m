From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date: Wed, 14 Nov 2018 07:40:43 -0800
Message-ID: <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
References: <20181114131642.21425-1-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114131642.21425-1-dh.herrmann@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org

On 11/14/18 5:16 AM, David Herrmann wrote:
> This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.
> 
> Please note that `strlcpy()` does *NOT* do what you think it does.
> strlcpy() *ALWAYS* reads the full input string, regardless of the
> 'length' parameter. That is, if the input is not zero-terminated,
> strlcpy() will *READ* beyond input boundaries. It does this, because it
> always returns the size it *would* copy if the target was big enough,
> not the truncated size it actually copied.
> 
> The original code was perfectly fine. The hid device is
> zero-initialized and the strncpy() functions copied up to n-1
> characters. The result is always zero-terminated this way.
> 
> This is the third time someone tried to replace strncpy with strlcpy in
> this function, and gets it wrong. I now added a comment that should at
> least make people reconsider.
> 

Can we switch to strscpy instead? This will quiet gcc and avoid the
issues with strlcpy.

> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>   drivers/hid/uhid.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index fefedc0b4dc6..0dfdd0ac7120 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -496,12 +496,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>   		goto err_free;
>   	}
>   
> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
> -	strlcpy(hid->name, ev->u.create2.name, len);
> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
> -	strlcpy(hid->phys, ev->u.create2.phys, len);
> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
> -	strlcpy(hid->uniq, ev->u.create2.uniq, len);
> +	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
> +	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
> +	strncpy(hid->name, ev->u.create2.name, len);
> +	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
> +	strncpy(hid->phys, ev->u.create2.phys, len);
> +	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
> +	strncpy(hid->uniq, ev->u.create2.uniq, len);
>   
>   	hid->ll_driver = &uhid_hid_driver;
>   	hid->bus = ev->u.create2.bus;
> 
