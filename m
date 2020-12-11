Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F86C4361B
	for <linux-input@archiver.kernel.org>; Fri, 11 Dec 2020 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5969523F2A
	for <linux-input@archiver.kernel.org>; Fri, 11 Dec 2020 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbgLKG3i (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395494AbgLKG26 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Dec 2020 01:28:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D1C0613D6;
        Thu, 10 Dec 2020 22:28:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so6381776pfc.2;
        Thu, 10 Dec 2020 22:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ub7DyS9PA25JldfkrO2m9b6EnkWTqnXMr2TKEx9tVag=;
        b=Q8fMOaUtBPkNnt39n1a7MHMuzveCEsVFGsvRYuRE0WdxKqoBZUQGPG9WHSlhViLR/Z
         VhOdsfaj0543oWfi/IpgKwKqurcS/rqH5Bb7z8y8WEGJVSYZg9sfXKYhkCU4qqyNXSGJ
         M15VcOQv0qGLck0sXUE1v7PBRq2lNuVmW0l7OfURvrw5mjK4NXChwDGgjvGx1ofGfMSq
         9WQJHyba+LJOEmnvczZY49QXn/dAYkNgVRMqKHofMuUkJ8+6p3MCtHghmK61I3WJj/1j
         Ahd1K4ywvuXPvNdEWGW29V98QtUHwc71MiuwIsX8kgWu5xfy41wkDSgC5FKAFsWwvSvw
         Uf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ub7DyS9PA25JldfkrO2m9b6EnkWTqnXMr2TKEx9tVag=;
        b=NWju0g4n4NlVknuH1ENz+4dPPVx4bVQfmG1ISZlayuoHBmkPgOltiKnO3vucqGHIGc
         7n1hBSg1hB19CCxsNuEb45TzOPsfytBn8wSB+YIhXI6kgcO61ut+9f6/LGYAAmXI3Yl/
         17MmYe3qoplsGBm4+RrSOKRCZKC/xigwJ2DL+hjIZzuEQih61pASq7SwfuYgpOmBI6cw
         V46K0Mx8CYrx2ccqBHbUZPoLgN3TMYjOzHWmJ62u334735Nfzb0RMfEx4okv5swomb6T
         3l7ghNi3tfD5MiPQLJ9AFNn4O9UZH2ru0ZYVlPfdjAQeo6SJFmDYcTY2RZCZ6seiGgOk
         VgyA==
X-Gm-Message-State: AOAM531w4Cdp+9Q1zngValv+YH0JV/ZTTj4vO552l1P7gG+OJR/OAgn6
        yYsB90IraMGz6hRVEUAY/uU=
X-Google-Smtp-Source: ABdhPJxnQwtUJlUCLL/m+sAr/5zVMIrqpTTLg1ZNwDEfyCeDPbKj+/oUnFqng6zQ3LZeq/Mz2gx7TQ==
X-Received: by 2002:a63:5416:: with SMTP id i22mr9923739pgb.8.1607668098229;
        Thu, 10 Dec 2020 22:28:18 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x28sm8473997pff.182.2020.12.10.22.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 22:28:17 -0800 (PST)
Date:   Thu, 10 Dec 2020 22:28:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     nick@shmanahar.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] input/touchscreen: simplify the return expression
 of mxt_send_bootloader_cmd()
Message-ID: <X9MRf7Or2Ntvbh+/@google.com>
References: <20201210135943.1612-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210135943.1612-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Dec 10, 2020 at 09:59:43PM +0800, Zheng Yongjun wrote:
> Simplify the return expression.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied, thank you.

-- 
Dmitry
