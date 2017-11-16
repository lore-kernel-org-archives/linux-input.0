From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Thu, 16 Nov 2017 07:34:58 -0600
Message-ID: <CAL_Jsq+28caybU9xA+xVSWSFobEuJWgNhoq+YjPHoqpzjxhMng@mail.gmail.com>
References: <20171019071728.6635-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932663AbdKPNfU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Nov 2017 08:35:20 -0500
In-Reply-To: <20171019071728.6635-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Gregor Riepl <onitake@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 19, 2017 at 2:17 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> On some x86 tablets with a silead touchscreen the windows logo on the
> front is a capacitive home button. Touching this button results in a touch
> with bits 12-15 of the Y coordinates set, while normally only the lower 12
> are used.
>
> Detect this and report a KEY_LEFTMETA press when this happens. Note for
> now we only respond to the Y coordinate bits 12-15 containing 0x01, on some
> tablets *without* a capacative button I've noticed these bits containing

capacitive

> 0x04 when crossing the edges of the screen.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Only enable support for the home-button if a "silead,home-button"
>  boolean device-property is set on the device
>
> Changes in v3:
> -Document the new silead,home-button property in:
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/silead.c                 | 46 ++++++++++++++++------
>  2 files changed, 37 insertions(+), 11 deletions(-)
