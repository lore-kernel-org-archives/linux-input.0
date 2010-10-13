From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 1/6] hid: egalax: Use kzalloc
Date: Wed, 13 Oct 2010 13:36:13 -0400
Message-ID: <1286991373.31864.193.camel@mini>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
	 <1286978302-30034-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:45286 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab0JMRgU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 13:36:20 -0400
In-Reply-To: <1286978302-30034-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2010-10-13 at 15:58 +0200, Henrik Rydberg wrote:
> To avoid unnecessary explicit initialization, allocate zeroed memory.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hid/hid-egalax.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
> index 54b017a..5a1b52e 100644
> --- a/drivers/hid/hid-egalax.c
> +++ b/drivers/hid/hid-egalax.c
> @@ -221,7 +221,7 @@ static int egalax_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	struct egalax_data *td;
>  	struct hid_report *report;
>  
> -	td = kmalloc(sizeof(struct egalax_data), GFP_KERNEL);
> +	td = kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
>  	if (!td) {
>  		dev_err(&hdev->dev, "cannot allocate eGalax data\n");
>  		return -ENOMEM;

Pretty obvious.

Acked-by: Chase Douglas <chase.douglas@canonical.com>

