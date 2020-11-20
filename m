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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F75C56202
	for <linux-input@archiver.kernel.org>; Fri, 20 Nov 2020 03:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED5122267
	for <linux-input@archiver.kernel.org>; Fri, 20 Nov 2020 03:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0AqZHSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKTDQl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKTDQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Nov 2020 22:16:40 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCAC0613CF;
        Thu, 19 Nov 2020 19:16:40 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l11so4140129plt.1;
        Thu, 19 Nov 2020 19:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUUmJFtbEn7lv6bZBiqADWPPqArQkKReAI000AwlUGg=;
        b=c0AqZHSz7/xewBlj/zUtvWn1KLEJYQCDUiH85+5SGQtWhouZJRm2Rdd48P3mT2o+vR
         ZsKPkhHgbmiXZn05XcWeZWjbB3BS0WtHNYEHlvniTdOCu8n8OKifiyqTMKeMzH0jkD/j
         /3gxxCaTipzf4/qYpAQkIeJX6M8l+AkHUyfemFbbsw4P0dJEKyV9P7BQF7hy0JZ37AcX
         5m6244/wUPf1kumK/a8+X2jq/wGMgSgaKQqNHmcrb/0oMpX3UmZgqtTceOVjo6posWem
         bPw0JKgb8NSssXFchEqGMYT/0h/VTROEDiUnEvzRLZLB5xEcAApw+zd0Mi411SGnKIzb
         /yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUUmJFtbEn7lv6bZBiqADWPPqArQkKReAI000AwlUGg=;
        b=jpdZD5SpDsSKchvhrtdDbl8dgshcf4e+QB0NF3T1w5u7WfGjSMaMRNmCoFQcvXF7Kp
         crbjZd0h2b1ivc4ZozBP5bha7GT/Ydd8zvZOq96aYZM/oysUcJst+O5UirW4L6qaw/CY
         m+Pc0d+/Maf8ZQ/1BkNpcK9RX5lN5RsqKbfJPvIs0kTfyqrNkTiBe1YqfLnNu6MtSyX7
         pOZHDjhkJZ/2/tQkXjUh2HtdAQGxThVWcJLNgW25VeoI42f2/ui99uMYZHv7/Iil4GzF
         fn/HKHjzBqx+13hr7kKK7zNyKGXx05tzRKnbWm+S/izjcy41gutF+Y5VgtNWPuhDoF0Z
         5rMQ==
X-Gm-Message-State: AOAM531Y91607LCM4m50zTqZtr7KBQvasMzMSFaFa/K9/vTdYzyqo+N0
        VKRI8dWwUOUmltRB4g86Qe2vsOKseiY=
X-Google-Smtp-Source: ABdhPJyUhce69Md4r3qWdyeIVW4xj4TmKN3HcKQtF5B6d4s5452rj+xuNNg+Do4JCPSL46t0MaMTSg==
X-Received: by 2002:a17:902:ba8b:b029:d9:d8b9:f2d7 with SMTP id k11-20020a170902ba8bb02900d9d8b9f2d7mr6222657pls.77.1605842200307;
        Thu, 19 Nov 2020 19:16:40 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id y20sm1444734pfr.159.2020.11.19.19.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 19:16:39 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:16:36 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "K. Merker" <merker@debian.org>, authored by <andrew@goodix.com>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 04/15] input: touchscreen: goodix: Provide some missing
 function parameter descriptions
Message-ID: <20201120031636.GN2034289@dtor-ws>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
 <20201112110204.2083435-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112110204.2083435-5-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Nov 12, 2020 at 11:01:53AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/input/touchscreen/goodix.c:569: warning: Function parameter or member 'len' not described in 'goodix_check_cfg'
>  drivers/input/touchscreen/goodix.c:587: warning: Function parameter or member 'len' not described in 'goodix_send_cfg'
>  drivers/input/touchscreen/goodix.c:1165: warning: Function parameter or member 'cfg' not described in 'goodix_config_cb'
>  drivers/input/touchscreen/goodix.c:1165: warning: Function parameter or member 'ctx' not described in 'goodix_config_cb'
>  drivers/input/touchscreen/goodix.c:1165: warning: Excess function parameter 'ts' description in 'goodix_config_cb'
> 
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Henrik Rydberg <rydberg@bitmath.org>
> Cc: "K. Merker" <merker@debian.org>
> Cc: authored by <andrew@goodix.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied, thank you.

-- 
Dmitry
