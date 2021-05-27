Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5BC4707F
	for <linux-input@archiver.kernel.org>; Thu, 27 May 2021 06:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50B36128B
	for <linux-input@archiver.kernel.org>; Thu, 27 May 2021 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhE0G6P (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 May 2021 02:58:15 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:36511 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhE0G6P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 May 2021 02:58:15 -0400
Received: by mail-ua1-f42.google.com with SMTP id b1so2242802uap.3;
        Wed, 26 May 2021 23:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2t6IMzVIqTCod2+uOSHEsZTJdw+bDIz54J1tQ79MxI=;
        b=XlOuxH1buXg5CZFPe8aLOkWpPUIQR/YRSU7Lzjb/aX7RvSv7FwQLszU+jWHyvTMNlc
         BBr3TMxh/qWHdYJRT4c6700RG1Ode2CUYM6qd+uBGkQOl1aZpzjQQ2J9SG/G2x6BIYnU
         OXqI9kJN0ldIt23/nMdfG7fNIhvnDsFlZk5RIJYkzCoWymzao1p8au5SdylYCZxSJAaY
         0CjRwElqR+StZWjVF72PFA0jk+n3RjTe4hmK6G456vmNobfYER8neISIuNWUXWj9S18S
         QAFQ/JLXDzJQkisCwv+YBSWD932ekMqH64qs+YPT7KrxwBU84FYMY+OXbCc5rI5ddVE8
         qjnQ==
X-Gm-Message-State: AOAM53192Kt2b7tXeGnv47+5odLEGTv9AyVEOQkxGK5JM6U0EVRPjmFy
        kKb4S9DxJqzGZwTpjbJMMtSD6RMGtssjJvxai9A=
X-Google-Smtp-Source: ABdhPJy2YAKKfxFxxvKdmhExBLtPw5lTCiBuF+JtcYk8I7TJ0hfYqoU1o0Y8QVH5FiEH0N4Sj81vPMLvvnlXq+SMexU=
X-Received: by 2002:a1f:d8c3:: with SMTP id p186mr1066978vkg.1.1622098602086;
 Wed, 26 May 2021 23:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210527001251.8529-1-rdunlap@infradead.org>
In-Reply-To: <20210527001251.8529-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 May 2021 08:56:30 +0200
Message-ID: <CAMuHMdWxBDM6za4_zPrkPGja8K6vy47gfdzYMNjJ-i1n1ySsHA@mail.gmail.com>
Subject: Re: [PATCH v2] MOUSE_ATARI: fix kconfig unmet dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitz@debian.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, May 27, 2021 at 2:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Since the code for ATARI_KBD_CORE does not use drivers/input/keyboard/
> code, just move ATARI_KBD_CORE to arch/m68k/Kconfig.machine to remove
> this dependency.
>
> Removes this kconfig warning:
>
> WARNING: unmet direct dependencies detected for ATARI_KBD_CORE
>   Depends on [n]: !UML && INPUT [=y] && INPUT_KEYBOARD [=n]
>   Selected by [y]:
>   - MOUSE_ATARI [=y] && !UML && INPUT [=y] && INPUT_MOUSE [=y] && ATARI [=y]
>
> Fixes: c04cb856e20a ("m68k: Atari keyboard and mouse support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Schmitz <schmitz@debian.org>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
> v2: move the symbol outside of INPUT_KEYBOARD (Geert) -- all the way
>     to Kconfig.machine (Michael). Thanks.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I'm willing to queue this in the m68k for-v5.14 branch, if Dmitry agrees.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
