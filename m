From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 23/26] Input: synaptics-rmi4: move structures and
 definitions to rmi.h
Date: Mon, 9 Nov 2015 14:34:28 +0100
Message-ID: <CACRpkdZk3fWpM7E4-zA=ZaN1imH3j44q2WidauiMgAtNUQCoyg@mail.gmail.com>
References: <1446766961-31259-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33283 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbKINe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:34:29 -0500
Received: by obbww6 with SMTP id ww6so113228846obb.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:34:28 -0800 (PST)
In-Reply-To: <1446766961-31259-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Move all of the structures and function definitions needed by hid-rmi
> into rmi.h so that they can be accessed by hid-rmi.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Should be squashed into the core patch I guess so it is om
<linux/rmi4.h> from the beginning.

BTW: -M to git-format-patch detects renames so the patches
get smaller.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
