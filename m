From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
Date: Mon, 23 Jan 2017 14:40:13 +0100
Message-ID: <CACRpkdaGNM8Mco_7iRO7eOAXKC8KsqhsYP3kh8z0mCCYHqs+DA@mail.gmail.com>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34072 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWNkQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Jan 2017 08:40:16 -0500
Received: by mail-io0-f170.google.com with SMTP id l66so110160471ioi.1
        for <linux-input@vger.kernel.org>; Mon, 23 Jan 2017 05:40:16 -0800 (PST)
In-Reply-To: <20170110083141.4103-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joseph Lai <joseph_lai@wistron.com>

On Tue, Jan 10, 2017 at 9:31 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The MPU3050 driver in the input subsystem has been superceded
> by a proper IIO driver found in drivers/iio/gyro/mpu3050*.
>
> Patches have been submitted to remove all defconfig and related
> references to the old driver and replace this input driver
> with the IIO driver. commit 634b847b6d23
> ("x86/platform/intel-mid: Switch MPU3050 driver to IIO")
> is already upstream.
>
> So delete the input driver. Input was never a good fit for
> sensors anyway.
>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Joseph Lai <joseph_lai@wistron.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Dmitry can we just kill this driver? Noone seems to object and I
got an ACK from Heikki as you can see.

Yours,
Linus Walleij
