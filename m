Return-Path: <SRS0=EPtW=ZH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3473C432C3
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4252073A
	for <linux-input@archiver.kernel.org>; Fri, 15 Nov 2019 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug1WKlij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOTe3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:34:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42874 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfKOTe2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Nov 2019 14:34:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so5329096plt.9;
        Fri, 15 Nov 2019 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+GnL2CTwPY1SJF+ZHQ2vaGRIXzp75okBEaSUwWtgtfE=;
        b=ug1WKlijVFaUOgtsqx/lnHj6X9grp7mHSvEDhP9iw6gqOXYKOLJFwlQ0xV9MpLk+s6
         cZoFm4V7iMvpAkaXpnpl6Uxag9rYaBnjjLyLtWsPnjgff4IwoIo375mB5VY7MR0gBJwV
         HQGEKTWT1ZgfttmN2hH2ArPTLRqcMcg0WrNYM2ANxH4CWKclaHA+GUXDPR/mzRIFHN/8
         g0JXwZs9FXhFnGdRdmYJQqJJNISSWuPVr5eFA8MvbQ5sFPxGh1lcCv1V1eq8wcgjWTFI
         ymu3qoTC53V6e3z9Iy3AzTLNwgw+6K3FFrVYYCox1W6uNMWxXIlM3YRsU9JUFC8oJAnk
         Li9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GnL2CTwPY1SJF+ZHQ2vaGRIXzp75okBEaSUwWtgtfE=;
        b=hGt+aCSpgJr+S+kd38Fhxmjz1OIqZxfTXy/1XAaD0KqTyn9zvJyXBMf6WMJVIjv+FC
         tfj9s8Ge/9XCeJavIMPFdT+acLWdAIr/a1LLQn1roTW+oxtfU28X2FP0u8jwFfXglde6
         nZfvzOtaAUQaMtRI3+zE0vpDD5b9klKIu6BGzF9OmC5/3O8liQDik0x3kcMyi7tUXc+H
         64xHArLBZCTKSF11yX69oGxcqiF63y/k+LiXVUY6Krfd7Rn/H2ZiJmAWkO+dYND3q4YC
         HmLmvpR/zQopIgegyWA+P+Ek/EAAMADuA9QOvMtItfmxFe0YFSTwSqfXXmaSwWX930t5
         1fVQ==
X-Gm-Message-State: APjAAAWLhPOaRWwzBVVanSiZaz7lXacs5llTf7mQBrGEAhijILODqQ1b
        xdFw388kxIxCTUEYDqm8JXg=
X-Google-Smtp-Source: APXvYqwt3RO1rSqN9dtWZYgkYZYXb+DvxPEfcHL+guj6TM8twcenkWLLyA91lrKzW+eBWiQTee6S0A==
X-Received: by 2002:a17:902:ac98:: with SMTP id h24mr16380035plr.227.1573846467693;
        Fri, 15 Nov 2019 11:34:27 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e17sm11688042pfh.121.2019.11.15.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:34:26 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:34:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: synaptics-rmi4 - add missed operations in
 remove
Message-ID: <20191115193424.GU13374@dtor-ws>
References: <20191114023405.31477-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114023405.31477-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Nov 14, 2019 at 10:34:05AM +0800, Chuhong Yuan wrote:
> The driver forgets to destroy workqueue in remove like what
> is done when probe fails.
> Add a call to destroy_workqueue to fix it.
> 
> Since unregistration will wait for the work to finish, we do
> not need to deal with work in remove.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied, thank you.

> ---
> Changes in v2:
>   - Remove the calls of canceling delay and flushing workqueue.
>   - Modify the commit message.
> 
>  drivers/input/rmi4/rmi_f54.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 484ae1f97330..897105b9a98b 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -730,6 +730,7 @@ static void rmi_f54_remove(struct rmi_function *fn)
>  
>  	video_unregister_device(&f54->vdev);
>  	v4l2_device_unregister(&f54->v4l2);
> +	destroy_workqueue(f54->workqueue);
>  }
>  
>  struct rmi_function_handler rmi_f54_handler = {
> -- 
> 2.23.0
> 

-- 
Dmitry
