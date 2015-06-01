From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: stmpe-ts - enforce device tree only mode
Date: Mon, 1 Jun 2015 16:48:58 +0200
Message-ID: <CACRpkdafcesx+S5HCwzREx3WT1XtqkH9wQHB50mTOf-1z+HbLQ@mail.gmail.com>
References: <20150522225832.GA19831@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150522225832.GA19831@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, May 23, 2015 at 12:58 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The STMPE MFD is only used with device tree configured systems (and STMPE
> MFD core depends on OF), so force the configuration to come from device
> tree only.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
