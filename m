From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v4 3/4] Style fixes
Date: Mon, 14 Jul 2014 12:19:38 +0200
Message-ID: <20140714121938.c9fc3f2526d029b13c7ceb8e@ao2.it>
References: <1405236262-8070-1-git-send-email-jm@lentin.co.uk>
	<1405236262-8070-4-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:3242 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110AbaGNKTy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 06:19:54 -0400
In-Reply-To: <1405236262-8070-4-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 13 Jul 2014 08:24:21 +0100
Jamie Lentin <jm@lentin.co.uk> wrote:

> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Reviewed-by: Antonio Ospite <ao2@ao2.it>

> ---
>  drivers/hid/hid-lenovo.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index d11e337..a1a693c 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -349,7 +349,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
>  	struct lenovo_drvdata_tpkbd *data_pointer;
>  	size_t name_sz = strlen(dev_name(dev)) + 16;
>  	char *name_mute, *name_micmute;
> -	int i;
> +	int i, ret;

Preferred style is one declaration per line, but this style is also
quite common in kernel, so it's not a big deal.

>
>  	/*
>  	 * If this is the pointer half of the keyboard, input_mapping should
> @@ -369,10 +369,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
>  	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 3, 0, 2))
>  		return -ENODEV;
>  
> -	if (sysfs_create_group(&hdev->dev.kobj,
> -				&lenovo_attr_group_tpkbd)) {
> +	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tpkbd);
> +	if (ret)
>  		hid_warn(hdev, "Could not create sysfs group\n");
> -	}
>  
>  	data_pointer = devm_kzalloc(&hdev->dev,
>  				    sizeof(struct lenovo_drvdata_tpkbd),
> -- 
> 2.0.0
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
