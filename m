From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 12/33] Input: axp20x-pek - Use devm_add_action_or_reset
 and other changes
Date: Thu, 2 Feb 2017 15:43:44 +0800
Message-ID: <CAGb2v64i6Bb5OeWqdZs4mg0rdq8YsxOud31=dYuA1MO487B_Cw@mail.gmail.com>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net> <1484761614-12225-13-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48544 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdBBHoI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 02:44:08 -0500
In-Reply-To: <1484761614-12225-13-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>

On Thu, Jan 19, 2017 at 1:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Replace devm_add_action() followed by failure action with
> devm_add_action_or_reset()
>
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Replace devm_add_action() followed by failure action with
>   devm_add_action_or_reset()
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
