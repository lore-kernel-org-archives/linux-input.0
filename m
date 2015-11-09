From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/26] Input: synaptics-rmi4 - f11: allow the top software
 button property to be set
Date: Mon, 9 Nov 2015 14:05:03 +0100
Message-ID: <CACRpkdZA-teSmhfz0gF=D0WEv2+GuYZUYn3OnK11BvkuTXAcLA@mail.gmail.com>
References: <1446766780-30669-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36224 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbKINFD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:05:03 -0500
Received: by oiww189 with SMTP id w189so74750411oiw.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:05:03 -0800 (PST)
In-Reply-To: <1446766780-30669-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:39 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Currently, in PS/2 we only have the PNPIds list to detect the property.
> Unfortunately, it looks like the information is not embeded in the RMI4
> protocol either, so allow the Top software buttons property to be set
> in the platform data.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Should be squashed into whatever patch is adding the F11 driver
I guess.

Yours,
Linus Walleij
