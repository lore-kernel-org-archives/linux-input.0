From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tc3589x-keypad - remove stray ')'
Date: Mon, 23 May 2016 15:52:26 -0700
Message-ID: <20160523225226.GF20465@dtor-ws>
References: <1463926811-2921-1-git-send-email-clifton.a.barnes@gmail.com>
 <CACRpkdZQZBwJFnKsh9D5R_AE5iNTe2c5Nh7fkvSFVOj62-m4Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33193 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcEWWw3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 18:52:29 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZQZBwJFnKsh9D5R_AE5iNTe2c5Nh7fkvSFVOj62-m4Jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Clifton Barnes <clifton.a.barnes@gmail.com>, Himangi Saraogi <himangi774@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, May 23, 2016 at 03:26:56PM +0200, Linus Walleij wrote:
> On Sun, May 22, 2016 at 4:20 PM, Clifton Barnes
> <clifton.a.barnes@gmail.com> wrote:
> 
> > The end ')' needs to be removed if the macro is ever used or there
> > would be a compiler error as it does not have a matching '('.
> >
> > Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
