Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3679C4361B
	for <linux-input@archiver.kernel.org>; Mon, 14 Dec 2020 23:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F6122509
	for <linux-input@archiver.kernel.org>; Mon, 14 Dec 2020 23:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441398AbgLNXAo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441382AbgLNXAj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Dec 2020 18:00:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C5C0613D6;
        Mon, 14 Dec 2020 14:59:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s21so13189126pfu.13;
        Mon, 14 Dec 2020 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1bmGpmtuRmE9WHpd0HJV3XTyYY7o81tGpyd74gQHDg=;
        b=euwtSzdCiuOpFvwxEQkIze6QzQX2vkCfeHcVw9xwImSdmzrQeEtMhf7/MvLaAHU+F0
         78Xmcg/n++Ti0wHmYodFk+5n0zMKYg6hsfTPxOMBEAlfIefxYQVm/phQ1YasDdIawIhs
         1I0O9rY1tMD1uC2cFYEhBorwPSRjfCiA9dj7eCeq7YB37kH+W7qPMTGLSjhgDtHKSi4Z
         Tfg4PhTakzjy2suri9jmR5U1gT9Mu7n6nlHjlymPjh4jUEw2HPrM/l6rwBFD6dN+UUcn
         TH0eMwmE1kLN/lg5qj3A4kuYLRUQ+JIoC4swoOma3eDM6OVLWlpyeXo4JszF+dcJ0DlJ
         eVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1bmGpmtuRmE9WHpd0HJV3XTyYY7o81tGpyd74gQHDg=;
        b=b+pdXmBkNGaJ3vgvgDinjFrrSS/Z0SGbCg5bDOE5/v7ZWAWOTZ1WrMUztP7kAXNxGn
         +qysCrSaMU56SJkIx/DPooEbhYgXmDlB3iqhF0WrG9xKEVyms1SxczCSdGKV71/N35VX
         15qkWzpzr3CsvPbOla13R43ZrrqpMO/zgZO8GrZgtxbfHCmZuP5fmw0RO+AYPO85Jg5O
         A8UdHQUCEtVj92APIjxU3PFXVxZc5aaI2+8Moaa+YLRsaPgMZgFreAQswumrZjqdz5oD
         MtF+M5fOyQaz7//t88J/9K3CBSPT/w5pG+l2Iv1Y+wdoXPzAgxaBny4Tk8oP9TM0D4Kc
         pfNQ==
X-Gm-Message-State: AOAM530Ke0GO6U08atzBf3RD6i5lNBIuJ156pjGglECHaG4AamN6zXuy
        m1Ft5Oa+x05KW7t181y/tLI64fytkFA=
X-Google-Smtp-Source: ABdhPJwgeyQRN3E55Cq/DfyW7pTyckIhnJEvYqlp1kbaKLbtd5L8vnFbJMVQWCdZr+0XyN12ypwp6g==
X-Received: by 2002:a62:7c4a:0:b029:19d:b7bc:2c51 with SMTP id x71-20020a627c4a0000b029019db7bc2c51mr26537354pfc.30.1607986798579;
        Mon, 14 Dec 2020 14:59:58 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id 82sm21947206pfv.117.2020.12.14.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:59:57 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:59:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] Input: da7280: fix spelling mistake "sequemce" ->
 "sequence"
Message-ID: <X9fua+GJ12yawoTM@google.com>
References: <20201214223109.82924-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223109.82924-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Dec 14, 2020 at 10:31:09PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

-- 
Dmitry
