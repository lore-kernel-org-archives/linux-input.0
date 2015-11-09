From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 14/26] Input: synaptics-rmi4: Clean up Makefile
Date: Mon, 9 Nov 2015 14:12:35 +0100
Message-ID: <CACRpkdYr1bnjVF2Brv+CargLnbUvU153Z_RLO0mEUWsLhjTmZg@mail.gmail.com>
References: <1446766843-30852-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34277 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbKINMg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 08:12:36 -0500
Received: by obbza9 with SMTP id za9so139629280obb.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 05:12:35 -0800 (PST)
In-Reply-To: <1446766843-30852-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:40 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> The Makefile contained commands for a different build environment. These
> should be removed and are not needed in the upstream kernel.
>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Squash into the offending commit.

Yours,
Linus Walleij
