From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] Input: Add Microchip AR1021 i2c touchscreen
Date: Thu, 9 Oct 2014 09:39:32 +0200
Message-ID: <CAH9NwWd95RL996nWWYi-shX5uJFTWpFRt56ftQ6-fgLUShHo-g@mail.gmail.com>
References: <1412779518-16712-1-git-send-email-christian.gmeiner@gmail.com> <20141008175649.GB14423@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48535 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaJIHjy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 03:39:54 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so12269065wiv.17
        for <linux-input@vger.kernel.org>; Thu, 09 Oct 2014 00:39:52 -0700 (PDT)
In-Reply-To: <20141008175649.GB14423@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Dmitry,

> On Wed, Oct 08, 2014 at 04:45:18PM +0200, Christian Gmeiner wrote:
>> +static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>> +{
>> +     struct ar1021_i2c *ar1021 = dev_id;
>> +     struct input_dev *input = ar1021->input;
>> +     u8 *data = ar1021->data;
>> +     unsigned int x, y, button;
>> +     int error;
>> +
>> +     error = i2c_master_recv(ar1021->client,
>> +                             ar1021->data, sizeof(ar1021->data));
>> +     if (error < 0)
>
> I think this check should be "if (retval != sizeof(ar1021->data))" to
> avoid using garbage data in case of short read. I'll change it locally
> and apply the patch.

Sounds good to me.

thanks
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
