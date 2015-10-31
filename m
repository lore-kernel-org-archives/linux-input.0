From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Sat, 31 Oct 2015 21:41:10 +0100
Message-ID: <CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150723171041.GA14941@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150723171041.GA14941@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 23, 2015 at 7:10 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:

> Dmitry, the Sony guys are currently working on upstreaming their work.
> Their Xperia are using a Synaptics I2C touchscreen. They are able to
> boot with an upstream kernel a lot of parts now, and they will
> eventually need the upstream touch controller.

I have a Synaptics touchscreen thing since 2010 waiting in
drivers/staging/ste_rmi4.

Is there *anything* I can do to help further this?

It just seems like a massive body of code that doesn't get the
right love, Benjamin have you considered just merging this into
drivers/staging so it is simple for everyone to participate, or are there
infrastructural blockers?

Yours,
Linus Walleij
