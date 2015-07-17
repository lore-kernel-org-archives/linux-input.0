From: Marcus Overhagen <marcus.overhagen@gmail.com>
Subject: Re: [PATCH] Input-polldev:Check poll_interval range while registering
 input device
Date: Fri, 17 Jul 2015 22:29:13 +0200
Message-ID: <CAJBHPog=kN71PS+XMQf85MSkdLvknGdZECuyi3r0DD2FmHh4mQ@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32914 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbGQU3P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 16:29:15 -0400
Received: by lbbyj8 with SMTP id yj8so67229153lbb.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 13:29:13 -0700 (PDT)
In-Reply-To: <1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Jul 16, 2015 at 7:57 PM, Anshul Garg <aksgarg1989@gmail.com> wrote:

> +       if (dev->poll_interval > dev->poll_interval_max ||
> +                       dev->poll_interval < dev->poll_interval_min) {
> +               pr_err("Poll interval Range incorrect\n");
> +               return -EINVAL;
> +       }
>
>         if (!dev->poll_interval)
>                 dev->poll_interval = 500;

So priviously, if poll_interval was 0 you got a sane default of 500,
and now you get -EINVAL.

Is this really useful and correct, and nobody using it is passing 0?

regards
Marcus
