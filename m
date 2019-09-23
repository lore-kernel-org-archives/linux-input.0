From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: core: clean up indentation issue
Date: Mon, 23 Sep 2019 13:04:13 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1909231303180.1459@cbobk.fhfr.pm>
References: <20190922115054.10880-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190922115054.10880-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 22 Sep 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an if statement that is indented by one extra space,
> fix this by removing the extraneous space.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 3eaee2c37931..9469c382a182 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2329,10 +2329,10 @@ int hid_add_device(struct hid_device *hdev)
>  	/*
>  	 * Check for the mandatory transport channel.
>  	 */
> -	 if (!hdev->ll_driver->raw_request) {
> +	if (!hdev->ll_driver->raw_request) {
>  		hid_err(hdev, "transport driver missing .raw_request()\n");
>  		return -EINVAL;
> -	 }
> +	}

Let's not pollute git blame and wait for an ocasion when we need to touch 
the code for some more valid reason.

Thanks,

-- 
Jiri Kosina
SUSE Labs
