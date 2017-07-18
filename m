From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: axp20x: use correct platform device id for many
 PEK
Date: Tue, 18 Jul 2017 08:19:36 +0100
Message-ID: <20170718071936.llnpgwqmgzt2axea@dell>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33626 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdGRHTk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 03:19:40 -0400
Received: by mail-wr0-f174.google.com with SMTP id a10so15646751wrd.0
        for <linux-input@vger.kernel.org>; Tue, 18 Jul 2017 00:19:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170717095307.15986-3-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

On Mon, 17 Jul 2017, Quentin Schulz wrote:

> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
> AXP809 and AXP813 PEK have different values for startup time bits from
> the AXP20X, let's use the platform device id with the correct values.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch is find, but are these names reference from platform data
anywhere i.e. are we going to break anything by applying it?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
