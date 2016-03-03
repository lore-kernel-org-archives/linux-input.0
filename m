From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] Input: sh_keysc - Remove dependency on SUPERH
Date: Thu, 3 Mar 2016 09:11:18 +0100
Message-ID: <CAMuHMdWdeZkjk++5kpPLH6vHvz=ZAPqFp8z9od+Y-=R1W8HCxA@mail.gmail.com>
References: <1456966425-14664-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35670 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020AbcCCILT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Mar 2016 03:11:19 -0500
In-Reply-To: <1456966425-14664-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On Thu, Mar 3, 2016 at 1:53 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> A dependency on ARCH_SHMOBILE seems to be the best option for sh_keysc:
>
> * For Super H based SoCs: sh_keysc is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09,
>   SH_7722_SOLUTION_ENGINE, and SH_7724_SOLUTION_ENGINE, which depend on
>   either CPU_SUBTYPE_SH7722 or CPU_SUBTYPE_SH7724, and both select
>   ARCH_SHMOBILE.
>
> * For ARM Based SoCs: Since the removal of legacy (non-multiplatform) support
>   this driver has not been used by any Renesas ARM based SoCs. The Renesas
>   ARM based SoCs currently select ARCH_SHMOBILE, however, it is planned
>   that this will no longer be the case.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
