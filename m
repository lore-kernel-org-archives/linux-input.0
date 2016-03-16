From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Tue, 15 Mar 2016 17:17:57 -0700
Message-ID: <CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<1458082753.4785.27.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35838 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcCPAR5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 20:17:57 -0400
Received: by mail-pf0-f177.google.com with SMTP id n5so49743078pfn.2
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2016 17:17:57 -0700 (PDT)
In-Reply-To: <1458082753.4785.27.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Bastien,

Thanks for providing this suggestion. I can see this approach work for
situations like screen rotation on tablets. The device I'm involved
with is an input device, which needs a high poll rate for acceleration
/ velocity and needs to be paired with the button / axes data. Evdev
would be most appropriate.

Thanks,
Roderick

On Tue, Mar 15, 2016 at 3:59 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-03-15 at 12:26 -0700, Roderick Colenbrander wrote:
>> Hi all,
>>
>> I'm working on a device driver for an input device, which has both
>> directional axes in addition to sensors (accelerometer and gyro). I'm
>> trying to figure out how to map these axes properly, but I'm
>> stumbling
>> on some road blocks.
>
> Depending on what your device is, you might be looking for the IIO sub-
> system instead, which hosts most of the sensor-type drivers.
>
> iio-sensor-proxy is one of the daemon that can consume data from it
> (even if somewhat unelegantly these days).
>
> Cheers
