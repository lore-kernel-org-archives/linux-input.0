From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 26/26] Input: synaptics-rmi4: Change the rmi device's name
 to be less generic
Date: Mon, 9 Nov 2015 14:38:02 +0100
Message-ID: <CACRpkdY6FxZWv4fKkYA98SeM40BGimOVi04phDjRGyAdBbPXFA@mail.gmail.com>
References: <1446767000-31398-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34739 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbKINiD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:38:03 -0500
Received: by oies6 with SMTP id s6so56663535oie.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:38:02 -0800 (PST)
In-Reply-To: <1446767000-31398-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:43 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Currently, the rmi device has the name sensorXX. Sensor is very generic
> and in cases when there is little context it is hard to tell what the
> device is (ie in /sys/devices or /proc/interrupts). This patch changes
> the name to rmiXX which at least indicates that it is an rmi device.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> Linus Walleij suggested that we use the TM number as the device name.
> But, we need to set the device name when we add the device before we
> read the TM number. Changing the name to rmiXX is a compromise since
> it's not as unique as the TM, but not as generic as sensor.

OK OK I give up. No big deal anyway, the device works.
Squash into core patch?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
