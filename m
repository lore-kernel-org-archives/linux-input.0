From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: elan: fix spelling mistake "registred" ->
 "registered"
Date: Tue, 9 Oct 2018 13:32:53 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810091332440.14430@cbobk.fhfr.pm>
References: <20180927140052.28166-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927140052.28166-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 27 Sep 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in hid_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hid/hid-elan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
> index 07e26c3567eb..0bfd6d1b44c1 100644
> --- a/drivers/hid/hid-elan.c
> +++ b/drivers/hid/hid-elan.c
> @@ -497,7 +497,7 @@ static int elan_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return 0;
>  
>  	if (!drvdata->input) {
> -		hid_err(hdev, "Input device is not registred\n");
> +		hid_err(hdev, "Input device is not registered\n");

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
