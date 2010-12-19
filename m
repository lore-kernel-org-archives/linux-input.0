From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/20] mach-ux500: move keymaps to new file
Date: Sun, 19 Dec 2010 21:53:23 +0100
Message-ID: <AANLkTikMtL=+HJfivh2MVfyzNvT8NyRXVcgPJNEV9XQu@mail.gmail.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-4-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:58410 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0LSUxY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 15:53:24 -0500
In-Reply-To: <1291388753-14662-4-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

2010/12/3 Sundar Iyer <sundar.iyer@stericsson.com>:

> Move keylayouts to a dedicated file and plug these keylayouts
> for input platform data. This will make addition of new and custom
> keylayouts localized.

Managed to rebase this somewhat easily on top of the last
batch of tc3589x MFD patches and pushed for ux500-core,
please check that I didn't screw anything up.

Yours,
Linus Walleij
