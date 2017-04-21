From: =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.eu>
Subject: Re: [PATCH v2.2] HID: hid-elecom: extend to fix the descriptor for
 DEFT trackballs.
Date: Sat, 22 Apr 2017 00:56:27 +0100
Message-ID: <CAHcsgXRN+2j9TVdja_A=3jk39HH=hYjjxw-eL=V9nQMoQ-7n+Q@mail.gmail.com>
References: <20170421172933.14659-1-flameeyes@flameeyes.eu> <20170421174255.16099-1-flameeyes@flameeyes.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37591 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042051AbdDUX43 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Apr 2017 19:56:29 -0400
Received: by mail-it0-f53.google.com with SMTP id x188so766279itb.0
        for <linux-input@vger.kernel.org>; Fri, 21 Apr 2017 16:56:29 -0700 (PDT)
In-Reply-To: <20170421174255.16099-1-flameeyes@flameeyes.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.eu>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>

First of, sorry for the extra noisy, spammy posting. Two of the
versions (v2 and v2.1) are actually the same because I have not used
`git send-email` in long enough I forgot how it works, shame on me!

On Fri, Apr 21, 2017 at 6:42 PM, Diego Elio Petten=C3=B2
<flameeyes@flameeyes.eu> wrote:
> The ELECOM DEFT trackballs report only five buttons, when the device
> actually has 8. Change the descriptor so that the HID driver can see all =
of
> them

Version 2.2 (which is the only other one aside from the original that
actually *does* compile) effectively merges Yuxuan Shui's
(https://patchwork.kernel.org/patch/9217713/) by including both the
wired and wireless DEFT IDs.

Unlike last year's patch, it does not create a new driver/module but
extends the already-present hid-elecom. This looks to me matching the
behaviour of other HID quirk drivers.

Also, to remove the extraneous 3 "constant" bits, it just nulls out
the count, rather than getting rid of the bytecode, which required a
memmove of the remaining structure, making it less invasive and
(hopefully) less prone to bugs.
