From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [PATCH 1/2] Input: at32psif: handle clk_enable return value
Date: Fri, 11 Sep 2015 11:21:55 +0800
Message-ID: <55F248D3.1090804@linaro.org>
References: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
 <CAOMZO5C_JSsZY=J9a_+Co2+AYeV0HGPDGy-Z5EBBDmKmjgmSjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33547 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbIKDWR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 23:22:17 -0400
Received: by pacex6 with SMTP id ex6so61651194pac.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 20:22:16 -0700 (PDT)
In-Reply-To: <CAOMZO5C_JSsZY=J9a_+Co2+AYeV0HGPDGy-Z5EBBDmKmjgmSjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org



On Friday, September 11, 2015 11:10 AM, Fabio Estevam wrote:
> On Fri, Sep 11, 2015 at 12:02 AM, WEN Pingbo <pingbo.wen@linaro.org> wrote:
>
>> -       clk_enable(psif->pclk);
>> +       retval = clk_enable(psif->pclk);
>> +       if (retval < 0)
>> +               dev_err(&psif->pdev->dev,
>> +                       "could not enable pclk, ret %d\n", retval);
> Shouldn't you add a 'return' here to prevent the code to proceed with
> the failed clock?
Yes, it should be there. I will re-send the patch. Thank you.
