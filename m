From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: bfin_rotary - mark suspend and resume code as __maybe_unused
Date: Fri, 6 Feb 2015 16:41:02 +0100
Message-ID: <CAMuHMdWscC_K1GQeF3PAj4SzejQpGU23+OiT9Kpo0Xxc64XfRg@mail.gmail.com>
References: <20150206060953.GA34087@dtor-ws>
	<CAJxxZ0PetVdf+=E1in0PcPZW3k3XsE903+NSeYGsEguBQtnzag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:63064 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbbBFPlD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 10:41:03 -0500
In-Reply-To: <CAJxxZ0PetVdf+=E1in0PcPZW3k3XsE903+NSeYGsEguBQtnzag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, Feb 6, 2015 at 10:06 AM, Sonic Zhang <sonic.adi@gmail.com> wrote:
>>  static struct platform_driver bfin_rotary_device_driver = {
>>         .probe          = bfin_rotary_probe,
>>         .remove         = bfin_rotary_remove,
>>         .driver         = {
>>                 .name   = "bfin-rotary",
>
> You missed
>                    .owner  = THIS_MODULE,
> here.

That line was removed in v3.19-rc1 by commit 776bd315a7721574
("input: misc: drop owner assignment from platform_drivers").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
