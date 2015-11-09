From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/26] Input: synaptics-rmi4 - f11: clean up rmi_f11_finger_handler
Date: Mon, 9 Nov 2015 14:03:49 +0100
Message-ID: <CACRpkdYfy8Oj56g6t0gn+2-+khdkBV-2tj5xsn-o9+mr1zziRg@mail.gmail.com>
References: <1446766762-30624-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33564 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbKINDu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:03:50 -0500
Received: by oiad129 with SMTP id d129so98661145oia.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:03:49 -0800 (PST)
In-Reply-To: <1446766762-30624-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:39 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> abs_bit and rel_bits should not be computed at each iteration of the for
> loop.
> finger_press_count is unused.
> Break out rmi_f11_parse_finger_state in its own function.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
