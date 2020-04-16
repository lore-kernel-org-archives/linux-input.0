Return-Path: <SRS0=d6Rb=6A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1668C2BB55
	for <linux-input@archiver.kernel.org>; Thu, 16 Apr 2020 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8025206D6
	for <linux-input@archiver.kernel.org>; Thu, 16 Apr 2020 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fGb++6KL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgDPSRx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:17:53 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:26711 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgDPSRu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Apr 2020 14:17:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4936s751dQzCQ;
        Thu, 16 Apr 2020 20:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587061068; bh=yreul8L2/XFaTMGInbe7z7e5xPWbE2CJ+CJqdgCEIyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGb++6KLj4oxEFkpG2A7t1FvEjXuU2aPM+BCT72TtxB3Hy8ejEgJ/9Kq8Ln/y2E6Z
         w4TvLg/aaUlYN0+faiHUqWU1tp3rWxTr9jqFiY1qcFWY4We7H6gDOm1rnLRJaq4PUI
         H3gX96Zh8P6hjz3YNQp5KC1v7P3qcsAOPzgyHW9MqZmM41WotTMdEwYHdVT6BT7X5i
         wjWQdpaByBbTM73XGd3TxvfKLIaeA8zDTIkh88m+DPOuzXXFB/XPX0Z5Xe0SZ2Bp9o
         CQc/skwA4EWCvCGKTGXXkLJyPMCYrrP6FGLNsPfUKj9E2LsAIhIZj3qmiW+TFDFAYc
         L4RumFtqXAudg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 16 Apr 2020 20:17:46 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200416181746.GB372@qmqm.qmqm.pl>
References: <20200416140917.8087-1-linus.walleij@linaro.org>
 <20200416140917.8087-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416140917.8087-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Apr 16, 2020 at 04:09:17PM +0200, Linus Walleij wrote:
> The manual for the HSCDTD008A gives us a scaling for the
> three axis as +/- 2.4mT per axis.
> 
> When I implement this the biggest axis indicates 0.59 Gauss
> which is a reasonable measurement for the earths magnetic
> which is in the range of 0.25 to 0.65 Gauss on the surface
> according to Wikipedia.
> 
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Split out the measurement refactoring.
> ---
>  drivers/iio/magnetometer/ak8974.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 5361647b9054..effcdd93e650 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -603,6 +603,18 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
>  		*val = outval;
>  		ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * The datasheet for HSCDTF008A, page 3 specifies the
> +		 * range of the sensor as +/- 2.4 mT per axis, which corresponds
> +		 * to +/- 2400 uT = +/- 24 Gauss. So 0x7fff is 24 Gauss and
> +		 * 0xffff is -24 Gauss. To account for the one missing value if
> +		 * we multiply by 1/S16_MAX, instead multiply with 2/U16_MAX.
> +		 */
> +		*val = 24 * 2;
> +		*val2 = U16_MAX;
> +		ret = IIO_VAL_FRACTIONAL;
> +		break;

Hi,

The comment seems wrong. DS mentions that the measurement values are
S16, but limited in range (-k to +k, with k = 2^13 or 2^14). So the
denominator should be 2^13 or 2^14, and numerator 2.4mT.

Best Regards,
Micha³ Miros³aw
