Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9AC433E0
	for <linux-input@archiver.kernel.org>; Tue,  2 Mar 2021 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0585164EE8
	for <linux-input@archiver.kernel.org>; Tue,  2 Mar 2021 12:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbhCBMse convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Tue, 2 Mar 2021 07:48:34 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:24209 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbhCBBGT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 1 Mar 2021 20:06:19 -0500
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="39591815"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 02 Mar 2021 09:04:58 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(2830:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Tue, 02 Mar 2021 09:04:58 +0800 (CST)
Received: By OpenMail Mailer;Tue, 02 Mar 2021 09:04:57 +0800 (CST)
From:   "jingle.wu" <jingle.wu@emc.com.tw>
Reply-To: "jingle.wu" <jingle.wu@emc.com.tw>
Subject: Re: [PATCH] Input: elan_i2c - Reduce the resume time for new dev
        ices
Message-ID: <1614647097.9201.jingle.wu@emc.com.tw>
In-Reply-To: <YDx8M4Rhdi8hW4EO@google.com>
References: <20210226073537.4926-1-jingle.wu@emc.com.tw>
        <YDx8M4Rhdi8hW4EO@google.com>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-input" <linux-input@vger.kernel.org>,
        "phoenix" <phoenix@emc.com.tw>, "dave.wang" <dave.wang@emc.com.tw>,
        "josh.chen" <josh.chen@emc.com.tw>
Date:   Tue, 02 Mar 2021 09:04:57 +0800 (CST)
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

HI Dmitry:

So data->ops->initialize(client) essentially performs reset of the
controller (we may want to rename it even) and as far as I understand
you would want to avoid resetting the controller on newer devices,
right?

-> YES

My question is how behavior of older devices differ from the new ones
(are they stay in "undefined" state at power up) and whether it is
possible to determine if controller is in operating mode. For example,
what would happen on older devices if we call elan_query_product() below
without resetting the controller?

-> But there may be other problems, because ELAN can't test all the older devices , 
-> so use quirk to divide this part.

I also think that while I can see us skipping reset in resume paths we
probably want to keep it in probe as we really do not know the state of
the device (was it powered up properly earlier, etc).

-> In this part, at PROBE state will be called data->ops->initialize(client) function.
-> Because quirk's setting (data->quirks = elan_i2c_lookup_quirk(data->ic_type, data->product_id);)
-> is after data->ops->initialize(client) and elan_query_product()  function.

THANKS
JINGLE
-----Original message-----
From:Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:jingle.wu <jingle.wu@emc.com.tw>
Cc:linux-kernel@vger.kernel.org,linux-input@vger.kernel.org,phoenix@emc.com.tw,dave.wang@emc.com.tw,josh.chen@emc.com.tw
Date:Mon, 01 Mar 2021 13:31:31
Subject:Re: [PATCH] Input: elan_i2c - Reduce the resume time for new devices

Hi Jingle,

On Fri, Feb 26, 2021 at 03:35:37PM +0800, jingle.wu wrote:
> @@ -273,10 +318,12 @@ static int __elan_initialize(struct elan_tp_data *data)
>  	bool woken_up = false;
>  	int error;
>  
> -	error = data->ops->initialize(client);
> -	if (error) {
> -		dev_err(&client->dev, "device initialize failed: %d\n", error);
> -		return error;
> +	if (!(data->quirks & ETP_QUIRK_SET_QUICK_WAKEUP_DEV)) {
> +		error = data->ops->initialize(client);
> +		if (error) {
> +			dev_err(&client->dev, "device initialize failed: %d\n", error);
> +			return error;
> +		}

So data->ops->initialize(client) essentially performs reset of the
controller (we may want to rename it even) and as far as I understand
you would want to avoid resetting the controller on newer devices,
right?

My question is how behavior of older devices differ from the new ones
(are they stay in "undefined" state at power up) and whether it is
possible to determine if controller is in operating mode. For example,
what would happen on older devices if we call elan_query_product() below
without resetting the controller?

I also think that while I can see us skipping reset in resume paths we
probably want to keep it in probe as we really do not know the state of
the device (was it powered up properly earlier, etc).

>  	}
>  
>  	error = elan_query_product(data);
> @@ -366,6 +413,8 @@ static int elan_query_device_info(struct elan_tp_data *data)
>  	if (error)
>  		return error;
>  
> +	data->quirks = elan_i2c_lookup_quirk(data->ic_type, data->product_id);
> +
>  	error = elan_get_fwinfo(data->ic_type, data->iap_version,
>  				&data->fw_validpage_count,
>  				&data->fw_signature_address,
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
