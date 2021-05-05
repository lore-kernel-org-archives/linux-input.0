Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB38FC43460
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79EB613AA
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhEEMeD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 May 2021 08:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhEEMeC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 May 2021 08:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB31610FB;
        Wed,  5 May 2021 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620217986;
        bh=WRPI8uSvBQAHJQ3atlPtvokxA0AWzk1rFNxT0nzJCFU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RZoEErko5le4MAz5NTu/Tb35/ZzyOi447kBNz0XY8Ijv85gotH4g5yU9Wk8Qyz+bi
         bBtBFzJITyZeQaQAmRqE32BUFBUj6cvodUU5kgASSKFWYEJF4kzGryzapIO64q18cL
         H0HwhKpU+j+lqpNSRpMWgH9vvbPgkO2B7+nv3uj5LlUJp16ZfkpEMhY6Q5LdNmC0oB
         zfPcltkGRjKG1PDqpIisxr17g6WrzJ4hyVTOEMw3GKObXKMerjwgt40uYERiDT4JhR
         aNU9tVOxwOvNWRQIJxOraGC8R7YngeFfcNnJkQnYycVKk9inWl6cjpz8rLrUKebasm
         vJsgFX0IhOtug==
Date:   Wed, 5 May 2021 14:33:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michael Zaidman <michael.zaidman@gmail.com>
cc:     dan.carpenter@oracle.com, benjamin.tissoires@redhat.com,
        wsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] HID: ft260: check data size in ft260_smbus_write()
In-Reply-To: <20210413151200.2174-1-michael.zaidman@gmail.com>
Message-ID: <nycvar.YFH.7.76.2105051432470.28378@cbobk.fhfr.pm>
References: <20210413151200.2174-1-michael.zaidman@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 13 Apr 2021, Michael Zaidman wrote:

> Fixes: 98189a0adfa0 ("HID: ft260: add usb hid to i2c host bridge driver")
> 
> The SMbus block transaction limits the number of bytes transferred to 32,
> but nothing prevents a user from specifying via ioctl a larger data size
> than the ft260 can handle in a single transfer.
> 
> i2cdev_ioctl_smbus()
>    --> i2c_smbus_xfer
>        --> __i2c_smbus_xfer
>            --> ft260_smbus_xfer
>                --> ft260_smbus_write
> 
> This patch adds data size checking in the ft260_smbus_write().
> 
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

I have moved the 'Fixes:' tag to place where it belongs, and applied. 
Thanks,

-- 
Jiri Kosina
SUSE Labs

