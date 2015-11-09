From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/26] Input: synaptics-rmi4 - add a common input device
 in rmi_driver
Date: Mon, 9 Nov 2015 13:52:32 +0100
Message-ID: <CACRpkdaRLPFkWvF42n-kq7gnN-4Q19KXca+UanghkH-we2QTXg@mail.gmail.com>
References: <1446766616-30258-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33917 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbKIMwc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 07:52:32 -0500
Received: by oies6 with SMTP id s6so56032746oie.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 04:52:32 -0800 (PST)
In-Reply-To: <1446766616-30258-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:36 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> When .unified_input is set to true in the platform data, the
> functions should rely on the common input node created by rmi_driver
> to forward events instead of having their own input node.
>
> This node is named "Synaptics PRODUCT_ID" to be able to
> differentiate the various models.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
