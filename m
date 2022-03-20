Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB0C433F5
	for <linux-input@archiver.kernel.org>; Sun, 20 Mar 2022 06:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbiCTGtF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 20 Mar 2022 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiCTGtE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Mar 2022 02:49:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F721C73A;
        Sat, 19 Mar 2022 23:47:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h5so10225502plf.7;
        Sat, 19 Mar 2022 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NgrEPmFDJ2yYj2QRmKZR3tYfLPbvK3CYukW4Cj5YVI0=;
        b=ORJXDVW+JPxFZdBDKalipSZV6WXC0qsttbcx3lWXJQJ6xHMx/RE197Okg9HSfJqKXw
         s3W+7Hr+ZwoclrRzZ1IshLrmE8x7Ck0FzIeAavXZiSmQIRwoxL4qW8p/C1Pw2MxMpl8k
         711eXpRHql5/dRn57e0i9yZBC3gTSmzQtQTlCt4VJcwqQDyxz+6IMeeyQxpp8tD81Are
         R8cKbQVk7wgILhP5QJ4wTGs+O5oD9Dk41QG2maDKOu4e4Bq8RhbvhvV2O/+HoZ+7Egz7
         k7wPG+OMLPCMJSUILo04Uzs+bnfHMkmsG6hojPgw1JPpuecHPaPQwy0qnHI8rcglkyrw
         ek2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NgrEPmFDJ2yYj2QRmKZR3tYfLPbvK3CYukW4Cj5YVI0=;
        b=N3kAAmYln4rxCXqRK2zwvfz8a6oVGr/WaKX/oRKVrrE2vNTy5CFNd3XAQlM736VWaK
         MyzTGmOAFHY/oviYzfwW5WA2uGwdG3P8YcWgIWhpNxJEr83oXHZ21e8zo4BNlHtW9oAU
         5k17ASNjyC2GTIUUBzNCkwXHtHmMCdVS/QYexlU60ITyaRz1yob25YdbR6IoieEn7zDu
         tgSKUhInMhAA8P69+gmKeToWV8wu6H8x2KRzle6Ix8ft35xvZSxsEiBHNV8o+hTK3JBc
         UzTma/yS7uyAeJFE0ZUIenMH60IZlWOYT+Ui8dSgQY6wkEiMdHLAPiJTh8yOKbHiGEO/
         aC7w==
X-Gm-Message-State: AOAM532hgoTn1L8PqzqtK+KZOWSJNJMMCWWrk7MXiEC9faHjzsLlHoTb
        aS1ooYTE9xy6Xw7QXGvAsSE=
X-Google-Smtp-Source: ABdhPJwa2GUktdiI5KXGLIsas++mmGmEcobtimGGhzJzrYfR46CgCAzdh/q36nP6+3uJ3kEnv/vNcg==
X-Received: by 2002:a17:90a:7e8b:b0:1be:ef6c:9797 with SMTP id j11-20020a17090a7e8b00b001beef6c9797mr30180197pjl.183.1647758860990;
        Sat, 19 Mar 2022 23:47:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1298:391e:bb76:2a2b])
        by smtp.gmail.com with ESMTPSA id bx23-20020a056a00429700b004fa79b2cb31sm5422030pfb.51.2022.03.19.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 23:47:40 -0700 (PDT)
Date:   Sat, 19 Mar 2022 23:47:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.17-rc8
Message-ID: <YjbOCoICMH/mL9rx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a 2 driver
fixups:

- a fix for zinitix touchscreen to properly report contacts
- a fix for aiptek tablet driver to be more resilient to devices with
  incorrect descriptors

Changelog:
---------

Linus Walleij (1):
      Input: zinitix - do not report shadow fingers

Pavel Skripkin (1):
      Input: aiptek - properly check endpoint type

Diffstat:
--------

 drivers/input/tablet/aiptek.c       | 10 ++++-----
 drivers/input/touchscreen/zinitix.c | 44 +++++++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 15 deletions(-)

Thanks.

-- 
Dmitry
