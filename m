From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
 rebased on 4.3
Date: Mon, 30 Nov 2015 09:21:00 +0100
Message-ID: <CACRpkdbtkaXCAdRxwLS-x7zYcy66EA8V3DSc=DO3Wc9P81cqfA@mail.gmail.com>
References: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448496448-25123-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 26, 2015 at 1:07 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> I tried to include all of the feedback I received from the previous
> patches I posted. However, I did not come up with a satisfactory solution
> for allowing function drivers to be built as modules. I think it is fine
> to allow function drivers to be enabled or disabled in the core at build
> time.

I am happy with this. If people need something else they can put
in the work, I'm just happy to have my hardware working.

A large slew of the systems using this will be Androids with
tailored kernels anyway, they will all build this in.

Yours,
Linus Walleij
