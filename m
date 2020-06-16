Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB14C433DF
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336902071A
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 11:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5xtIv2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFPLaU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:30:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726799AbgFPLaU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 07:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592307019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkQghBVmPF5hf/f5sr1frkcGMcPT+i5He117SNpDHJg=;
        b=D5xtIv2swnv9+wim/0qXQeiHxHuWU9POiSnOs/5mtCzjWxqQXf3yjK3g3UFeiGF/T8ha1g
        ln19xHQDQ2Q72vXI9OJRXtEYfrdkfQiS9Ik9zPMQL24NGE67zu9DdhEhLZKgasN+jJahz0
        cjZ2Il9xcyfId0oGy/Tpe6WsrAV5El4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-X950bkFUN6WtVwT3p_Fbqg-1; Tue, 16 Jun 2020 07:30:17 -0400
X-MC-Unique: X950bkFUN6WtVwT3p_Fbqg-1
Received: by mail-ej1-f72.google.com with SMTP id a20so9264421ejt.19
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2020 04:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkQghBVmPF5hf/f5sr1frkcGMcPT+i5He117SNpDHJg=;
        b=DcOdE9ojW5O6sRJFh2TunWrH60+Qmb831t5PNDwrwWQQeA7Q+lK/2oChWmX+RZprvK
         MMn0+bamqP54lsjI8WI2tCAMpMJtEzW+CYGZmxCc4vozdNTfn9dDhGNIRv8SZnT7OwYs
         O5gUUyVJ33U0zQpiezNO72iHSkNhgLK/X00IOCtM1X2lOsQ6zKJyYHvBG/dnEeCvIQ8b
         5bq0tofEpovg6FbP7mQ6mddWGxMqgmqt9/yPMWQsW8/yYBDVKNkYbe4N7uwRn22i5Qy9
         i4bPHbxX83vsMI0cVX2dxO0i+3t7D8TcGeouZmezRa5Czg8qxwY20ZUZ7eMii7Hr42vz
         b0pw==
X-Gm-Message-State: AOAM532pJU2bEkPV/RGMk2KWkvYRHEjd0qCwN0XZk7hmAmPveA6hCPvZ
        7ct4F8s/vPYNul1YUh9ZIrBvujX3kpSV7ziiXfzOIuhP1Lpdz8rF41YqbbHf6vnZFU0fK3M8SO3
        EtuyrX4NvkDLAUofqdy6kZis=
X-Received: by 2002:a17:906:4d13:: with SMTP id r19mr2294137eju.45.1592307016261;
        Tue, 16 Jun 2020 04:30:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW4aX/bpdTxIooPDIUr6Eq0C1prgyCneWDjEpF5fySIk4/azqYA1Yk4zJD8Pc+GYFsj4t81Q==
X-Received: by 2002:a17:906:4d13:: with SMTP id r19mr2294112eju.45.1592307016032;
        Tue, 16 Jun 2020 04:30:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l8sm11112259ejz.52.2020.06.16.04.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 04:30:15 -0700 (PDT)
Subject: Re: [PATCH] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor
 override
To:     Federico Ricchiuto <fed.ricchiuto@gmail.com>, jikos@kernal.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200615204914.15549-1-fed.ricchiuto@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <197d680d-a38b-b478-1b7a-9c821ada0846@redhat.com>
Date:   Tue, 16 Jun 2020 13:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615204914.15549-1-fed.ricchiuto@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

On 6/15/20 10:49 PM, Federico Ricchiuto wrote:
> The Mediacom FlexBook edge13 uses the SIPODEV SP1064 touchpad, which does
> not supply descriptors, so it has to be added to the override list.
> 
> Signed-off-by: Federico Ricchiuto <fed.ricchiuto@gmail.com>

It looks like you copied and pasted part of the commit message from
another patch (which is fine), but you need to update the Subject
(the first line of the commit message) the Subject now still
mentions the Trekstor Surfbook E11B rather then the
Mediacom FlexBook edge13.

Otherwise this looks good to me.

Regards,

Hans


> ---
>   drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> index a66f08041a1a..bb3f802935cc 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> @@ -373,6 +373,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
>   		},
>   		.driver_data = (void *)&sipodev_desc
>   	},
> +	{
> +		.ident = "Mediacom FlexBook edge 13",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FlexBook_edge13-M-FBE13"),
> +		},
> +		.driver_data = (void *)&sipodev_desc
> +	},
>   	{
>   		.ident = "Odys Winbook 13",
>   		.matches = {
> 

