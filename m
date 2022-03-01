Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691FC433F5
	for <linux-input@archiver.kernel.org>; Tue,  1 Mar 2022 07:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiCAHFA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiCAHEz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2022 02:04:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF5574AB
        for <linux-input@vger.kernel.org>; Mon, 28 Feb 2022 23:04:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so12723983pln.11
        for <linux-input@vger.kernel.org>; Mon, 28 Feb 2022 23:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkRjeUOzqiT4/IINwMNtKmmTvyxbvafUSJckzL2D06w=;
        b=VRFsVJUfpPat/86+Dp/cBdkuB3/SkJ+j1WEL2Njv/ZYTgPbtOPyu8tg8CaigWFRz04
         4kzNbWUlWVU0cVUoK/7YtWv5dg5n2S1l12Xelf0DKjEYZ4oE5v4JXk49stRNcNOL+q2e
         1eb2yKyZhtFqmBzbq7ouib2s0jkaH/lu7PEv0o3wQuNpopSar+Fj5zYjXSozjB8wsgEL
         pFEN51KA1LGGK2M0yyNJPC2LA3Q3ayn3GPd7bxI/u3fGP22kIOxAI9d3kNh7ayCWLQ9n
         ye0stwcOuo7fUqcUZqnED+Dz/eyEO/csZGVrehaBpNY4oaLRumPz+LXvUsckYAs7Zpqa
         AsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkRjeUOzqiT4/IINwMNtKmmTvyxbvafUSJckzL2D06w=;
        b=YTodHjLvct3d6fuhGl8Wafoi1WKjGFlp1JK0wBC8hY3lMDJMvv+QxG9xWVZam/wu62
         8rEMcZ+pejor74XLIxWjZudoojSxdDmGc6zl4C8eMKSrBLhYkx6fa2R5qy0aSBztpzXu
         V61k8Q9zlHui2TqW70eOhAejGqcLQoOY6XXrvl9YWZgpt+s9H5m8g1oonCImRirQAtxe
         ZKruLidCQ+epa2AHTkUl7nx/Lwafn3dVDhyTPZ6aJQ5cRy8BSnsx4oJ1p0jhzzxexfBN
         4xXFjM0nIh00RLIWlUX89SUlZI+tk07oiRlDCdRcMTI5hKYamE5S62+Mvns8euzSDXzj
         zMuA==
X-Gm-Message-State: AOAM531CQ/LgU+RmLByP79/E8k25yyHsMpd3s9y3CKMFmUj0az4fN8UW
        tCbnCJOk1nE+m6CURuLrBtK1aHP/R0Q=
X-Google-Smtp-Source: ABdhPJxXvra+aYIx66wufWPQSuqUNi9vjyf4MtK51uz7GHEiaxaWc9NF4WFE7LZt2vqHEJhoR++Tsg==
X-Received: by 2002:a17:90b:3b85:b0:1be:d955:b896 with SMTP id pc5-20020a17090b3b8500b001bed955b896mr2290890pjb.37.1646118247486;
        Mon, 28 Feb 2022 23:04:07 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c174:264:5e49:f2cb])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004e17afd9af9sm16532695pfu.92.2022.02.28.23.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:04:06 -0800 (PST)
Date:   Mon, 28 Feb 2022 23:04:04 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 3/5] Input: goodix - Use input_copy_abs() helper
Message-ID: <Yh3FZE9PWIxmCPZ0@google.com>
References: <20220131143539.109142-1-hdegoede@redhat.com>
 <20220131143539.109142-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131143539.109142-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 31, 2022 at 03:35:37PM +0100, Hans de Goede wrote:
> Use the new input_copy_abs() helper and move the 2 input_abs_set_res()
> calls up to be directly after the 2 input_copy_abs() calls, so that
> the calls initializing the X and Y axis are all together.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

-- 
Dmitry
