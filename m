From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 22/26] Input: synaptics-rmi4 - Add F30 support
Date: Mon, 9 Nov 2015 14:32:10 +0100
Message-ID: <CACRpkdbGw0ygL+HxBP+vj8+Px6-1O80BbAXYcEsE+uwpz1SBLQ@mail.gmail.com>
References: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34877 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbKINcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:32:11 -0500
Received: by obbnk6 with SMTP id nk6so7390237obb.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:32:10 -0800 (PST)
In-Reply-To: <1446766950-31213-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Allie Xiong <axiong@synaptics.com>

On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> RMI4 Function 0x30 provides support for GPIOs, LEDs and mechanical
> buttons.  In particular, the mechanical button support is used in
> an increasing number of touchpads.
>
> [BT] cured the code to rely only on the unified input node created
> by rmi_driver.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Allie Xiong <axiong@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I see this function driver is not yet adding any gpio_chip or
LEDs class devices, which is fine, we can add that later when
we have something to test. Or is iit using that LED feature
in the input layer that corresponds to caps lock etc?

I don't quite get it I guess :/

But I guess it should also be squashed into the original F30 driver.

Yours,
Linus Waleij
