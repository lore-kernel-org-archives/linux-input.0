From: Nicolas Kaiser <nikai@nikai.net>
Subject: Re: [PATCH] hid-multitouch: Filter collections by application
 usage.
Date: Tue, 16 Aug 2011 11:43:33 +0200
Message-ID: <20110816114333.03e1f465@absol.kitzblitz>
References: <1313451868-79836-1-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:34543 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781Ab1HPJvw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 05:51:52 -0400
In-Reply-To: <1313451868-79836-1-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Brown <jeffbrown@android.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, rydberg@euromail.se, chatty@enac.fr, benjamin.tissoires@enac.fr

Just a nit below.

* jeffbrown@android.com:
(..)
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 58d0e7a..4ee21ac 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -213,6 +213,16 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	struct mt_class *cls = td->mtclass;
>  	__s32 quirks = cls->quirks;
>  
> +	/* Only map fields from TouchScreen or TouchPad collections.
> +         * We need to ignore fields that belong to other collections
   ^
> +         * such as Mouse that might have the same GenericDesktop usages. */
   ^
You might want to use tabs here instead of spaces.

Best regards,
Nicolas Kaiser
