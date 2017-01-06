From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] Input: pwm-beeper: add optional enable gpio
Date: Fri, 6 Jan 2017 19:28:37 +0200
Message-ID: <CAHp75VfY4CXOmvT5y2NucKLDvdt4i2LhW5rthke1pdvuAVm7gA@mail.gmail.com>
References: <1483670635-25060-1-git-send-email-david@lechnology.com> <1483670635-25060-4-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34482 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdAFR2i (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 12:28:38 -0500
In-Reply-To: <1483670635-25060-4-git-send-email-david@lechnology.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input <linux-input@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jan 6, 2017 at 4:43 AM, David Lechner <david@lechnology.com> wrote:
> This adds an optional enable gpio to the pwm-beeper device. This gpio is
> used in cases where the beeper needs to be switched on before using it.

Isn't it a property of pin muxing?

> For
> example, there may be an amplifier that is not always powered on.

This looks like GPIO based fixed voltage regulator.

>
> Tested on LEGO MINDSTORMS EV3, which has a speaker connected to PWM through
> an amplifier. The amplifier has an enable pin that is connected to a gpio.

-- 
With Best Regards,
Andy Shevchenko
