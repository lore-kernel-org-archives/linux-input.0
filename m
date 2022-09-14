Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284DC6FA82
	for <linux-input@archiver.kernel.org>; Wed, 14 Sep 2022 12:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiINMg2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiINMgW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2022 08:36:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD87696C6;
        Wed, 14 Sep 2022 05:36:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so14192141pgg.11;
        Wed, 14 Sep 2022 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=t9EOPPmEMjXou3QoMscAdDCR+k+XQCqxOOO6+v17FrQ=;
        b=goKlddP7Lj/NuKl0wW1xZK3+Ck3DAOxaUTreAlNd7oJU2Q57ZfxOb9PbHLg5ASzT92
         B30n+zPSgR6kxuAMcyLxyey2jIrgl7eqLpqpHCSDg7OzpzMBGV82QbT8RuFPrQ9Ub94k
         ffnq4jQef1iMiV7t1RP2hh1ftAwQTkLO9YJKg7LmzuzhauhSLTrto0XmNCfy3mrUGorq
         6EnTIGJ61SgXy3ZOMshKwmQb+/V/GrMm8wSAmtcPxX94IBOQnhjS9PvaX/LP4Bj5fcSz
         hCaFFI5B7+bcfKbAKWT45HcM9aLts+kKhdP+W2yAN2MOyEJ6OQC4+wSYQB9dyg6KmKze
         7prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t9EOPPmEMjXou3QoMscAdDCR+k+XQCqxOOO6+v17FrQ=;
        b=B74KzBcwEzlXnyYmlPbwrfu7I/bMuSdDazvUWx38D7wm8r4J0Y4vIoglrMhiWnBARZ
         nvRERLep53i75PiM4OWbmxgXEE2IQHBIcLnKpcYyywP1yxgI5zM6jZX0LZ2N7ZUWv2CF
         hROsYr1GSXfgY7gR+e1M5HnCDcgSi1b/MQ7HoelWDizxcKM2C1ZeELsNyQkSJgpfNUn1
         jPTXIm7kfvKH/W8bgfji2vDVdrQArHB3iYytyuTltfSiBYyKGGahNaLMJtQxU/e+wfo1
         3Psi/XjUgDoepDeLEd2op11PpVtJhfHu0G5Xqarx5vP/oWDgdBJST2HE3cBmJEQ3Bj+N
         Z5tQ==
X-Gm-Message-State: ACgBeo1FnGdLqoJEiFYcmaqVCHmuNaFh6RDgw4KUYD0mdsqjfKl7poQE
        xaVa6W656o7XFEeNKbmdTaQ=
X-Google-Smtp-Source: AA6agR4jzM41W1qWUpppP7lAZA/fIVJ0a3mfxm1PNEJJcB3owasYDweifbJ6lsWgpMLWAo7sQm2c1g==
X-Received: by 2002:a05:6a00:1911:b0:545:cdf0:a61f with SMTP id y17-20020a056a00191100b00545cdf0a61fmr8399843pfi.32.1663158973090;
        Wed, 14 Sep 2022 05:36:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id y65-20020a62ce44000000b00536816c0d4asm10283973pfg.147.2022.09.14.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:36:12 -0700 (PDT)
Date:   Wed, 14 Sep 2022 05:36:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-input@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>,
        Matthew Haughton <snafu109@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: synaptics: Enable InterTouch for the ThinkPad P1
 G3
Message-ID: <YyHKuppcyFsWjTa8@google.com>
References: <20220909202127.141761-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909202127.141761-1-lyude@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Sep 09, 2022 at 04:21:26PM -0400, Lyude Paul wrote:
> Noticed this while trying to debug some unrelated issues: this laptop has
> the ability to use rmi4 but doesn't by default. So let's fix that.
> 
> Tested locally, including mouse buttons, on my ThinkPad P1 G3. This might
> also enable the X1 Extreme G3, but I don't have such a system to test
> locally (presumably Mark can chime in if that's the case).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Mark Pearson <mpearson@lenovo.com>

Applied, thank you.

-- 
Dmitry
