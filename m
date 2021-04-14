Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B7C43460
	for <linux-input@archiver.kernel.org>; Wed, 14 Apr 2021 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F8A61166
	for <linux-input@archiver.kernel.org>; Wed, 14 Apr 2021 15:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbhDNP31 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352280AbhDNP3Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Apr 2021 11:29:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D2C061574
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2021 08:29:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i6so6104690qti.10
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2021 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9Oa3BGE0nLdxfYSEJulYCQMQ2MOOmW16QvouCtA+Ws=;
        b=Trw4QaVx4IDtynizdbhRMzOZ6NQrZOQkImB52ygkyeKLdYaiE1ZQofk/brnMhXSpSS
         84gc4QfaWVXCoIWRgBQ+2U/V90JRhWBtDdeODEyCIwoQ7RTmvB+6v8tXi4ZltwjX7XbJ
         UBthN1H+rm9GC2LQJeI14t5WmXgg2Zgh075As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9Oa3BGE0nLdxfYSEJulYCQMQ2MOOmW16QvouCtA+Ws=;
        b=ecRTWNgIgAIEZ8/M+bmPC66hNMCQwjj9nSWH/em6c/06eNR7LW5/mGb9anm3Fec/GM
         9Zm5WGosbHYdrIgg8+58JHyWPKYEk+RaCRPn6ArJzwsnBRGMo3dUYrh7Yiv3MdrbZtIF
         hdaLlgyrifzm6Se2EbWwjytPluFZbqTouRyGviyCUJ3OWDKQYAGvi3YACvRQH8jJARbr
         06D1Gvp6A/w5JFQ08TdsAl0buSD6s7/mXYGwqkDwA25CpDZcCfnbiozMufR+UDEeyujc
         xdew1gTz9XcZpKEfjztx2N694aH9vJFQjKdt8F+pTVIQvB82DJvFuISMnlK6417na2aO
         /AWw==
X-Gm-Message-State: AOAM5319sJdKceKMVkvtzzVSyrhyUbpKZq3vB3twK6MJTQls39zKOzE/
        f8pdmzRNV2Ki5hp9XXh2x+hlT6UiQ+qNSA==
X-Google-Smtp-Source: ABdhPJzWzIttkLC9gRfp7/DRGMNE//+BuOraxYshyHTj8ShSXnMh5HqWe94Xr3tP7x59zMj/HttStA==
X-Received: by 2002:ac8:6f31:: with SMTP id i17mr18507835qtv.184.1618414141269;
        Wed, 14 Apr 2021 08:29:01 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h14sm11710476qtx.64.2021.04.14.08.29.00
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:29:01 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v72so1850623ybe.11
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2021 08:29:00 -0700 (PDT)
X-Received: by 2002:a25:58d5:: with SMTP id m204mr55376026ybb.32.1618414140336;
 Wed, 14 Apr 2021 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Apr 2021 08:28:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvrWKKbLExpFaDLTDGTam3rbwd7CwTLVFdCY=_c7-eag@mail.gmail.com>
Message-ID: <CAD=FV=VvrWKKbLExpFaDLTDGTam3rbwd7CwTLVFdCY=_c7-eag@mail.gmail.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Skip ELAN power-on command after reset
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>,
        Jingle <jingle.wu@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

On Mon, Apr 12, 2021 at 6:20 PM Johnny Chuang
<johnny.chuang.emc@gmail.com> wrote:
>
> Fixes: 43b7029f475e ("HID: i2c-hid: Send power-on command after reset").

Note that the "Fixes" tag actually belongs down at the end. It also
shouldn't have a "." at the end. Presumably the maintainer can adjust
this when landing?


> For ELAN touchscreen, we found our boot code of IC was not flexible enough
> to receive and handle this command.
> Once the FW main code of our controller is crashed for some reason,
> the controller could not be enumerated successfully to be recognized
> by the system host. therefore, it lost touch functionality.
>
> Add quirk for skip send power-on command after reset.
> It will impact to ELAN touchscreen and touchpad on HID over I2C projects.
>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>

This patch looks fine to me, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I can confirm that after applying this patch I can recovery my borked
touchscreen (which got borked by a failed firmware update ages ago):

Tested-by: Douglas Anderson <dianders@chromium.org>
