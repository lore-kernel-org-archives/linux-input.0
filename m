From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/26] Input: synaptics-rmi4 - explicitly request polling
 when needed
Date: Mon, 9 Nov 2015 13:58:08 +0100
Message-ID: <CACRpkdZTquLDC4r1=9-qkfjLEidu8ZS0iqpwHcZfCu+BKuSTVg@mail.gmail.com>
References: <1446766632-30305-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766632-30305-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:37 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Host Notify does not work with neither IRQ nor polling. Allow a RMI4 driver
> to request or not polling depending on the attn_gpio.
>
> When neither the internal IRQ or polling systems are used, the
> transport driver can call rmi_process_interrupt_requests() to
> trigger a process of the alert.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

(...)
> +       } else if (pdata->attn_gpio == RMI_POLLING) {
(...)
> +#define RMI_POLLING    -1

Aeuck ... this thing should be rewritten to use GPIO descriptors
instead of this old number-based stuff.

I'll go in and see if I can take a stab at it.

Yours,
Linus Walleij
