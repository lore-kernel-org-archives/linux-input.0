From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/26] Input: synaptics-rmi4 - f11: add support for kernel tracking
Date: Mon, 9 Nov 2015 14:07:04 +0100
Message-ID: <CACRpkdZP646qJ=RTHsHSy4-xKMn70t2sSh9HTVdy-buUfW6DpQ@mail.gmail.com>
References: <1446766794-30715-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36101 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbKINHF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:07:05 -0500
Received: by obdgf3 with SMTP id gf3so138814469obd.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:07:04 -0800 (PST)
In-Reply-To: <1446766794-30715-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:39 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Kernel tracking is used in 2 use cases:
> - filter out jumps when the sensor is not relieable enough
> - provide a MT protocol B when the sensor is providing MT protocol A data
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Should also be squashed into the F11 driver patch I guess.

Yours,
Linus Walleij
