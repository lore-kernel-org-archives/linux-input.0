From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] Input: at32psif: handle clk_enable return value
Date: Fri, 11 Sep 2015 00:10:34 -0300
Message-ID: <CAOMZO5C_JSsZY=J9a_+Co2+AYeV0HGPDGy-Z5EBBDmKmjgmSjA@mail.gmail.com>
References: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33600 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIKDKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 23:10:34 -0400
Received: by igbkq10 with SMTP id kq10so35572527igb.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 20:10:34 -0700 (PDT)
In-Reply-To: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: WEN Pingbo <pingbo.wen@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org

On Fri, Sep 11, 2015 at 12:02 AM, WEN Pingbo <pingbo.wen@linaro.org> wrote:

> -       clk_enable(psif->pclk);
> +       retval = clk_enable(psif->pclk);
> +       if (retval < 0)
> +               dev_err(&psif->pdev->dev,
> +                       "could not enable pclk, ret %d\n", retval);

Shouldn't you add a 'return' here to prevent the code to proceed with
the failed clock?
