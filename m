From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date: Mon, 19 Nov 2018 14:33:10 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811191432460.21108@cbobk.fhfr.pm>
References: <20181114131642.21425-1-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114131642.21425-1-dh.herrmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Wed, 14 Nov 2018, David Herrmann wrote:

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
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/hid/uhid.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index fefedc0b4dc6..0dfdd0ac7120 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -496,12 +496,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>  		goto err_free;
>  	}
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

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
