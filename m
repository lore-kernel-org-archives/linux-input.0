From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 16/26] Input: synaptics-rmi4: Use ifdef to check if
 CONFIG_PM_SLEEP is set
Date: Mon, 9 Nov 2015 14:14:11 +0100
Message-ID: <CACRpkdadPR9yf-yaNMP+5114wswoBQ_WiorQtZ1-41VoSN3zLw@mail.gmail.com>
References: <1446766870-30942-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446766870-30942-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 6, 2015 at 12:41 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> The pm variables are not included in the struct rmi_driver_data at compile
> time. Using the IS_ENABLED macro in rmi_driver.c will result in a compiler
> error if CONFIG_PM_SLEEP is not enabled.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
