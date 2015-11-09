From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 25/26] Input: synaptics-rmi4: remove sensor_name in
 platform data
Date: Mon, 9 Nov 2015 14:36:43 +0100
Message-ID: <CACRpkdb2pzYBB8UcUm=Pw9ZL=M4dy69t=0wbJdBP5rHGYmi44w@mail.gmail.com>
References: <1446766985-31350-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36519 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbKINgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:36:43 -0500
Received: by obdgf3 with SMTP id gf3so139395702obd.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:36:43 -0800 (PST)
In-Reply-To: <1446766985-31350-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:43 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> The platform data contained a sensor_name string which was used in debug
> logs to identify the device. But, the logs already contain enough
> information to uniquely identify the device. This patch removes the
> sensor_name and substitutes the transport device's name or the
> rmi device's when needed.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Exactly like this. Squash into the affected patches.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
