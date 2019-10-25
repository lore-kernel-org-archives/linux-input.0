Return-Path: <SRS0=0DbS=YS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CBFC47E49
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 17:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F19D20867
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572022963;
	bh=NJVJJyPZXQ7Ii02Y5Qwry+y+ZCCNT8UgMTLVzZ5U+9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BeE421Fjg3ArW8NKI9aDVJ02hyTWTRgi4LL5yQ7iFxKmlErxnqgfT4Mqnb5Wm548J
	 gpnB3u1bhG2UeP5SBkPKEQ9zqUZF3XyETiVDqZaK4ILt8tEUFtiGwP3zF6SwAFo648
	 6SUr9UiIE73zSFM9elB95zpWu8RKBgM3wDxuL54M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409602AbfJYRCn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:02:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39481 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfJYRCm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Oct 2019 13:02:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id v138so2076611oif.6;
        Fri, 25 Oct 2019 10:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1je0vidW0gA9BZC2ySQZiimdAJyw9gnUzbO+i+g1658=;
        b=KCeXTwkCz++8iwpIr3e9q93eTyEjUk5Sf4ZjnGalCRdLPvncK0CBwVVwMbywMSslMf
         xvQdURrvZnCBZiQwsmk+/JYw3eWfchltSFIPt0rbaBKgzh5kPxtHbNZriFTMZxKmcWbd
         c4QU5YFKfM2L2i1M9rzrsIjV6KC9n0YOxhXeFxw9cbE/yMO8Kn41qx4cBilgGX/GrN80
         CFLOJnVyMGUPFWoivbuLOo3HxO+iHcrXuwxr8yQY+FKLVWBAzL8fooEMepXZ/y9eIQtz
         ctegwMO0qFyZwh4KleRRViEh8ggMNCpxm3Ht/15qhDiCHWr5jA987r//VMyWDri9rora
         uLog==
X-Gm-Message-State: APjAAAXMKRxe+JqOzJ+kW32h7MRVfdtPNwVIqujrUVpU7MPwSGJNMH6+
        WdCScLdvLsnT6A0chQwhZQ==
X-Google-Smtp-Source: APXvYqxSd3WRuomUGEAUJ8aEqH2FmnEDdcA7sgomWRVtFipQ4J6+Yd869cRA6aUPe1Xixkib9ypHCw==
X-Received: by 2002:aca:d882:: with SMTP id p124mr3788390oig.44.1572022961666;
        Fri, 25 Oct 2019 10:02:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm871763otm.8.2019.10.25.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:02:40 -0700 (PDT)
Date:   Fri, 25 Oct 2019 12:02:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
Message-ID: <20191025170240.GA7951@bogus>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021124428.2541-6-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 21 Oct 2019 14:44:27 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 core MFD module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
>  .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
