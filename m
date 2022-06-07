Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8831FC433EF
	for <linux-input@archiver.kernel.org>; Wed,  8 Jun 2022 01:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiFHBmO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388281AbiFHBhz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2022 21:37:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360E45B73E
        for <linux-input@vger.kernel.org>; Tue,  7 Jun 2022 15:11:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so37927299ejk.5
        for <linux-input@vger.kernel.org>; Tue, 07 Jun 2022 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfycHacPY5P1y/1m0oCpwnDJwtHXoUWrUFXkPYiy2lw=;
        b=Tov7X2dnwSkw2/BPXfCsLem8R5BtxbPWjnRcb5I5neISNNssoSXmPYxcZJuN7aRuLD
         ziSy0wBW1fgXRVrkRU8YnG4qS4LQCnBfulhISKENZ3UsFzRZ95+wvNwSBIQfPRtlrQVh
         DRSz1SOqUnOqQn7VILe87XHifzet2YmzByYac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfycHacPY5P1y/1m0oCpwnDJwtHXoUWrUFXkPYiy2lw=;
        b=VIwLPNDgy479TV3+8BuUD1kYXVvMj9d4JxKo4k7guN1kJgINU9XmvAA9AGYY5i72JT
         Y6OMtyBmGBEtZgsEAl3yFFt4p/xAIP8IA59TAXFhCajQl2NnMLbyIg2k/1B3+HDNMir+
         y0GZT+18mKnT/O3yB/KlBl2a5/jvp5k4duyqz6QiIQyjKG8FwKml2WadewKcGoNA5yY0
         9Q1rZScvuwvw50DQTs/njVCbmVqq2XzEHXWmp+esSxA4jWRajOJRXewsl9XJEKJY/ose
         UI1efVmHNJaLyGSmrvRvVuZwp8UXfPAfeAeHkDcY3ggwm1l/JlG+zzFQ3VnSnBA/pmVv
         7JZg==
X-Gm-Message-State: AOAM533BSn8h3toyRQN4s852GTS6bOkdjIJoWRmFq63/oDARXIJGu26z
        OtWFfUxjhyGueHg+XlczY98yUvOWT7PHf2sUWiY=
X-Google-Smtp-Source: ABdhPJzBKReHMQS8jQ3Hq1NMId5d7ASr/V2EntA3nNIETRz0vIP4q7CUQwuPERXYzKMrbqfDga9iRA==
X-Received: by 2002:a17:906:4786:b0:6fe:a063:ceb8 with SMTP id cw6-20020a170906478600b006fea063ceb8mr29058475ejc.265.1654639884016;
        Tue, 07 Jun 2022 15:11:24 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b0042617ba637bsm11403220eds.5.2022.06.07.15.11.23
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:11:23 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id k19so25896126wrd.8
        for <linux-input@vger.kernel.org>; Tue, 07 Jun 2022 15:11:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr29434919wrz.281.1654639883077; Tue, 07
 Jun 2022 15:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <Yp/AGMpXXnx9lW6j@google.com>
In-Reply-To: <Yp/AGMpXXnx9lW6j@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 15:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcC15LsPS1Nj-e5nC-hR3oGVy+bQumyLD9vz4HzaDWAg@mail.gmail.com>
Message-ID: <CAHk-=wjcC15LsPS1Nj-e5nC-hR3oGVy+bQumyLD9vz4HzaDWAg@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.19-rc1
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jun 7, 2022 at 2:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc1

I don't know why pr-tracker-bot hasn't reacted to me pulling this and
pushing out, so I'll do it manually.

Maybe pr-tracker-bot is just taking a quick nap, and will be back
shortly. Or maybe it had some odd issues with this pull request. I
don't know.

                      Linus
