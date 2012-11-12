From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] HID: microsoft, do not use compound literal
Date: Mon, 12 Nov 2012 13:42:20 +0100
Message-ID: <CAMuHMdX2fFHGnO-eeA0_xFgk=NRFeFP07K_bA06Qje45B1g6KQ@mail.gmail.com>
References: <1352711769-28911-1-git-send-email-jslaby@suse.cz>
	<CAMuHMdUEW9K6cfpcUNphte_VzBCL_Oa_od3892DQ3QbX5xMMnA@mail.gmail.com>
	<alpine.LNX.2.00.1211121314270.27271@pobox.suse.cz>
	<CAMuHMdWq9S9oO+2OH6oiAogFR+JJxnxrtGoMp+uMm-qXCLr55A@mail.gmail.com>
	<50A0ED09.6010106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34921 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2KLMmV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 07:42:21 -0500
In-Reply-To: <50A0ED09.6010106@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

On Mon, Nov 12, 2012 at 1:35 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> On 11/12/2012 01:30 PM, Geert Uytterhoeven wrote:
>> My comment was purely cosmetic, as it applies to the quoted compiler error
>> messages only.
>
> Ah, I see. When you are applying the patch Jiri, could you remove errors
> about line 50 from the commit log? What I wanted to have there
> apparently was only "hid-microsoft.c:51:18: error: macro "memcmp" passed
> 6 arguments, but takes just 3".

Right.

>> Your latest version doesn't use memcmp() anymore, so I think there's no need to
>> include <linux/string.h> anymore.
>
> s/Your/His/ perhaps :). Otherwise I'd be confused -- did Jiri send some
> other version?

Doh, I'm (still) not awake, and didn't notice there are two different
Jiri's in this thread...

Sorry for the confusion.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
