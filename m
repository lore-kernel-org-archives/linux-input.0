From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 21/26] Input: synaptics-rmi4: Add support for F12
Date: Mon, 9 Nov 2015 14:27:58 +0100
Message-ID: <CACRpkdYpLUhRN7Sf96ySLrJkBd2dfjKdc1QH+Ci4QzyAjGdJ_A@mail.gmail.com>
References: <1446766937-31168-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35502 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbKIN16 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:27:58 -0500
Received: by obbnk6 with SMTP id nk6so7307420obb.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:27:58 -0800 (PST)
In-Reply-To: <1446766937-31168-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:42 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Function 12 implements 2D touch position sensor for newer Synaptics touch
> devices. It replaces F11 and no device will contain both functions.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
(...)
> +config RMI4_F12
> +       bool "RMI4 Function 12 (2D pointing)"
> +       depends on RMI4_2D_SENSOR

So this properly depends on RMI4_2D_SENSOR (you missed this for F11
IIUC).

But I think the approach to have it select RMI4_2D_SENSOR (which is
to be hidden) is a better approach.

This stand-alone F12 patch is nice though, that is how all patches
should look: add a function.

Yours,
Linus Walleij
