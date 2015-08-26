From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Wed, 26 Aug 2015 09:34:49 +0200
Message-ID: <CACRpkdaA2_kHRDdNtUKHg9yqq1akD+yYhgmzFzB5Hkq0=vA-Mw@mail.gmail.com>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
	<20150728210040.GE19610@dtor-ws>
	<20150810224109.GN6519@usrtlx11787.corpusers.net>
	<CACRpkdY8KqKa3GpfNo5JQAO5+Z3UG0J99VCg_OjsRTa5MJAaYg@mail.gmail.com>
	<CAAVeFuK6TwYrbb8DJWa8NgL269p03vmDVDVaSuEvCWuOuN4GzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36819 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392AbbHZHeu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 03:34:50 -0400
Received: by obkg7 with SMTP id g7so164002335obk.3
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2015 00:34:49 -0700 (PDT)
In-Reply-To: <CAAVeFuK6TwYrbb8DJWa8NgL269p03vmDVDVaSuEvCWuOuN4GzA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Mon, Aug 17, 2015 at 8:59 AM, Alexandre Courbot <gnurou@gmail.com> wrote:

> So I'd say it makes sense to propagate errors returned by the driver's
> get() hook. This might contradict some of our earlier statements about
> simplifying the GPIO API, but is preferrable to having to make a
> decision as to which valid value to return if the driver fails...
>
> It should then be made very clear in the documentation that the only
> positive values ever returned by the GPIO API will be 0 and 1 (we
> already have a clamping mechanism for that IIRC), and that negative
> values are propagated as-is.
>
> Linus, does that seem reasonable to you? Does anyone has the intention
> to address that one or should I add it to my short-term TODO list?

I'm aligned with this. Go ahead on this path.

Yours,
Linus Walleij
