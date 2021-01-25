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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D37C433E0
	for <linux-input@archiver.kernel.org>; Mon, 25 Jan 2021 04:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C1D2079A
	for <linux-input@archiver.kernel.org>; Mon, 25 Jan 2021 04:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbhAYEQ5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAYEQz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 24 Jan 2021 23:16:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C6C061573
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2021 20:16:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx1so2083123pjb.1
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2021 20:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67HLDEP0BeEl17m8OBHm6nQN6udcTeFi8K+uUdMXjJI=;
        b=PbCwJImurhTWKvu+G6SkSCjA4MXJ15MqFlUzkinoZ9o5FkRyeSrtuSBdmHo/M71I/B
         RUl3qe0pdvFu4iiLlZd0P42QBTc9uxTU79Q6voF/F1Y8S6foVbmSrJJZ887eC6P7CqVc
         hwbQZIEeUjGgmsFYa7qiD0ufJYA1hA2OlHyzR8MCE/C2w4pDn9wWrXRwQlIHyAbh05Jh
         AW4W0yFXw5k6pQilmrTNUjrZanyEJCAEJ7tPbmZGAq6fE5kcoWeEkAqg6Tj1FtOLsFB6
         AnodX/GpdgpCxuEO+WO31UTw10jK6uCj2ZhfD160BqNeejKiiQ2u6OS2lOOTMK8EB8Lo
         33Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67HLDEP0BeEl17m8OBHm6nQN6udcTeFi8K+uUdMXjJI=;
        b=OtwYKlte6tTvL/ucU8wJT1td0rkMbDqnt9DnZi1GjrUB8+JGOyvmS4mPElAs4eLY9T
         7QvHWATJ1E4MZih1bqH9Z1ezsz0/pSfqcsd0q+z+sLIEzAlRL1mkX05RW/u9iS8e0Bq+
         1iPBHmVsdVT+BL7HVX+GaWshjEx5SfhXRnBhJvrkmltzVEhttAFeQLRuS5Lzpdk9AaCm
         uJvgjPxFs21UR6YcCrjiqYiy7Gmi5GIjPt6igPnwx6zuLKybNCHhhBm4lYBGvDtpgxne
         YPBWYC1/z12i0Psh9BK8ZgdZuO1r/CalLc1teikVeAjafHlaZl0/hp2XfJ/eeca8q41y
         PPnA==
X-Gm-Message-State: AOAM53263+gQELq3mX3I+eJqIwXjfIz7Qb5LPat2rIz7H0j3cxuEktu6
        wNCKEj5VTSBlzHsd4qOxu64=
X-Google-Smtp-Source: ABdhPJxBrwxA3D5QC5NyIGIy78TdkPadhqFvZ+4elwLPvnmiIZIZLcWiynmCT+19x1xydPVV24hJmw==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr613514pjs.50.1611548174786;
        Sun, 24 Jan 2021 20:16:14 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m27sm14673696pgn.62.2021.01.24.20.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 20:16:14 -0800 (PST)
Date:   Sun, 24 Jan 2021 20:16:11 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org
Subject: Re: [PATCH 01/10] input: iqs5xx: Minor cosmetic improvements
Message-ID: <YA5GC2iGbgBow21J@google.com>
References: <1611002626-5889-1-git-send-email-jeff@labundy.com>
 <1611002626-5889-2-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611002626-5889-2-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 18, 2021 at 02:43:37PM -0600, Jeff LaBundy wrote:
> Copyrights are generally followed by the name of a person or a
> company (i.e. the copyright holder) but that was not done here.
> Fix this by squashing the 'copyright' and 'author' lines.
> 
> Also, trim some leading whitespace ahead of the parameters for
> the fw_file_store() function and re-align them for readability.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Applied, thank you.

-- 
Dmitry
