From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 0/2] input: rotary-encoder: add support for half-period
 encoders
Date: Mon, 11 Apr 2011 12:44:00 +0200
Message-ID: <20110411104400.GB27286@localhost>
References: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
 <BANLkTimw=tiCn2gbVg7DCqe2ydexgByuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40584 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1DKKoG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Apr 2011 06:44:06 -0400
Received: by ewy4 with SMTP id 4so1665296ewy.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 03:44:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimw=tiCn2gbVg7DCqe2ydexgByuEQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Apr 08, 2011 at 09:39:21AM +0200, Daniel Mack wrote:
> On Tue, Apr 5, 2011 at 8:15 PM, Johan Hovold <jhovold@gmail.com> wrote:
> > Hi,
> >
> > These patches add support for rotary-encoders which have two stable states per
> > input signal period.
> >
> > The first patch refactors state retrieval and event reporting and the second
> > adds support for such half-period encoders.
> 
> I have no objections to let the code in, and the patch looks sane to me.
> 
> However, I don't currently have access to the hardware I wrote the
> driver for, so I can't test right now, but will do at some later
> point.

It is possible to test non-half-period mode with a half-period encoder
(and vice verse) and I've verified that my patches do not change the
original state machine. In particular, every other event is still
missing as no event is delivered in the armed-state in non-half-period
mode.

> Feel free to add my Acked-by:, and I will get back to you in case I
> encounter any trouble.

Thanks,
Johan
