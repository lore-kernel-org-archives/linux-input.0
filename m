Return-Path: <SRS0=6uoY=EF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878AC4363A
	for <linux-input@archiver.kernel.org>; Fri, 30 Oct 2020 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E16222C8
	for <linux-input@archiver.kernel.org>; Fri, 30 Oct 2020 10:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmnG804R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3Kwy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgJ3Kwx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Oct 2020 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604055142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/tnpVHIMYpFd1srPSH8uONR7RCWAfqrebxJ6st1yKpM=;
        b=SmnG804RP01GsuMXRF44513H5A4jQtpBjQqcsNiPtA8zB3Uxvdy6TBkcqsXW0M1VqWUgZ1
        Ov8Q5G3hca+SEG0VPb1dmScKFl0Vl/kSpPMb5PwvSlqkOVA0FL7u0ECyKKP4Ne2gA+llu1
        +JVr66sla6Ay3H/ON4QKRvXsNPZUhog=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-Sgu1SBUrMfyFueVJ5cvwyg-1; Fri, 30 Oct 2020 06:52:19 -0400
X-MC-Unique: Sgu1SBUrMfyFueVJ5cvwyg-1
Received: by mail-pg1-f200.google.com with SMTP id 33so4364560pgt.9
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2020 03:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tnpVHIMYpFd1srPSH8uONR7RCWAfqrebxJ6st1yKpM=;
        b=kIjHIwmsqqDEG8xr6flOwk+wvYN0aJ90uUWpm3Oo1ax2FOMw7znyCsOMdGtymQhS2A
         qaEFt0ljuDHuLN7imAxAjy0b5l8ApZGrVRad1ruJbox2ZNwoYXllSuHQrlTjum7NgJoX
         CBWyrpqyA9igjPZlTJi7weZflzB6YIzbcABPeqnMAlJDX2SXtXeQjbynjh8wlGsxT8qE
         /dY1RwEYjJs2pJVTcvX9+5DPL0BfWSRVM2iH/Y+KgQXcfSfFJRCOR5fcTvnDkdQ0Mj9N
         12G0Dha0yexudBIHlxppVvACfhZFdQmfMgVKMjdLwj2VT8LC8Csksa11buq4Fr8zUtc+
         IiMg==
X-Gm-Message-State: AOAM530BHMGfpkYJJMYh4+d8tPHtEcp5l1RAcwhJZn9AM0Iu23y7yvpw
        iMxJxN4eOfslBY+f3KPSAzOdXZpSduqKqv34fZ+j1P1lUl870jf9YeOp50qf/YAgN0OHhZt5voF
        YRg55zAb0ous4FOuZN87StZ0tTamISR39MyFNbHA=
X-Received: by 2002:a17:90a:d795:: with SMTP id z21mr2084273pju.56.1604055138433;
        Fri, 30 Oct 2020 03:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqfUY5TSSruhXVNF2Ob/Fv4sN9KGKR2ZqJAnxCFvwVKptzWk1DP09awzgBvZZwKt4ADZ5ClPghjTDQUQhfv2o=
X-Received: by 2002:a17:90a:d795:: with SMTP id z21mr2084242pju.56.1604055138246;
 Fri, 30 Oct 2020 03:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
 <20201023162220.v2.2.Ibb28033c81d87fcc13a6ba28c6ea7ac154d65f93@changeid>
In-Reply-To: <20201023162220.v2.2.Ibb28033c81d87fcc13a6ba28c6ea7ac154d65f93@changeid>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 30 Oct 2020 11:52:07 +0100
Message-ID: <CAO-hwJ+PbcsGNojeJd89TCv-1GQ0fEqcezZ8pw6qA7jjvGo5-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: HID: i2c-hid: Introduce bindings for
 the Goodix GT7375P
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andrea@borgia.bo.it, Kai Heng Feng <kai.heng.feng@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Doug,

On Sat, Oct 24, 2020 at 1:23 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This adds new bindings for the Goodix GT7375P touchscreen.  While this
> touchscreen works with generic "i2c-over-hid", the current advice is
> to give it its own compatible string.  The cleanest way to do this is
> to give it its own bindings.
>
> Among other things, this has the advantage that we can list the two
> possible i2c addresses for this device, which gives extra checking.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.
>
>  .../bindings/input/goodix,gt7375p.yaml        | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> new file mode 100644
> index 000000000000..b5008f89e26c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/goodix,gt7375p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Goodix GT7375P touchscreen
> +
> +maintainers:
> +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>

Given my answer in patch 1, I am not very happy being added as a
maintainer here.

Cheers,
Benjamin


> +  - Douglas Anderson <dianders@chromium.org>
> +
> +description:
> +  Supports the Goodix GT7375P touchscreen.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: goodix,gt7375p
> +
> +  reg:
> +    enum:
> +      - 0x5d
> +      - 0x14
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    true
> +
> +  vdd-supply:
> +    description: The 3.3V supply to the touchscreen.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ap_ts: touchscreen@5d {
> +        compatible = "hid-over-i2c";
> +        reg = <0x5d>;
> +
> +        interrupt-parent = <&tlmm>;
> +        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +
> +        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +        vdd-supply = <&pp3300_ts>;
> +      };
> +    };
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>

