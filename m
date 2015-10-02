From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Fri, 2 Oct 2015 10:44:33 -0700
Message-ID: <20151002174433.GD8437@dtor-ws>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CACRpkdaCFgNpHcK9q_rbA5igE3vAnQJeAOkYB0c+a_Grwy2NUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33963 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbJBRog (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 13:44:36 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdaCFgNpHcK9q_rbA5igE3vAnQJeAOkYB0c+a_Grwy2NUA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>

On Fri, Oct 02, 2015 at 03:34:45AM -0700, Linus Walleij wrote:
> On Mon, Jul 27, 2015 at 6:50 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> 
> > In the cases where the gpio chip fails to acquire the current state an
> > error is reported back to gpio_keys. This is currently interpreted as if
> > the line went high, which just confuses the developer.
> >
> > This patch introduces an error print in this case and skipps the
> > reporting of a input event; to aid in debugging this issue.
> >
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
