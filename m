From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC 2/7] Input: joystick - avoid fragile snprintf use
Date: Wed, 9 Mar 2016 08:49:27 +0200
Message-ID: <CAHp75VckekMWgJOfd1z1ZezGs5RZ3PpymObb49FtikED1T62Eg@mail.gmail.com>
References: <CAGXu5jJ-NApCpANjfz+bAEfwZJ8xizkM-jDHVhOPCzhxV-aqdA@mail.gmail.com>
	<1457469654-17059-1-git-send-email-linux@rasmusvillemoes.dk>
	<1457469654-17059-3-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35090 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcCIGt2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 01:49:28 -0500
In-Reply-To: <1457469654-17059-3-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 10:40 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> Passing overlapping src and dst buffers to snprintf is fragile, and
> while it currently works for the special case of passing dst as the
> argument corresponding to an initial "%s" in the format string, any
> other use would very likely lead to chaos. It's easy enough to avoid,
> so let's do that.

>  static void analog_name(struct analog *analog)
>  {
> -       snprintf(analog->name, sizeof(analog->name), "Analog %d-axis %d-button",
> +       int ret = 0;

Assignment is not needed.

> +
> +       ret = scnprintf(analog->name, sizeof(analog->name), "Analog %d-axis %d-button",



-- 
With Best Regards,
Andy Shevchenko
