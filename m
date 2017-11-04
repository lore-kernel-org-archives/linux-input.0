From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/2] devicetree: i2c-hid: Add reset property
Date: Fri, 3 Nov 2017 21:35:04 -0700
Message-ID: <CA+ASDXOG1HA2zS9uEi0n2Tza1iGvM0x1cntCy1haOf01Wb__3Q@mail.gmail.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com> <1509418996-25348-2-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:53158 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdKDEfH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Nov 2017 00:35:07 -0400
Received: by mail-io0-f196.google.com with SMTP id f20so10414691ioj.9
        for <linux-input@vger.kernel.org>; Fri, 03 Nov 2017 21:35:07 -0700 (PDT)
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com. [209.85.223.171])
        by smtp.gmail.com with ESMTPSA id p198sm1948660itp.3.2017.11.03.21.35.05
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 21:35:06 -0700 (PDT)
Received: by mail-io0-f171.google.com with SMTP id m16so10472346iod.1
        for <linux-input@vger.kernel.org>; Fri, 03 Nov 2017 21:35:05 -0700 (PDT)
In-Reply-To: <1509418996-25348-2-git-send-email-hl@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lin Huang <hl@rock-chips.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, robh@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Oct 30, 2017 at 8:03 PM, Lin Huang <hl@rock-chips.com> wrote:
> Document a "reset" and "assert-reset-us", it can be used for
> driver control reset property. And reuse post-power-on-delay-ms
> for deassert reset delay.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> index 28e8bd8..6ab0eed 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -31,7 +31,9 @@ device-specific compatible properties, which should be used in addition to the
>
>  - vdd-supply: phandle of the regulator that provides the supply voltage.
>  - post-power-on-delay-ms: time required by the device after enabling its regulators
> -  before it is ready for communication. Must be used with 'vdd-supply'.
> +  or deassert reset pin before it is ready for communication.
> +- reset: phandle of the gpio that provides for hid reset pin.
> +- assert-reset-us: the device require reset assert time.

If there was any point in adding the device-specific description
around "wacom,w9013"...then you should probably mention these
properties there too. The idea was to document possible properties
here (where you're adding them already), and to note the property
names under the devices (or so far, just 1 device) that support them.
Or IOW, you need an addition like this:

 - compatible:
   * "wacom,w9013" (Wacom W9013 digitizer). Supports:
     - vdd-supply
     - post-power-on-delay-ms
+    - reset-gpios
+    - assert-reset-us

Brian
