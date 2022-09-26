Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C7C32771
	for <linux-input@archiver.kernel.org>; Mon, 26 Sep 2022 22:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiIZWQ6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIZWQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Sep 2022 18:16:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C0C69F7B;
        Mon, 26 Sep 2022 15:16:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso8289211pjm.5;
        Mon, 26 Sep 2022 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oazF4s5eiGXcwOUykRDQFfxqhajqTyICeqJarqKGY9o=;
        b=XIL2PTlm/aqtXqyPueCBxESVe5QozV+ibeioAVgVOXvX8CFxHDzxZqc+HqvBBbVPlO
         7hEwOoDvWz5/WblTR8+kYCbEAdKidxykLItG6THXD3yI0oi3VcKIlLIy88jVAxLR76V5
         OLxwgi8ka6TkoX1o3rVBdRaXgJlSKArR3iGwJ0jXWcXsHF8MDwKXamWH8ivk2Pc9amaL
         vHWgkUGRpnMDkNp++e68yUxirXwyftAW5Ga3iQ7AMKJJxh//Gt9MZqo83a1ufFeqQk/a
         g/7UUb9NL5OO3vff+JGWq9OPs0oo3YbStcZ8/Umi8fPNQGBo+8MQwBnnSR+3g9UFSTtk
         O55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oazF4s5eiGXcwOUykRDQFfxqhajqTyICeqJarqKGY9o=;
        b=PcXzbQthSxb47YH9UnqMuwAY7EmzaYl0qmk2pGFgQyZxpqMFE4A+B/Vbyzzqcwj/Dj
         2LzXEx0tYamHfSlTJideHjkB/Itv2RrZnk2X+6fbI1jZuWdeJNVpcaH0U3USEmS4g4XR
         dV86kGGzsmvtJyXjE8HCX9f8qxcqoJl8AA1NgkxhA41pLm9s3eRc6XU1jrVVKEh+0Nuf
         iA7acNtJ7PjlHCTNrd14oEO8lppa1fy9va1w3Fe+mStjSX2JVh2ClajHZdHorXQKw8j3
         Tmbh3IaE4RHEdH+Ql71TNbap1KSySvWloVReg/7qEZJXjq8/EE5CYv3uy+eUbt3MyrFS
         E0mA==
X-Gm-Message-State: ACrzQf3etno3bCmmijWHNj4poTFhD6XFa3xn2JDbhtVsj7NdsTZQlw2+
        wtMNb/gIGV884jzaRRF89MI=
X-Google-Smtp-Source: AMsMyM4zfCOrW6c8dFVl/lqGTyuO4UDdrKbCCcxvswu52P/TOUvfT9507iH9VI3WF5H6nFzZ/TOp1w==
X-Received: by 2002:a17:902:e5c3:b0:178:192c:6b3b with SMTP id u3-20020a170902e5c300b00178192c6b3bmr24707881plf.92.1664230510936;
        Mon, 26 Sep 2022 15:15:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001782aee4881sm11857355plk.153.2022.09.26.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:15:10 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:15:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Input: applespi - replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIkawisbFn7njJQ@google.com>
References: <YzIeJeqU73G+UI8g@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIeJeqU73G+UI8g@work>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Sep 26, 2022 at 04:48:21PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/219
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you.

-- 
Dmitry
