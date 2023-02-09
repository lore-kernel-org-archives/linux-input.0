Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B614C05027
	for <linux-input@archiver.kernel.org>; Thu,  9 Feb 2023 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBIOyb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjBIOya (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2023 09:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77826AD02
        for <linux-input@vger.kernel.org>; Thu,  9 Feb 2023 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tm9p9B92wuiXvWtB5X8K6MLqf1n5zJucRs53CwjBdIM=;
        b=e9+sxPaIC+lDfU5Huz61HxOYsYHwlAMXXfvJnL/GKGEXYiFQOKSMt+Tc3tLfkvXyEkmVkU
        twwEtxVFSQAVYEqjYGE/8A1OdZ3i3TXeWElhkwB+gf1Qsgo5UWSspaCNLK3Xq9YgZtIhNz
        RJ+k2P/oJIE3PMOXIkGFTtUV9D1AqRo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-uAuaUL9YP9mvCHEN-d1U-A-1; Thu, 09 Feb 2023 09:53:39 -0500
X-MC-Unique: uAuaUL9YP9mvCHEN-d1U-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C87693C0F22C;
        Thu,  9 Feb 2023 14:53:38 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFDB1121315;
        Thu,  9 Feb 2023 14:53:35 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:53:31 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v2 3/3] HID: logitech-hidpp: Add myself to authors
Message-ID: <20230209145331.qqryivtatswdxvlf@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
 <20230206221256.129198-3-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206221256.129198-3-hadess@hadess.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Feb 06 2023, Bastien Nocera wrote:
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> 
> Same as v1
> 
>  drivers/hid/hid-logitech-hidpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 9e94026de437..03b77ca03081 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -30,6 +30,7 @@
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
> +MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");

Just FTR, I have asked Bastien to set himself as an author given all of
the work he has been doing on this and to have one more person to be the
go-to person from folks having an issue.

And Bastien, would you mind adding yourself to the MAINTAINERS file too?
This way you'll get Cc-ed when people submit patches.

Cheers,
Benjamin

>  
>  static bool disable_tap_to_click;
>  module_param(disable_tap_to_click, bool, 0644);
> -- 
> 2.39.1
> 

