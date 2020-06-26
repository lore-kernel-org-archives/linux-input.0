Return-Path: <SRS0=Lx5L=AH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A06C433DF
	for <linux-input@archiver.kernel.org>; Fri, 26 Jun 2020 17:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3932080C
	for <linux-input@archiver.kernel.org>; Fri, 26 Jun 2020 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/uuOMIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFZRts (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZRts (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jun 2020 13:49:48 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72351C03E979
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2020 10:49:48 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id v1so5922670vsb.10
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2020 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=s8mpfmsEu0eLBx3AlZHjh1F2GfDdaKEB5L7qQAMJThU=;
        b=n/uuOMIeWpxzR+7Ioq/979SAFuaOFxzJhXMOsaHzJsDepBzFgccx4MgzkNavOrlk/K
         bd7dQFxdT1ZTO84g7juFhRSDlScr5YDSEPZAaqh5pCS6wAZaje0xo6b5OKOhnonTIwtM
         JwwQs9QsNWgUqsjoKUET6Wz3TSjYU82DdL+Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s8mpfmsEu0eLBx3AlZHjh1F2GfDdaKEB5L7qQAMJThU=;
        b=rtHttdFOEXTT80YvNW8I4aEMQZMeIeXaFpSy2MsP45FBARP5SDv1zeyNsw33NzfozJ
         NVBbWH4LT7rQk+dvwGfU7YquQ3dqrPE1pvDQRIc5NcoI9n46m5zv0nUgnwHRbotK6QZK
         PJO9m4CUxGTwfr7I0pEOUP6RhHcQlLbUQq69P+HOs5QQhxQBh7sE8WzywpOhvS6ZIY1q
         3MENxR23UhR8HQmLaFeuSl6EU8j3xRKmKmSQBHuohBxShLWA6H9GTnY3p5BwfQVxdCpH
         H1Y1w+DOlwjdw8gkKy/MeTCbBVOSP55gSaD4kyBWpzbD6Bxdvf6yqeoDvBkRttGmfJj8
         KmyQ==
X-Gm-Message-State: AOAM5316wFuHtrC1fNXkoWSxSpPLRL02ilp8Ocw8RZeCu5Ey/t6LCok6
        Z46iuJOl9MDZ8eQaEXBgGl6Gk9iyJ/E=
X-Google-Smtp-Source: ABdhPJwXMuuyoP4zElllC6uEF9gDkFEiQj0rt5mPBjBIpJAm4sHWlHQkKKsVstLpF+2vFE8TTNDPlw==
X-Received: by 2002:a67:4c1:: with SMTP id 184mr3326617vse.102.1593193787357;
        Fri, 26 Jun 2020 10:49:47 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id v4sm3522111vsk.9.2020.06.26.10.49.46
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 10:49:46 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id k66so1241910vkk.2
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2020 10:49:46 -0700 (PDT)
X-Received: by 2002:a1f:a0c2:: with SMTP id j185mr3001148vke.95.1593193785610;
 Fri, 26 Jun 2020 10:49:45 -0700 (PDT)
MIME-Version: 1.0
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 26 Jun 2020 10:49:34 -0700
X-Gmail-Original-Message-ID: <CA+jURctpKw3fDCWJCi_XrNaO=thyzk=AUqq=FWXaFSWfaYaSjw@mail.gmail.com>
Message-ID: <CA+jURctpKw3fDCWJCi_XrNaO=thyzk=AUqq=FWXaFSWfaYaSjw@mail.gmail.com>
Subject: Request to revert "Input: elants_i2c - Report resolution information
 for touch major"
To:     linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

We've been seeing a lot of issues with ELAN touch screens caused by
the patch "Input: elants_i2c - Report resolution information for touch
major". It turns out that the resolution of 1 unit per mm was not
correct for a number of touch screens, causing touch sizes to be
reported as way too large (e.g. in https://crbug.com/1085648). We've
reverted that patch in our Kernel branches, but request that it be
reverted upstream as well until ELAN can figure out a more accurate
way to report the touch major resolution.

Thanks,

Harry Cutts
Chrome OS Touch/Input team
