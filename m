Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF45C433FE
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 01:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2702A207D0
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 01:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLJBpt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgLJBpp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2020 20:45:45 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BEC0613D6;
        Wed,  9 Dec 2020 17:45:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q22so2504680pfk.12;
        Wed, 09 Dec 2020 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRzjXVEuVsNu05zWcfeAdgQ7eZnB+QyGsDIiUZ+Q5VM=;
        b=Q/mWdWTckv2a1UTyiaqjjDIJtvteYJ6eMKQ4v2bHouZJaeGVGzoMNgQR+Zu3MIKZg3
         2CRM8Z7fdbGtYvmSDiJgVBGaXEqb0DogDzTOO9RR/Jm3xOSVraPUEAbb4SjHUKlXPBLp
         opGrOYzBU0jGZUtp9aFRAPCYM57STVSbaBYSb54jsZyC/+xPIwANYmf4x9Rz5eTidGz4
         w6hxhEVxMhBo9ScmyyUA9squyKgLaAL39fQzuneuR9XX09B6ijw7249+VU4v32hBlkwk
         qr0UFcbhRUfTqPAbJ+YvYgr8l5SHe5KnrXNQsDqrpFchurMZJ/yFIeDVsLEZShO1TghS
         oluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRzjXVEuVsNu05zWcfeAdgQ7eZnB+QyGsDIiUZ+Q5VM=;
        b=HX3BnpLpLcpGzEu+ffW5mx1pOk9uzw+6xwyO2WLweeVYrZzeBSDIyYnIC3Qm3DdgHo
         VdaVArYX8V97KJ99JV5qEe6ibiRO29HY0Q98lgOTVIP8gWhYzadoTD9ZF/goZIuF9IZa
         7Duo4dCkXp0M/RHvG17GyEGSCYWVoUVUd3lc1R+27xqP9xAogQBXwaoha0UEv0nh42Hj
         0PQWhmFJPkK/ShH9+K9PgK8mZwsGjD5Nnwmxo8xwDe+pDEcYaYe1yYsMKq5R7FOBVoyL
         QAk50CHpcbZS3sjElY1c98jQ8cpv1yIUdUKkEbUAs5Ys1szCRmbTxWZoGbnhfteynyix
         SP/w==
X-Gm-Message-State: AOAM533q4k4roN9O8hjHq8I2Pw1BU8C0cgAWrdDs0xkDK2iHRn3RA8/j
        i13yi2FvOldieCQwe8Y9OnA=
X-Google-Smtp-Source: ABdhPJwoQUDye2QAbGoCxFqk1I2jmRYoNHp9RA7LTjg3c8x3JOX4yGDZpIC9x7NrCUxxXhUxdQM6Mw==
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr4764702pjb.98.1607564705189;
        Wed, 09 Dec 2020 17:45:05 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g85sm3951173pfb.4.2020.12.09.17.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 17:45:04 -0800 (PST)
Date:   Wed, 9 Dec 2020 17:45:01 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: input: Add Dell Wyse 3020 Power
 Button binding
Message-ID: <X9F9nX2VnITA8oYe@google.com>
References: <20201201083533.1724287-1-lkundrak@v3.sk>
 <20201201083533.1724287-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201083533.1724287-2-lkundrak@v3.sk>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Dec 01, 2020 at 09:35:32AM +0100, Lubomir Rintel wrote:
> Add binding document for the Dell Wyse 3020 a.k.a. "Ariel" Power Button.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Applied, thank you.

-- 
Dmitry
