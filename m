Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE9C433EF
	for <linux-input@archiver.kernel.org>; Tue, 12 Apr 2022 23:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiDLXf6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiDLXcs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C15C4E35
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2022 15:20:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so78180wms.0
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2022 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QMR6lx7WMoCdegQHQIp637QYsvU6+ltNhqOFfDF2Lck=;
        b=GwzkPE/FrAYSYvj1YZdM1ifPs5j/ZSCulhiHdZ/wPAIMW2o9zw0Iewo5FhxtBG8is5
         LtaWbh7YBWbCSGTIfdCOa5oEjvghI0cMjGGJ89hWkfueAmsMs7DhjHo/b4jUXVcUwnzM
         LGxLKk7Znuiyod7NS0X5dlOimWG1/FiCf4rN41h5ZOGQ2HUpRhD/2R/joO7miMou6xKM
         Qo1GwfUjFrLV/pbCMkQUwEszsznu2Pkxv7KFdhMGQ+6voKmMoBoJPX4eQ8t2YRepKfY2
         qTa/j/9kBA5ZWSc7jAgzv8EOTVLST1XzTV7sOIBgyhUEjFiNi8+JAiF6z7P7YEUofbV9
         p5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QMR6lx7WMoCdegQHQIp637QYsvU6+ltNhqOFfDF2Lck=;
        b=rN2YXnAZgMv+niobu8AGJ5PPZma992GZ3Yvgv6a03JzWCcdnjiZCx3BJ6X/snTI77u
         kaN7UK5Dp/W7fpB6kwjHCzJ89grA4/bAnSFQJMsJoi1vJfUAu6uE4oXtL8awey7bifIs
         RuX+Zfr5jmMXUOTtsSq4zJRetM9xr4q9z3iyLAbGGf/mxd3R+8RPQzCm09p39pW6aH9t
         8r/87KUULBEstvuTBwMLnTfktEVj4qtF58BLjvv7Z/4huPNffX7MhLA52pk4yqTktshZ
         J9A6KPGUUaK2jrBhJ07D0cxYRup8NX1+5U4AsPVrfrxMwPFDw/IW2WQaMbAmfWKXAM/s
         2PZg==
X-Gm-Message-State: AOAM532wd0Nw5QdD/Uug37hDUqpFvStQFU4tGjLFWv1GWnxefdZiZqwH
        AirTEgjyt3MiX87vv5eAuue9D7Xcs2jn/lUTaE+/xQ==
X-Google-Smtp-Source: ABdhPJzqkbWNNUql01VC8IRTGAJWTLrraa3k3BalUDO8lzcnFDV5OWJzELfFvFWZn1boq9gyZDoNudu7O/uL8uMU7XQ=
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id
 n1-20020a7bcbc1000000b0038e7c42fe38mr6029946wmi.51.1649802017276; Tue, 12 Apr
 2022 15:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220405183953.2094007-1-pceballos@google.com>
In-Reply-To: <20220405183953.2094007-1-pceballos@google.com>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Tue, 12 Apr 2022 15:20:05 -0700
Message-ID: <CAO9JgFyoqTn5A01EU4NHsbfZyKxxzo6qVvsDHCZSUn1QwdoQgw@mail.gmail.com>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Apr 5, 2022 at 11:39 AM Pablo Ceballos <pceballos@google.com> wrote:
>
> This driver works around a problem with the HID usage sent by this
> device for the mute button. It prevents key events from being generated
> for that HID usage since they would be incorrect.
>
> Signed-off-by: Pablo Ceballos <pceballos@google.com>

Following up on this patch request. Please take a look.
