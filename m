From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 09/33] Input: sun4i-lradc-keys - Drop unnecessary call to
 platform_set_drvdata and other changes
Date: Thu, 2 Feb 2017 15:45:05 +0800
Message-ID: <CAGb2v66xRG7ubPqjTEzUk=fRY0h6MKK-UFePpbBE7nLiK7qaoA@mail.gmail.com>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net> <1484761614-12225-10-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48554 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdBBHp3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 02:45:29 -0500
In-Reply-To: <1484761614-12225-10-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Thu, Jan 19, 2017 at 1:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to platform_set_drvdata().
> Other relevant changes:
>   Simplify error return
>
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Replace 'if (e) return e; return 0;' with 'return e;'
> - Drop platform_set_drvdata()
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
