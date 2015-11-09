From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/26] Input: synaptics-rmi4 - call rmi_driver_process_config_requests
 in enable_sensor
Date: Mon, 9 Nov 2015 13:59:55 +0100
Message-ID: <CACRpkdbmszFP9J6Pv4ozB7jnD-voLkNXeREtJ1SDDUYQOU5t5A@mail.gmail.com>
References: <1446766659-30398-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35820 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbbKIM74 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 07:59:56 -0500
Received: by obbnk6 with SMTP id nk6so6754886obb.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 04:59:56 -0800 (PST)
In-Reply-To: <1446766659-30398-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:37 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> The SMBus devices have their IRQs disabled after a reset. We need to
> configure them by calling rmi_driver_process_config_request() when
> enabling the sensor.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
