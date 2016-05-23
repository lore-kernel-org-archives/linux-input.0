From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: tc3589x-keypad - remove stray ')'
Date: Mon, 23 May 2016 15:26:56 +0200
Message-ID: <CACRpkdZQZBwJFnKsh9D5R_AE5iNTe2c5Nh7fkvSFVOj62-m4Jg@mail.gmail.com>
References: <1463926811-2921-1-git-send-email-clifton.a.barnes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33916 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbcEWN1D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 09:27:03 -0400
Received: by mail-oi0-f48.google.com with SMTP id b65so132664828oia.1
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 06:27:02 -0700 (PDT)
In-Reply-To: <1463926811-2921-1-git-send-email-clifton.a.barnes@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clifton Barnes <clifton.a.barnes@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Himangi Saraogi <himangi774@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, May 22, 2016 at 4:20 PM, Clifton Barnes
<clifton.a.barnes@gmail.com> wrote:

> The end ')' needs to be removed if the macro is ever used or there
> would be a compiler error as it does not have a matching '('.
>
> Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
