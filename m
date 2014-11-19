From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [Question: drivers/input/input.c] Why input_no is initialized to 0 ?
Date: Thu, 20 Nov 2014 01:31:44 +0530
Message-ID: <CADYu3087SYHPSzzEP+92Kh69fUN7gXS1otAsmT8SfuPLQB3h_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:44796 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbaKSUBq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2014 15:01:46 -0500
Received: by mail-la0-f42.google.com with SMTP id s18so1178393lam.29
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2014 12:01:44 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Mr. Torokhov,
Greetings of the day ! :)

Recently, I saw input_allocate_device() funtion in input.c file and
faced one small doubt about it.
Unfortunately, I could not find the decent answer on internet. Can you
help to answer the query as follows:

In this function, input_no is initialized to 0.
static atomic_t input_no = ATOMIC_INIT(0);
and then it is used to set input device name like below:
dev_set_name(&dev->dev, "input%ld", (unsigned long)
atomic_inc_return(&input_no) - 1);

Here, we are increamenting input no by 1 and then again decreamenting by 1.
I think, it is because we have initialized input_no to 0 and we want
name of input devices to start from input0.

Is it not a good idea to initialize input_no to -1 and then only
increamenting input_no without subtracting when setting input device
name ?
With this, we will be able to save one extra subtraction instruction
every time input device is allocated.

Thanks in advance ! :)

Regards,
Aniroop Mathur
