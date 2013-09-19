From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] Input: gpio_keys - wakeup_trigger
Date: Thu, 19 Sep 2013 13:43:43 -0700
Message-ID: <CANLzEkufu+MA67tBi9eXDTzPrSqT9jUNpMiCqeqckJog1JdVbA@mail.gmail.com>
References: <1379109160-32437-1-git-send-email-bleung@chromium.org>
	<106090496.3hTZTLSVzK@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:37991 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3ISUno (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Sep 2013 16:43:44 -0400
Received: by mail-vc0-f182.google.com with SMTP id hf12so7159311vcb.27
        for <linux-input@vger.kernel.org>; Thu, 19 Sep 2013 13:43:43 -0700 (PDT)
In-Reply-To: <106090496.3hTZTLSVzK@flatron>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, david@protonic.nl, Douglas Anderson <dianders@chromium.org>

Hi Tomasz,

On Sat, Sep 14, 2013 at 5:16 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> I don't like two things in this patch.
>
> First is that this looks completely like a configuration option, not
> hardware description, so it's not something that should be put into DT.
> Especially that users might want to use another wake-up trigger depending
> on their use cases. I'd rather see this as a sysfs entry.
>
> Another thing is that this driver assumes that key events are indicated by
> edges on the GPIO line, so I don't think level trigger setting make any
> sense here. I'd rather allow three settings here (through a sysfs knob) -
> key down, key up, key down or up.

Thanks for your feedback. I agree with your suggestions. I will move
this from platform data and DT to a sysfs property with three settings
: rising, falling, both.


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
