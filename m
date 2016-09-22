From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH -next] HID: alps: fix error return code in
 alps_input_configured()
Date: Thu, 22 Sep 2016 09:35:32 +0200
Message-ID: <20160922073532.GA9916@mail.corp.redhat.com>
References: <1474470725-4789-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcIVHfi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 03:35:38 -0400
Content-Disposition: inline
In-Reply-To: <1474470725-4789-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Sep 21 2016 or thereabouts, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/hid/hid-alps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 2808da9..507372e 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -384,7 +384,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  
>  		input2 = input_allocate_device();
>  		if (!input2) {
> -			input_free_device(input2);

Tiny nitpick: this change is not entirely related to the patch and
commit message. But it's OK-ish carrying this over through this patch.
(it's basically a no-op given that input2 is null).

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> +			ret = -ENOMEM;
>  			goto exit;
>  		}
>  
> @@ -426,7 +426,8 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		__set_bit(INPUT_PROP_POINTER, input2->propbit);
>  		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
>  
> -		if (input_register_device(data->input2)) {
> +		ret = input_register_device(data->input2);
> +		if (ret) {
>  			input_free_device(input2);
>  			goto exit;
>  		}
> 
> 
> 
