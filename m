From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 3/8] Input: synaptics-rmi4: Add dribble and palm
 gesture parameters to device tree
Date: Fri, 22 Jul 2016 17:08:38 +0200
Message-ID: <CACRpkdYqNZEZxzcf6sqSUPcCiq=yhX86XhNA1BrBMjwoe_9m-A@mail.gmail.com>
References: <1468476522-8032-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468476522-8032-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 14, 2016 at 8:08 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> This version includes Nick's suggestion of adding force to the device tree
> parameters so make it obvious that these parameters overwrite the
> default values set in the firware config.

Looks neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
