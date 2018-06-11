From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-ntrig: add error handling for
 sysfs_create_group
Date: Mon, 11 Jun 2018 14:20:30 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806111419480.6203@cbobk.fhfr.pm>
References: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 11 Jun 2018, Zhouyang Jia wrote:

> When sysfs_create_group fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling sysfs_create_group.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/hid/hid-ntrig.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 43b1c72..1e70dae 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -955,6 +955,10 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj,
>  			&ntrig_attribute_group);
> +	if (ret) {
> +		hid_err(hdev, "cannot create sysfs group\n");
> +		goto err_free;
> +	}

Is it really necessarily to bail out completely here and render the device 
dysfunctional? Issuing a warning about sysfs knobs being unavailable might 
be more appropriate.

Thanks,

-- 
Jiri Kosina
SUSE Labs
