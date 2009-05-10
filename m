From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Sun, 10 May 2009 13:15:44 -0700
Message-ID: <200905101315.45564.dmitry.torokhov@gmail.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com> <20090509195446.GA1617@dtor-d630.eng.vmware.com> <4A06ADD4.8010601@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:34383 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZEJUQB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2009 16:16:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1902095rvb.1
        for <linux-input@vger.kernel.org>; Sun, 10 May 2009 13:16:02 -0700 (PDT)
In-Reply-To: <4A06ADD4.8010601@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Wan,

On Sunday 10 May 2009 03:35:00 Wan ZongShun wrote:
>         if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
>                                         w90p910_ts->state == CAN_READY) {
>                 w90p910_report_event(w90p910_ts);
>                 __raw_writel((__raw_readl(w90p910_ts->ts_reg)|
>                                 ADC_WAITTRIG), w90p910_ts->ts_reg);

Thank you very much for the explanation. Could you please tell me when you 
issue ADC_WAITTRIG do you expect to see WT_INT or ADC_INT condition?

Thanks.

-- 
Dmitry
