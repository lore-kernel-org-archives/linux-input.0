From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/26] Input: synaptics-rmi4 - f11: use the unified input
 node if available
Date: Mon, 9 Nov 2015 14:03:15 +0100
Message-ID: <CACRpkdZJmAvLqj+LJOZ0ZB0gTHoMr2u73iOWee-Xk82FgP+=ow@mail.gmail.com>
References: <1446766727-30578-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35879 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbKINDP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:03:15 -0500
Received: by obdgf3 with SMTP id gf3so138737125obd.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:03:15 -0800 (PST)
In-Reply-To: <1446766727-30578-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:38 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Is there some device *not* using the unified input node by the
end of the day then, I wonder? Or is that non-unified node a
development artifact that is going away?

Yours,
Linus Walleij
