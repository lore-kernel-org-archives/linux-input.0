From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 14:43:35 +0200
Message-ID: <5347568.3SpFZiqxSr@wuerfel>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com> <1476761253-13450-4-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:51550 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbcJ1Mnj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 08:43:39 -0400
In-Reply-To: <1476761253-13450-4-git-send-email-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org

On Monday, October 17, 2016 8:27:32 PM CEST Deepa Dinamani wrote:
> @@ -55,24 +60,24 @@ struct ff_effect_compat {
>  
>  static inline size_t input_event_size(void)
>  {
> -       return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
> -               sizeof(struct input_event_compat) : sizeof(struct input_event);
> +       return in_compat_syscall() ? sizeof(struct raw_input_event_compat) :
> +                                    sizeof(struct raw_input_event);
>  }

I think the COMPAT_USE_64BIT_TIME check has to stay here,
it's needed for x32 mode on x86-64.

	Arnd
