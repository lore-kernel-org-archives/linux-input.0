From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v4 4/9] drivers: max77693: Move state container to common header
Date: Tue, 14 Jul 2015 10:06:09 +0900
Message-ID: <CAJKOXPdQQZguJ=F1TvJzdAkQ0U4712Vzvs1HrAboBQw47mtaBw@mail.gmail.com>
References: <1436786818-14115-1-git-send-email-k.kozlowski.k@gmail.com>
	<1436786818-14115-5-git-send-email-k.kozlowski.k@gmail.com>
	<55A3BD55.3080900@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33952 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbGNBSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 21:18:37 -0400
In-Reply-To: <55A3BD55.3080900@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

2015-07-13 22:29 GMT+09:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
> Hi Krzysztof,
>
> I have tested leds-max77693 driver with this patch set and it
> works fine.
> Regarding this patch I have one remark: please keep alphabetical
> order and put #include <linux/mfd/max77693-common.h> before
> #include <linux/mfd/max77693-private.h in several places in this
> patch as well as in the patch 5/9.
>
> With those issues addressed:
>
> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

Thanks, I'll reorder the common header and re-spin.

Best regards,
Krzysztof
