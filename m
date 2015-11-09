From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 13/26] Input: synaptics-rmi4: Add device tree support for
 RMI4 I2C devices
Date: Mon, 9 Nov 2015 14:11:49 +0100
Message-ID: <CACRpkdaGPbKGTL6bEv6OQ7ck6hk-8iBeY25R4kpv=-Q08+VxrA@mail.gmail.com>
References: <1446766828-30806-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766828-30806-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:40 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Add devicetree binding for I2C devices and add bindings for optional
> parameters in the function drivers. Parameters for function drivers are
> defined in child nodes for each of the functions.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

This patch needs to also be sent to
Cc: devicetree@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
