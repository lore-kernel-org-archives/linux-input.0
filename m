From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Fri, 5 Feb 2016 13:42:06 +0100
Message-ID: <CACRpkdanmC_CWJKpfL5bY7v+N+KM+F1WMf1zZLWOY2mrrj1NCQ@mail.gmail.com>
References: <1454463809-3884-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454463809-3884-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 3, 2016 at 2:43 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> This is the v3 patch series which fixes the issues identified in the
> previous patch series.

For the core, I2C and F01+F11 (what I'm using):
Tested-by: Linus Walleij <linus.walleij@linaro.org>

...provided you apply something like that IRQ patch I just sent.

This looks like it's in pretty nice shape now, I hope Dmitry will
consider merging it so we can get rid of
drivers/staging/ste_rmi4 finally...

Yours,
Linus Walleij
