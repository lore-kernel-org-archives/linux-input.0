From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 17/26] Input: synaptics-rmi4: Remove unused firmware_name variable
Date: Mon, 9 Nov 2015 14:14:54 +0100
Message-ID: <CACRpkdbCmgv4o=nf1YQnYXHL1fHgAy20-0=SMM-3j5anNuT0yg@mail.gmail.com>
References: <1446766888-30987-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33468 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbKINOy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:14:54 -0500
Received: by obbww6 with SMTP id ww6so112842274obb.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:14:54 -0800 (PST)
In-Reply-To: <1446766888-30987-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:41 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> Firmware update is not currently supported in the current state of
> this driver. We can add it back if we need it when implementing
> firmware update.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Squash into core.

Yours,
Linus Walleij
