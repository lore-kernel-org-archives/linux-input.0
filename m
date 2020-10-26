Return-Path: <SRS0=b+LQ=EB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472EC4363A
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506782076B
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccDVJpdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782626AbgJZO6B (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Oct 2020 10:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1782368AbgJZO6A (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Oct 2020 10:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603724278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggR7nXs6vIGQ0hf64bcClqY2uGlUYrgDILb/HS3RbR0=;
        b=ccDVJpdUEtOh8ZCkqjQHrz/zl/a76oJSNzEZAdPirXXss9g7sutgNnFjS0D3xfq6s+tuWh
        tLIcSPj3MhUjl1KCaDY/oI8fBWQeljnabUmpbUqscTe5VO8GvC/QeKq3y+UQGVlW8PfKpn
        UnwhBo1/MUven+oZp8ld6vrT0hUhTlQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-nxXtIxhBN22P3K0JtLDy1g-1; Mon, 26 Oct 2020 10:57:57 -0400
X-MC-Unique: nxXtIxhBN22P3K0JtLDy1g-1
Received: by mail-ed1-f69.google.com with SMTP id i9so4457649edx.10
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2020 07:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggR7nXs6vIGQ0hf64bcClqY2uGlUYrgDILb/HS3RbR0=;
        b=dWqoph/yrLQ0ufsNu6ppDPOXgY4BB0amsX3VaTSqcW2ezZbu5RDtkc296oLCKgzSfc
         bX3htDLovkSf9Rp47iLQdSDVkltnOw9asHcipyxi0PrXBFttBCkMQ38PRnJ/zPji04jE
         got0cMJ2ttlBZkxHjcYNAnZSksqUtn+bYlg61QHs3dVKfUwnEAuGnNAHoqaW0UbqZ5/A
         rl2U1TrHdfFtzp3jGdQfZdzrkkELd0JU5ZVEthrJX5o//iIcMkvb5rVrED4Aja0SIMij
         hKv8LpX/ujP+5B86eVEulJJHlHueJqOMq26LDF3b+8eJfP/aFXD17knkfVPzMC1pFTDr
         3elA==
X-Gm-Message-State: AOAM531XfOC68ghdi5hkj3KkPFg+fqGuNLjK922EsUz3GKXTnb4VoR98
        WdZ0UJ8N4RvCbSUn6344p8LpF+41QwYjbM/hO/RM8Ob3wDjDwax75H8ld7tBLXDQIKcm+DquH2H
        SaockFZO0vtRRzvZYUUtxhM0=
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr15004449eju.364.1603724275289;
        Mon, 26 Oct 2020 07:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzODTXxY3/e+mQFlcVuOFI/H1Wxzk4Yk6iRiXII2XR3P5YMcpD2IUndHpp4JWdlTFYkUBDv9g==
X-Received: by 2002:a17:906:4d03:: with SMTP id r3mr15004435eju.364.1603724275057;
        Mon, 26 Oct 2020 07:57:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v21sm5296124edt.80.2020.10.26.07.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:57:54 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] Input: add event codes for lap and palmreset
 proximity switches
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dmitry.torokhov@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-input@vger.kernel.org, jeff@labundy.com,
        anthony.wong@canonical.com, hadess@hadess.net,
        Nitin Joshi <njoshi1@lenovo.com>
References: <markpearson@lenovo.com>
 <20201026144512.621479-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bc1f2cde-c50e-8704-2fa7-bb7f1b5d6405@redhat.com>
Date:   Mon, 26 Oct 2020 15:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026144512.621479-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

On 10/26/20 3:45 PM, Mark Pearson wrote:
> Add infrastructure needed to support lap and palmrest proximity sensors.
> 
> These sensors are used for identifying thermal mode changes and modifying
> WWAN transmitter power.
> 
> Reviewed-by: Nitin Joshi <njoshi1@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>

The entire series looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Dmitry: FYI I have take over drivers/platform/x86
maintainership from Andy.

Dmitry, since the first patch adds new evdev switch event-codes,
it is probably best if you merge this entire series through
the input tree. You hereby have my ack (as the new pdx86 maintainer)
for doing this.

Regards,

Hans



> ---
> Changes in v2:
>  - Update Input message
> Changes in v3:
>  - Added missing patch history notes
> 
>  include/linux/mod_devicetable.h        | 2 +-
>  include/uapi/linux/input-event-codes.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5b08a473cdba..897f5a3e7721 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -320,7 +320,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_LED_MAX		0x0f
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
>  #define INPUT_DEVICE_ID_FF_MAX		0x7f
> -#define INPUT_DEVICE_ID_SW_MAX		0x10
> +#define INPUT_DEVICE_ID_SW_MAX		0x12
>  #define INPUT_DEVICE_ID_PROP_MAX	0x1f
>  
>  #define INPUT_DEVICE_ID_MATCH_BUS	1
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 0c2e27d28e0a..26f71a9a6936 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -889,7 +889,9 @@
>  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
>  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
>  #define SW_MACHINE_COVER	0x10  /* set = cover closed */
> -#define SW_MAX			0x10
> +#define SW_LAP_PROXIMITY        0x11  /* set = lap proximity sensor active */
> +#define SW_PALMREST_PROXIMITY   0x12  /* set = palmrest proximity sensor active */
> +#define SW_MAX			0x12
>  #define SW_CNT			(SW_MAX+1)
>  
>  /*
> 

