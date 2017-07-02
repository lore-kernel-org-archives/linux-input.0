From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] HID: wacom: Remove comparison of u8 mode with zero and
 simplify.
Date: Sun, 02 Jul 2017 15:04:28 -0700
Message-ID: <1499033068.9885.7.camel@perches.com>
References: <1499032463-22425-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:41427 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751894AbdGBWEd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 18:04:33 -0400
In-Reply-To: <1499032463-22425-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2017-07-02 at 22:54 +0100, Christos Gkekas wrote:
> Variable mode in method wacom_show_remote_mode() is defined as u8, thus
> statement (mode >= 0) is always true and should be removed, simplifying
> the logic.
[]
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
[]
> @@ -1671,10 +1671,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
>  	u8 mode;
>  
>  	mode = wacom->led.groups[index].select;
> -	if (mode >= 0 && mode < 3)
> -		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
> -	else
> -		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", mode < 3 ? mode : -1);

It's also hard to imagine that PAGE_SIZE could be less than 4 bytes so
	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
could work too.

