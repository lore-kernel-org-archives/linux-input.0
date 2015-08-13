From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Thu, 13 Aug 2015 15:06:56 +0200
Message-ID: <CACRpkdY8KqKa3GpfNo5JQAO5+Z3UG0J99VCg_OjsRTa5MJAaYg@mail.gmail.com>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
	<20150728210040.GE19610@dtor-ws>
	<20150810224109.GN6519@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35325 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbbHMNG5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 09:06:57 -0400
Received: by oiew67 with SMTP id w67so7431697oie.2
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2015 06:06:57 -0700 (PDT)
In-Reply-To: <20150810224109.GN6519@usrtlx11787.corpusers.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Aug 11, 2015 at 12:41 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> But then the question first goes to Linus & co.
>
> gpio_chip->get() can return a negative value to indicate errors (and did
> so in this case), all parts of the API seems indicates that we can get
> an error (int vs bool).

Ooops.

> Should we change _gpiod_get_raw_value() to propagate this error?

Yes for now. Can you patch it? :)

>  Or
> should we just ignore this issue and propagate an error as GPIO high
> reading?

I don't know about the future. In some sense GPIOs are so smallish
resources that errorhandling every call to read/write them seem to
be a royal PITA. That is why I wanted to switch them to bool and get
rid of the problem, but now I also see that maybe that was not such a
smart idea, if errors do occur on the set/get_value path.

Alexandre?

Yours,
Linus Walleij
