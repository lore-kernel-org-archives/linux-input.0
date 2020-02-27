Return-Path: <SRS0=dHTn=4P=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B40C4BA06
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE824680
	for <linux-input@archiver.kernel.org>; Thu, 27 Feb 2020 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582788163;
	bh=RbDs5D0nGO+vLKC9chqe6xT6asU3XQm2I5A+ZEGGg30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iE0DONn9C+rsgoP4ZuuOEmEdq6yUZjesqhZnOsp6g2X4n+m7tfP8/UDfS+BEltedw
	 Jid8jFtuuwh2pfM1R6smbKceB2jooTInSLiMtL3IyvihLtda2JUjZu9REjwEXuHlHR
	 mjo0o614aE8/1jcdV8Gjx8vcYhaDC7oKDBp5DG+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgB0HWn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0HWn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Feb 2020 02:22:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2491324656;
        Thu, 27 Feb 2020 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582788162;
        bh=RbDs5D0nGO+vLKC9chqe6xT6asU3XQm2I5A+ZEGGg30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeRVSMSKtTKj5BSkvh6pQaXH6NIeNegVZVhesmofU/epROFA3hT4OqohMnHScvyu2
         e5Saj4vzK4x/scPLcc111WKhiJAsL7js91cWKjJJHxIHJy21F7Kjvxqb9sdLNLwFa7
         i5KWB/DcoW699ImceiQkIh28aOI+h7k8iyTJbLio=
Date:   Thu, 27 Feb 2020 08:22:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ycho1399@gmail.com
Cc:     linux-input@vger.kernel.org, voyandrea@gmail.com,
        andrea.ho@advantech.com.tw, oakley.ding@advantech.com.tw,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [V1,1/1] Input/misc: add support for Advantech software defined
 button
Message-ID: <20200227072239.GA293173@kroah.com>
References: <20200227031721.17703-1-Andrea.Ho@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227031721.17703-1-Andrea.Ho@advantech.com.tw>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Feb 27, 2020 at 03:15:31AM +0000, ycho1399@gmail.com wrote:
> From: "Andrea.Ho" <Andrea.Ho@advantech.com.tw>
> 
> Advantech sw_button is a ACPI event trigger button.
> 
> With this driver, we can report KEY_EVENTs on the
> Advantech Tabletop Network Appliances products and it has been
> tested in FWA1112VC.
> 
> Add the software define button support to report KEY_EVENTs by
> different acts of pressing button (like double-click, long pressed
> and tick) that cloud be get on user interface and trigger the
> customized actions.
> 
> Signed-off-by: Andrea.Ho <Andrea.Ho@advantech.com.tw>
> ---
>  ...define.patch.EXPERIMENTAL-checkpatch-fixes | 554 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  drivers/input/misc/Kconfig                    |  11 +
>  drivers/input/misc/Makefile                   |   2 +-
>  drivers/input/misc/adv_swbutton.c             | 473 +++++++++++++++
>  5 files changed, 1044 insertions(+), 1 deletion(-)
>  create mode 100644 0001-Input-misc-add-support-for-Advantech-software-define.patch.EXPERIMENTAL-checkpatch-fixes
>  create mode 100644 drivers/input/misc/adv_swbutton.c
> 
> diff --git a/0001-Input-misc-add-support-for-Advantech-software-define.patch.EXPERIMENTAL-checkpatch-fixes b/0001-Input-misc-add-support-for-Advantech-software-define.patch.EXPERIMENTAL-checkpatch-fixes
> new file mode 100644
> index 000000000000..45e49aee5b47
> --- /dev/null
> +++ b/0001-Input-misc-add-support-for-Advantech-software-define.patch.EXPERIMENTAL-checkpatch-fixes

<snip>

I doubt you ment to commit the patch itself into the patch :(
