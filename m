From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: alps: Fix memory leak
Date: Wed, 14 Sep 2016 10:35:29 +0200
Message-ID: <20160914083528.GI25951@mail.corp.redhat.com>
References: <1473566941-25149-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbcINIff (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 04:35:35 -0400
Content-Disposition: inline
In-Reply-To: <1473566941-25149-1-git-send-email-axel.lin@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Jiri Kosina <jikos@kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org

On Sep 11 2016 or thereabouts, Axel Lin wrote:
> A kfree(readbuf) call was missed if hid_hw_raw_request() fails, fix it.
> Also avoid mixing direct return with goto in the error paths.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-alps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 048befd..2808da9 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -139,8 +139,8 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
>  	if (read_flag) {
>  		readbuf = kzalloc(U1_FEATURE_REPORT_LEN, GFP_KERNEL);
>  		if (!readbuf) {
> -			kfree(input);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto exit;
>  		}
>  
>  		ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, readbuf,
> @@ -149,6 +149,7 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
>  
>  		if (ret < 0) {
>  			dev_err(&hdev->dev, "failed read register (%d)\n", ret);
> +			kfree(readbuf);
>  			goto exit;
>  		}
>  
> -- 
> 2.7.4
> 
