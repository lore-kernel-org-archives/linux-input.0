Return-Path: <SRS0=GsZw=3Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80598C3524D
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED412084E
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580824436;
	bh=cTRm0HfHck/Oacxafv/ddSovZ7WJgp4TusOrzcStXsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gNGqG6imZnlb0FY4WJAPLPF6GJauOQIqxbGDFvAkZR/si22b3cc0Fyl5+iE4uMkAU
	 z6+M5XtNFVBlNH5zsR/xyhQlyzgreWH5fM5e0eOJc5b6ae2fJUZp11K7ewPVQsFHHS
	 k5ApVQ0Y6djffrUvgawPxnNfaBwGiidHiE/wjeS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBDNxx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgBDNxx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Feb 2020 08:53:53 -0500
Received: from localhost (unknown [212.187.182.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B21E2082E;
        Tue,  4 Feb 2020 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580824431;
        bh=cTRm0HfHck/Oacxafv/ddSovZ7WJgp4TusOrzcStXsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux8GwcZ27sMsJSqo00flBxSWrBBai6XeD0hMY4SRVqzV468jTWnxjtRC5Vk7y+y9g
         ruBZXeWfWTRyqDu5OyO3GDJ5xAWdhm3WmM8+zUFWdtdYW9JB2Zo5qNhTOZfDim/YoQ
         kvBw88tpx11hUoFpwqMHasLKfHDT+GfH+T6PbF+E=
Date:   Tue, 4 Feb 2020 13:53:49 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lauri Jakku <lja@iki.fi>
Cc:     oneukum@suse.com, benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] USB: HID: random timeout failures tackle try.
Message-ID: <20200204135349.GA1112714@kroah.com>
References: <20200204131555.25534-1-lja@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204131555.25534-1-lja@iki.fi>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Feb 04, 2020 at 03:15:56PM +0200, Lauri Jakku wrote:
> There is multiple reports of random behaviour of USB HID devices.
> 
> I have mouse that acts sometimes quite randomly, I debugged with
> logs others have published: that there is HW timeouts that leave
> device in state that it is errorneus.
> 
> To fix this, I introduce retry mechanism in root of USB HID drivers.
> 
> Fix does not slow down operations at all if there is no -ETIMEDOUT
> got from control message sending.
> 
> If there is one, then sleep 20ms and try again. Retry count is 20
> witch translates maximium of 400ms before giving up. If the 400ms
> boundary is reached the HW is really bad.
> 
> JUST to be clear:
>     This does not make USB HID devices to sleep anymore than
>     before, if all is golden and no timeouts are got.
> 
> Why modify usb-hid-core: No need to modify driver by driver.
> At this time i do not know all the USB HID devices that timeouts,
> but what i've researched, there are issues.
> 
> Timeout given is divided by 100, but taken care that it is always
> at least 10ms.
> 
> so total time in common worst-case-scenario is:
> 
>  sleep of 20ms + common timeout divided by 100 (50ms) makes
>  70ms per loop, 20 loops => 1.4sec .
> 
> Signed-off-by: Lauri Jakku <lja@iki.fi>
> ---
>  drivers/usb/core/message.c | 55 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 5 deletions(-)

What changed from v1 and v2?

That always has to be described below the --- line, as documented, to
give us a chance to understand what is happening here and why this is a
new version.

Please fix up and send a v4.

thanks,

greg k-h
