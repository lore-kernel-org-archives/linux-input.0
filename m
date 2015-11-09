From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/26] Input: synaptics-rmi4 - prevent oopses when irq
 arrives while the device is not bound
Date: Mon, 9 Nov 2015 13:58:59 +0100
Message-ID: <CACRpkdaAh0_NJDpJHOi0FLRWzkGw=zVthX=u4KVsMbrRGkJt2w@mail.gmail.com>
References: <1446766645-30350-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33353 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbKIM67 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 07:58:59 -0500
Received: by obbww6 with SMTP id ww6so112524655obb.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 04:58:59 -0800 (PST)
In-Reply-To: <1446766645-30350-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:37 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> If the device has been registered but is not populated, we should not
> process any incoming interrupt.
> Make sure the pointers we are following are valid.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

This should just be squashed into the offending commit.

Yours,
Linus Walleij
