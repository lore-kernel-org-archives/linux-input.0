From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: fix devm_add_action_or_reset() parameter
Date: Fri, 3 May 2019 14:19:19 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905031418510.10635@cbobk.fhfr.pm>
References: <1555073657-24386-1-git-send-email-fabien.dessenne@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555073657-24386-1-git-send-email-fabien.dessenne@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 12 Apr 2019, Fabien Dessenne wrote:

> The second parameter of devm_add_action_or_reset() shall be a function,
> not a function address.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/hid/hid-rmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 9e33165..8748d4d 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -623,7 +623,7 @@ static int rmi_setup_irq_domain(struct hid_device *hdev)
>  	if (!hdata->domain)
>  		return -ENOMEM;
>  
> -	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
> +	ret = devm_add_action_or_reset(&hdev->dev, rmi_irq_teardown, hdata);

Why do you think this is wrong C?

-- 
Jiri Kosina
SUSE Labs
