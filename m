From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/5] Input: elan_i2c: Export the device id whitelist
Date: Thu, 20 Jun 2019 21:34:10 -0700
Message-ID: <CAKdAkRRstvEWXtwnLCMKoW6PcCz0W3+M9iYqVFshJpw6y_=9bA@mail.gmail.com>
References: <20190620142801.11827-1-jeffrey.l.hugo@gmail.com> <20190620143318.11880-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620143318.11880-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org, Lee Jones <lee.jones@linaro.org>, xnox@ubuntu.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Jeffrey,

On Thu, Jun 20, 2019 at 7:33 AM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>  #ifdef CONFIG_OF
> -static const struct of_device_id elan_of_match[] = {
> -       { .compatible = "elan,ekth3000" },
> -       { /* sentinel */ }
> -};

I think OF IDs should stay in this file since we agreed HID will not
be checking them.

>  MODULE_DEVICE_TABLE(of, elan_of_match);
>  #endif
>
> diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
> new file mode 100644
> index 000000000000..8130bbebbdda
> --- /dev/null
> +++ b/include/linux/input/elan-i2c-ids.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Elan I2C Touchpad devide whitelist

s/devide/device/

> + *
> + * Copyright (C) 2019 Jeffrey Hugo.  All rights reserved.

This just moves the code around. If anything I'd say it should keep
the original Elan copyright.

Thanks.

-- 
Dmitry
