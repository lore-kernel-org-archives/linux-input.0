From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v5 2/3] cap11xx: Add support for various cap11xx devices
Date: Fri, 10 Oct 2014 14:06:54 -0700
Message-ID: <CAKzfze8phR4-mxUHVnZh+1vZANaL=8T6LKR68bfwy2CA1b2b9Q@mail.gmail.com>
References: <1412914983-3742-1-git-send-email-mranostay@gmail.com>
	<1412914983-3742-3-git-send-email-mranostay@gmail.com>
	<20141010172952.GA32974@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33099 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaJJVGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2014 17:06:55 -0400
In-Reply-To: <20141010172952.GA32974@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kumar Gala <galak@codeaurora.org>, Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

No  just an oversight..

Thanks,

Matt

On Fri, Oct 10, 2014 at 10:29 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Matt,
>
> On Thu, Oct 09, 2014 at 09:23:02PM -0700, Matt Ranostay wrote:
>> @@ -63,7 +60,25 @@ struct cap11xx_priv {
>>       struct input_dev *idev;
>>
>>       /* config */
>> -     unsigned short keycodes[CAP11XX_NUM_CHN];
>> +     unsigned int num_channels;
>> +     u32 keycodes[];
>
> Any particular reason you decided to keep num_channels field givfen that
> the same data is accessible through priv->idev->keycodemax?
>
> Thanks.
>
> --
> Dmitry
