Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87BC61DA4
	for <linux-input@archiver.kernel.org>; Thu,  9 Mar 2023 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCIOSV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCIOSS (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2023 09:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72313526D;
        Thu,  9 Mar 2023 06:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4491260C5C;
        Thu,  9 Mar 2023 14:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FFEC433D2;
        Thu,  9 Mar 2023 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678371495;
        bh=K6/MSzKomf7M2VqFENEp6h4zYqgNXCyagVulYTDG4RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMTvRiyUuIG3pXtNM5ou/nZe757msYe5xp8ZlPkTTkyQDPkg8T7Rk9/vGH4RGH9qr
         axqj43VFATbJowBQnJqu3E/V7NnWfXYbS+paU98pnw0rUrs7Tfrha1x31r4rrmVPxa
         +n9K2YMKXGQMCX/szZWrLta0ezsB3sowmxHHAPug=
Date:   Thu, 9 Mar 2023 15:18:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v3 1/6] HID: logitech-hidpp: Simplify array length check
Message-ID: <ZAnqpZhFuiIQeFBk@kroah.com>
References: <20230302105555.51417-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302105555.51417-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Mar 02, 2023 at 11:55:50AM +0100, Bastien Nocera wrote:
> Use the compiler to force a 100-length array, rather than check the
> length after the fact.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> New in v2, following a review comment in the 1f20 enablement patch.
> No changes in v3.
> 
>  drivers/hid/hid-logitech-hidpp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

These all look good to me, and probably should go through the HID tree,
so I've acked the USB-specific ones to allow that.

thanks,

greg k-h
