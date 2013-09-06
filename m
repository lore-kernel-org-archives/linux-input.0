From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC] surface-input
Date: Fri, 6 Sep 2013 15:36:13 +0200
Message-ID: <CANq1E4SW1Z5_vH5m+Y-MH=ztd6b6V7-B9S0y0ORGj9Lf3p0nwQ@mail.gmail.com>
References: <52289209.2070707@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45804 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IFNgN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 09:36:13 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so6727459ieb.14
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 06:36:13 -0700 (PDT)
In-Reply-To: <52289209.2070707@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>

Hi

On Thu, Sep 5, 2013 at 4:15 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello everyone,
>
> as mentioned earlier, I'm currently writing a multitouch input driver
> for the Pixelsense (formerly Surface 2.0). It's now at a point where I'd
> consider it mostly done, but a) I have very limited experience with
> kernel drivers and b) there are some additional questions I have, so I'm
> attaching the current state of my source code and would like to ask for
> your comments.
>
> Open question: it looks like just calling
>
> input_mt_init_slots(poll_dev->input, MAX_CONTACTS, INPUT_MT_DIRECT);
>
> in the initialization routine isn't enough. hid-multitouch doesn't seem
> to use any other init commands, though, or did I overlook something?
>
> Are there any other caveats of the input-mt library which I should be
> aware of?
>
> Thanks for your input, and best regards, Florian

Please inline the code as Benjamin noted. Otherwise, it's cumbersome
to comment on specific lines (please see "git help format-patch" and
"git help send-email").
I did review the core setup/lifetime/destruction code and it looks
good. But you need to fix several error-paths. If a core function
returns "int", you should check it for "r < 0" and then forward the
code. Don't overwrite it with EINVAL.
Furthermore, correctly free your memory. Things like this leak memory
(surface might be non-NULL):
  if (!surface || !poll_dev)
    return -ENOMEM;

I can do a more complete review for v2 if you send it inline. But
looks good overall.

Thanks
David
