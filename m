From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/2] input: rotary-encoder: add support for half-period encoders
Date: Fri, 8 Apr 2011 09:39:21 +0200
Message-ID: <BANLkTimw=tiCn2gbVg7DCqe2ydexgByuEQ@mail.gmail.com>
References: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34503 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab1DHHjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2011 03:39:22 -0400
Received: by vws1 with SMTP id 1so2496933vws.19
        for <linux-input@vger.kernel.org>; Fri, 08 Apr 2011 00:39:21 -0700 (PDT)
In-Reply-To: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Apr 5, 2011 at 8:15 PM, Johan Hovold <jhovold@gmail.com> wrote:
> Hi,
>
> These patches add support for rotary-encoders which have two stable states per
> input signal period.
>
> The first patch refactors state retrieval and event reporting and the second
> adds support for such half-period encoders.

I have no objections to let the code in, and the patch looks sane to me.

However, I don't currently have access to the hardware I wrote the
driver for, so I can't test right now, but will do at some later
point.

Feel free to add my Acked-by:, and I will get back to you in case I
encounter any trouble.

Thanks,
Daniel
