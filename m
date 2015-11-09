From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 24/26] Input: synaptics-rmi4: use device managed memory
 for the data packet buffer
Date: Mon, 9 Nov 2015 14:35:22 +0100
Message-ID: <CACRpkdY+4Q1Aji6LhY2yBA9UOVZJb+kvaBd913r=sDvOAAp24A@mail.gmail.com>
References: <1446766973-31304-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36741 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbKINfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:35:23 -0500
Received: by obdgf3 with SMTP id gf3so139368322obd.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:35:22 -0800 (PST)
In-Reply-To: <1446766973-31304-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> The data packet should use device managed memory since the buffer is
> retained until the device goes away.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Squash into F11 patch.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
