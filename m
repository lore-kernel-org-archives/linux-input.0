Return-Path: <SRS0=0DbS=YS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0ACA9EA0
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 20:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998EA21872
	for <linux-input@archiver.kernel.org>; Fri, 25 Oct 2019 20:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z665EPZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJYUps (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:45:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36665 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfJYUps (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Oct 2019 16:45:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so2304845pgk.3;
        Fri, 25 Oct 2019 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d2F//uallRASJiLtJa6b2HhcE5JkE+G6oca+2rU1oUI=;
        b=Z665EPZ/yCHTAVl2x8XgKJjPFJUdkvRWArlLO58ADiy0/+dvKCh9bP4ExluhxgpQi+
         PmaLoMpqTY1vburlt0vTIQdXDibZ1F0wGIABwxZUDSSwllmdSUTKmbK1dbroEhTRuFuE
         J0xQqzdIaWRu4jmMNitoMMNfx/vpMDYBAP+vuSey9DyZVRwdH/M+e6J56wts89Rmt9mm
         jxJKhsoT+Pdt2bWd+1pWrg5rKGCsjY8KFFcfqZRcXkbmmsHbIzKJ7B7l8TiHu2yNdMyR
         jwD98NiHYGvg0jWkZVvf+c6gelG0Sszwn9MoWr+q8njWzEejE48qz3hJzmUfRSUimaRk
         gflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2F//uallRASJiLtJa6b2HhcE5JkE+G6oca+2rU1oUI=;
        b=IZq3BCItoQjFnLE9ToEoaw1GDYR9eIgm2Z7/Ed0tiqCDcAsvUJyzywsVXOC9H9IZke
         coXasS2mgcvh3XdtRdp/Fv5T/tvLdjH1XIYeczBaOjhthxbNncAYh0hlJdAbFE4hlro6
         kGEinWYFrg8u6ZRd0Nn5O98xZ1MilqFoCWjQvbivs7b6Zgx13AxCayvLQ4gHNFmvQ9X6
         4J1Ts/uNVYZbBP+AMRHL0PmGuyiuGY9ZCJT4h7tdCxAlLC9ugGcfeZinEUc8LZFjdyAu
         4mJUfvaM9TM9Xu//Ndm5tTehS8RkEkGfMhC5z2qmn6DojnO5rE6VKppqchp6JPcS226T
         LqRA==
X-Gm-Message-State: APjAAAVvlo0Y73WD6jBK81WyONc5Wb17cNeYI1JXxnVWWnU8REJfxED/
        3J/C3WJYLm/K74WyomELknY=
X-Google-Smtp-Source: APXvYqyUUbATg/2bkKdfPy7KKkdTXtx7x1GrQkZRl0RS4cAaOQVRjxfOQtlkRsDstK4KDRnvqZPEJw==
X-Received: by 2002:a05:6a00:51:: with SMTP id i17mr6762538pfk.8.1572036347040;
        Fri, 25 Oct 2019 13:45:47 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c128sm3714544pfc.166.2019.10.25.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 13:45:46 -0700 (PDT)
Date:   Fri, 25 Oct 2019 13:45:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ikjoon Jang <ikjn@chromium.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boitchat <drinkcat@chromium.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add DT bindings for Whiskers
 switch
Message-ID: <20191025204544.GA163068@dtor-ws>
References: <20191023024348.225969-1-ikjn@chromium.org>
 <20191025194101.GA4734@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025194101.GA4734@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Oct 25, 2019 at 02:41:01PM -0500, Rob Herring wrote:
> On Wed, Oct 23, 2019 at 10:43:48AM +0800, Ikjoon Jang wrote:
> > Add the DT binding document for Hammer's TABLET_MODE switch.
> 
> This doesn't have any properties. Why does it need to be in DT? Just 
> have the EC driver instantiate it.

We need to know whether to instantiate it or not. EC does not allow
querying whether the switch is present.

Thanks.

-- 
Dmitry
