From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v5 3/4] HID: lenovo: Style fixes
Date: Fri, 25 Jul 2014 15:33:24 +0200
Message-ID: <20140725153324.3463287fa928e6d495801b46@ao2.it>
References: <1406154648-14000-1-git-send-email-jm@lentin.co.uk>
	<1406154648-14000-4-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:45316 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbaGYNdo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 09:33:44 -0400
In-Reply-To: <1406154648-14000-4-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 23 Jul 2014 23:30:47 +0100
Jamie Lentin <jm@lentin.co.uk> wrote:

> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Jamie, please send a v6 of this patch alone[*], where you print the
return value as Dmitry suggested . You do print it in a similar
statement of the subsequent patch, so this makes even more sense.

FWIW I'd already take the patch as it is and consider it a readability
improvement, but I now realize that the suggestion of not calling
functions in conditions is not mentioned anywhere in
Documentation/CodingStyle, so maybe I would just be over-zealous.

Ciao,
   Antonio

[*] You can use the --in-relpy-to option of git-send-email to make it a
reply to your v5 3/4

> ---
>  drivers/hid/hid-lenovo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index a56b9e7..6d55939 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -350,6 +350,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
>  	size_t name_sz = strlen(dev_name(dev)) + 16;
>  	char *name_mute, *name_micmute;
>  	int i;
> +	int ret;
>  
>  	/*
>  	 * Only register extra settings against subdevice where input_mapping
> @@ -368,10 +369,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
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
