Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBAC433ED
	for <linux-input@archiver.kernel.org>; Mon, 17 May 2021 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C415F61221
	for <linux-input@archiver.kernel.org>; Mon, 17 May 2021 09:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbhEQJrS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 May 2021 05:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236066AbhEQJrS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 May 2021 05:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03B461206;
        Mon, 17 May 2021 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621244762;
        bh=lAFa+Si5kWcFvvpJFNzN92TGH41WlcS6wS9EIQsMzEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0i7XP6kOh9VnrlSvQ7gi+EQDFpkctkEEepo/8xcH20lARJSk3TyQlqc9AObdickI
         5PeM93iSH3W0ZD70AlMuJWuacCRkECB96oWTW9jQio304b+Z3oizlLcoLpIVzHAYB/
         kuVO9Eh9kVGtwNiz7RIujetyvyKHzAYPDrm6t/gw=
Date:   Mon, 17 May 2021 11:46:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ams5by6?= <maqianga@uniontech.com>
Cc:     jikos <jikos@kernel.org>,
        "benjamin.tissoires " <benjamin.tissoires@redhat.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] HID: usbhid: enable remote wakeup for mouse
Message-ID: <YKI7WJa+YTRhwm5M@kroah.com>
References: <20210517060145.32359-1-maqianga@uniontech.com>
 <YKIwIwx+nLyX/9LG@kroah.com>
 <1547909475.114060.1621244274064.JavaMail.xmail@bj-wm-cp-4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547909475.114060.1621244274064.JavaMail.xmail@bj-wm-cp-4>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, May 17, 2021 at 05:37:54PM +0800, 马强 wrote:
> 
> >> This patch enables remote wakeup by default for USB mouse  
> >> devices. Mouse in general are supposed to be wakeup devices, but  
> >> the correct place to enable it depends on the device's bus; no single  
> >> approach will work for all mouse devices. In particular, this  
> >> covers only USB mouse (and then only those supporting the boot  
> >> protocol).  
> >>  
> >> Signed-off-by: Qiang Ma <maqianga@uniontech.com>  
>  
> > Based on hardware testing, I do not think we can do this as no other  
> > operating system does this, right? It's not a requirement of the USB  
> > specification to support this, so we can not enforce it either.  
>  
> 
> Thanks for the prompt response.
> 
> We can change "dev->power.should_wakeup" to enabled,

I do not understand this statement.

> but ultimately it depends on the hardware and BIOS for wakeup.

Yes, and the hardware here (USB mice), do not all support this, so you
can not enable it universally as it will cause problems, right?

thanks,

greg k-h
