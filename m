From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 22/26] Input: synaptics-rmi4 - Add F30 support
Date: Sat, 14 Nov 2015 12:35:16 +0100
Message-ID: <CACRpkdYrjLHP8zTF7eVTpGtcY9QBnQDzwsTjkEZzEHibUo+ACQ@mail.gmail.com>
References: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
	<CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
	<CAN+gG=HGj4uvzCBwpEsot7qmxjeB8VyzDhYOwOYmDRQCogWtkg@mail.gmail.com>
	<56412410.4030900@synaptics.com>
	<20151109232557.GG9155@dtor-ws>
	<56439297.8080408@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35009 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbKNLfR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Nov 2015 06:35:17 -0500
Received: by obbnk6 with SMTP id nk6so91925220obb.2
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2015 03:35:16 -0800 (PST)
In-Reply-To: <56439297.8080408@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Allie Xiong <axiong@synaptics.com>

On Wed, Nov 11, 2015 at 8:10 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> I don't know of any non touchpad devices which use F30 and I think it's
> unlikely that there would be any. I think it's really meant for controlling
> the buttons and LEDs which are on the touchpad PCB. There probably isn't
> much reason to wire external GPIOs and LEDs to be controlled by our ASIC*.
> If such a device existed then exporting GPIOs with gpio_chip and using
> gpio-keys seems like a reasonable way to do it. I'm just not sure we will
> have devices which need to use that implementation.
>
> * There is the one exception which is the Lenovo systems which have the
> external physical stick buttons are wired to our ASIC, but that is a special
> case and it's events should be forwarded to the stick's input device instead
> of being reported separately using gpio-keys.

We are aligned here.

Yours,
Linus Walleij
