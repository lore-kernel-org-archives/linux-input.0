From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/7] Input: synaptics-rmi4: Add dribble and palm gesture
 parameters to devicetree
Date: Wed, 8 Jun 2016 09:39:14 +0200
Message-ID: <CACRpkdYSJ4E1cQk0PPj=D2DMs1d+5J9oFAAi=kmZvF72t1RH6g@mail.gmail.com>
References: <1464979228-2497-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34509 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcFHHjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2016 03:39:15 -0400
Received: by mail-oi0-f49.google.com with SMTP id e72so113224oib.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2016 00:39:15 -0700 (PDT)
In-Reply-To: <1464979228-2497-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Jun 3, 2016 at 8:40 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

> +- syna,dribble: Control reporting of dribble packets. Values are 0 for
> +               default, 1 for explicitly disable, 2 for explicitly enable.
> +- syna,palm_detect: Control reporting of the palm detect gesture. Values
> +                       are 0 for default, 1 for explicitly disable, 2 for
> +                       explicitly enable.

I think these belong in the device tree, but you should add four bool
props instead:

syna,dribble-disable;
syna,dribble-enable;
syna,palm-detect-disable;
syna,palm-detect-enable;

Those are way easier for the human authoring the device tree to
cope with than the opaque parameters.

Yours,
Linus Walleij
