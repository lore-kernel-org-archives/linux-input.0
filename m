Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24601C433E0
	for <linux-input@archiver.kernel.org>; Tue, 12 Jan 2021 23:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFD52312F
	for <linux-input@archiver.kernel.org>; Tue, 12 Jan 2021 23:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbhALXaD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Jan 2021 18:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbhALXaC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Jan 2021 18:30:02 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791FFC061794
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2021 15:29:22 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id z1so413754ybr.4
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2021 15:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1seuFAYIbhLRjf8D0C4ZsKHbwGrH6A/TbShGVmd5uo=;
        b=cwO1sEjV1h4NVsOFaISyMfdqqMJfHtXNPyvxr2Gfm6mPYBRO60Zb6pTcwmWCwdT+pb
         OZNRny2bvukSOjPndOUrsEa68XCe/6fEMIfz2/RJmzym5RtuLTIM+weqi9KiEA3B6U63
         aIU0VGwFrZ9XKZdofR8gP8ukAmIvjGvwrUszo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1seuFAYIbhLRjf8D0C4ZsKHbwGrH6A/TbShGVmd5uo=;
        b=SN9DkXXugBWyjHp5rw6sPMZ/UTuR9i3GX5+FqKvdRPU8JFn8QU081YDTNkyYchCa6F
         yykKfgrZrahMIsXc4K5Loo4yNcz4gBzcKjaR3RnQn72+bAxrSMy1pAY4uIVrLzGL6ncj
         PFBNGrdfcIbVSLx7xxvCJQFyZogjcWGUw7YMpIuQVbGBhBLxD5VyCnVLnEOE/qF8I+ni
         IL3+1hGuBUO5oy35EEYcc16SmTxrIiTYJaln87eakzb2MntRjVuprDZ6Xg+Q+Ir43tdi
         zB3RoUXV/JcMfpFsgdoAufBqFoHWwBHQ/GQ5SDGZbQz8uoINRBwtircpAmn+CBvLWgLg
         2HJg==
X-Gm-Message-State: AOAM530rTljmK/KP/sVNSDiyHghnQqt3kxuPFEu2Tj/55ZFF01vSHEZo
        kfVgfNiFiNwkG0QP0lhQCBJplt5sXIncG7+kVPNLhw==
X-Google-Smtp-Source: ABdhPJzg3f5FyC7kA1rl+eUDMIlmHup89eW+40+ekVov/RjOLdGoW12i6y4CT4/3T0jTZHB9F3uBtlSmyJMs6PkpKsc=
X-Received: by 2002:a25:3a04:: with SMTP id h4mr2589314yba.285.1610494161587;
 Tue, 12 Jan 2021 15:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20210107154200.v4.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
 <161041741167.3661239.13546059654424804588@swboyd.mtv.corp.google.com>
In-Reply-To: <161041741167.3661239.13546059654424804588@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 12 Jan 2021 15:29:11 -0800
Message-ID: <CA+cxXhkXJGYx0SQ-S7B=6iHAWFoCQpokw7huaGTNKbVmP1JDhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 11, 2021 at 6:10 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-01-07 15:42:08)
> > This patch adds a new property `function-row-physmap` to the
>
> From Documentation/process/submitting-patches.rst
>
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.
I was aware of this guideline, but I thought it only applies to the
summary line.
I'll apply the guideline to the whole description.
Thanks!
>
> > device tree for the custom keyboard top row design.
> >
> > The property describes the rows/columns of the top row keys
> > from left to right.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> > diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > index 8e50c14a9d778..7acdb33781d30 100644
> > --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > @@ -31,6 +31,16 @@ properties:
> >        if the EC does not have its own logic or hardware for this.
> >      type: boolean
> >
> > +  function-row-physmap:
>
> Is there any minimum/maximum number of elements possible?
The maximum is 15.
There is no definition for the minimum - we can probably say the minimum is 1.
>
> > +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> > +    description: |
> > +      An ordered u32 array describing the rows/columns (in the scan matrix)
> > +      of top row keys from physical left (KEY_F1) to right. Each entry
> > +      encodes the row/column as:
> > +      (((row) & 0xFF) << 24) | (((column) & 0xFF) << 16)
> > +      where the lower 16 bits are reserved. This property is specified only
> > +      when the keyboard has a custom design for the top row keys.
> > +
