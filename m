From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question: drivers/input/input.c] Why input_no is initialized to
 0 ?
Date: Wed, 19 Nov 2014 12:57:13 -0800
Message-ID: <20141119205713.GG37989@dtor-ws>
References: <CADYu3087SYHPSzzEP+92Kh69fUN7gXS1otAsmT8SfuPLQB3h_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63845 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbaKSU5R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2014 15:57:17 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so1372440iec.25
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2014 12:57:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADYu3087SYHPSzzEP+92Kh69fUN7gXS1otAsmT8SfuPLQB3h_A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Aniroop,

On Thu, Nov 20, 2014 at 01:31:44AM +0530, Aniroop Mathur wrote:
> Dear Mr. Torokhov,
> Greetings of the day ! :)
> 
> Recently, I saw input_allocate_device() funtion in input.c file and
> faced one small doubt about it.
> Unfortunately, I could not find the decent answer on internet. Can you
> help to answer the query as follows:
> 
> In this function, input_no is initialized to 0.
> static atomic_t input_no = ATOMIC_INIT(0);
> and then it is used to set input device name like below:
> dev_set_name(&dev->dev, "input%ld", (unsigned long)
> atomic_inc_return(&input_no) - 1);
> 
> Here, we are increamenting input no by 1 and then again decreamenting by 1.
> I think, it is because we have initialized input_no to 0 and we want
> name of input devices to start from input0.
> 
> Is it not a good idea to initialize input_no to -1 and then only
> increamenting input_no without subtracting when setting input device
> name ?
> With this, we will be able to save one extra subtraction instruction
> every time input device is allocated.

Historically atomic_t on sparc32 had only 24 usable bits so I think
setting it to -1 would not have worked. Now it is no longer a concern,
but neither that extra subtraction is expensive so nobody bothered to
change it.

Thanks.

-- 
Dmitry
