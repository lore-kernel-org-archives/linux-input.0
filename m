From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 12/26] Input: synaptics-rmi4: Use generic interrupt handling
Date: Mon, 9 Nov 2015 14:09:42 +0100
Message-ID: <CACRpkdZgdMJ--0nm=roxz9g-BNYL4R9cBvg04g-KVLV3WapT6w@mail.gmail.com>
References: <1446766807-30760-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33654 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbKINJn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:09:43 -0500
Received: by obbww6 with SMTP id ww6so112741736obb.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:09:43 -0800 (PST)
In-Reply-To: <1446766807-30760-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:40 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Currently the RMI4 driver expects the device to have a GPIO and manages
> the that GPIO internally. However, this duplicates functionality which
> could be handled by more generic interrupt handling code. Also, some
> RMI devices will not have a GPIO or it won't be accessible to the rmi4
> driver. This patch removes the GPIO code and instead gets the irq passed
> up from the underlying transport (ie i2c-core).
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

This is much better and should be squashed into the core patch adding
the bus. The other GPIO cruft I was talking about seems to be going
away with this and abstract away things nicely.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
