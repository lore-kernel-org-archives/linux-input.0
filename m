From: Christos Gkekas <chris.gekas@gmail.com>
Subject: Re: [PATCH] HID: wacom: Remove comparison of u8 mode with zero and
 simplify.
Date: Sun, 2 Jul 2017 23:32:57 +0100
Message-ID: <20170702223257.GA24929@inspiron>
References: <1499032463-22425-1-git-send-email-chris.gekas@gmail.com>
 <1499033068.9885.7.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35896 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdGBWdA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Jul 2017 18:33:00 -0400
Content-Disposition: inline
In-Reply-To: <1499033068.9885.7.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/07/17 15:04:28 -0700, Joe Perches wrote:
> On Sun, 2017-07-02 at 22:54 +0100, Christos Gkekas wrote:
> > Variable mode in method wacom_show_remote_mode() is defined as u8, thus
> > statement (mode >= 0) is always true and should be removed, simplifying
> > the logic.
> []
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> []
> > @@ -1671,10 +1671,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
> >  	u8 mode;
> >  
> >  	mode = wacom->led.groups[index].select;
> > -	if (mode >= 0 && mode < 3)
> > -		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
> > -	else
> > -		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
> > +	return snprintf(buf, PAGE_SIZE, "%d\n", mode < 3 ? mode : -1);
> 
> It's also hard to imagine that PAGE_SIZE could be less than 4 bytes so
> 	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
> could work too.
>
Thanks for the suggestion, makes sense. I will resend the patch.

