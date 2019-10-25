Return-Path: <SRS0=0DbS=YS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0BDCA9EA0
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E72421D71
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572032465;
	bh=3cZAXDU8qXeVAE5Cf4gJpWhPF9wYN9KEm/t2t8c9qKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ngTl+EEZBgMsy+T24+NKAzpN0sXGwCGksEXLMZ9YDuhGHI7Y/yaZSMIyxLt5HwHHi
	 rJl4zbb5uph5nbOX7BcotGQ6NB6Xr9+lswSnGJPnxuALfA7iM33xpVMS6fd95yRTUo
	 Mkep6jLU+cL4X6JckY93LGgGh/5c3SbilKTA6Sc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJYTlF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:41:05 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40074 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfJYTlE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Oct 2019 15:41:04 -0400
Received: by mail-yb1-f196.google.com with SMTP id d12so1352913ybn.7;
        Fri, 25 Oct 2019 12:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6rid3xoZ0SUQoUbenfuddaBWiDM3moIgw0C3o2jRnk=;
        b=SdscXnbpRp8+9dDackirDap/mrhvQUZHdpAdPgmDkjKQ1WziduyAEazOI5kL56j18h
         IA8M4J/QnTLgCQq0XQHCUmChwxevBJ94Sr6ldZQC2LxB0c8nEhYGy8ArN7qAfNXFyZQH
         eqLE2nl4QfQaF+dUBCWOjvmrZoAkCtRxFD54zStDH+n1LdJBrEco8zc+DkC6IKZvYxGi
         ERDd5yqYTyti+SG+zbFCtQFjHoJJ9QdiP84QpzhFBrdGjF370xVNsyG9Z7CVSAZgbj/k
         FHQvD53fz1tGcd7FtBBP2mLBV8uF5MfbSxtwpMdX9ZNcXsf2l1i43a82IoVhWt5T7ReA
         imMA==
X-Gm-Message-State: APjAAAVQVBQza6Qb0VnXd9+el6o66Cytd+i2duYpeDhtcg5zUbaPRxW9
        GFYS9Ggrj8dRe3A3Yjo4bYAcIVI=
X-Google-Smtp-Source: APXvYqzdWvAAHX5FZcfrQ3oJzfNP/kKDWxh6B5Dzyl4KOyRE8HPtwOQDWvcC5f50KEGgRl6vBFBitg==
X-Received: by 2002:a9d:7b41:: with SMTP id f1mr4283724oto.323.1572032462697;
        Fri, 25 Oct 2019 12:41:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm815722oia.28.2019.10.25.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:41:01 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:41:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boitchat <drinkcat@chromium.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add DT bindings for Whiskers
 switch
Message-ID: <20191025194101.GA4734@bogus>
References: <20191023024348.225969-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023024348.225969-1-ikjn@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Oct 23, 2019 at 10:43:48AM +0800, Ikjoon Jang wrote:
> Add the DT binding document for Hammer's TABLET_MODE switch.

This doesn't have any properties. Why does it need to be in DT? Just 
have the EC driver instantiate it.

> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  .../devicetree/bindings/input/cros-cbas.yaml  | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
> new file mode 100644
> index 000000000000..3bc989c6a295
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cros-cbas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS Hammer's Base Attached Switch
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
> +
> +description:
> +  This device is used to signal when a detachable base is attached to a
> +  Chrome OS tablet. The node for this device must be under a cros-ec node
> +  like google,cros-ec-spi or google,cros-ec-i2c.

This should probably just be part of an EC schema where it can be 
enforced that this is a child node. It could be either embedded into it 
or referenced. I'd lean toward the former given this is only a 
compatible string...

> +
> +properties:
> +  compatible:
> +    const: google,cros-cbas
> +
> +required:
> +  - compatible

Add here:

additionalProperties: false.

> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
