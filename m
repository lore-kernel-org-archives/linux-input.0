From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: MacBook8,1 (2015) HID Hardware Support
Date: Sun, 20 Sep 2015 03:27:09 +1000
Message-ID: <CAOviyajwMO2ZB2uQrcBPiueVpoVdPRfLLb1WnWUqWngX-QiOLA@mail.gmail.com>
References: <CAOviyajKA-s4Y6a5OfJmtO7H2Uc4bxCZ0dwCnAzA0K=odjegMA@mail.gmail.com>
	<20150919172241.GB7081@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36684 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbbISR1K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 13:27:10 -0400
Received: by igcrk20 with SMTP id rk20so37255027igc.1
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2015 10:27:09 -0700 (PDT)
In-Reply-To: <20150919172241.GB7081@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, jikos@kernel.org, Jochen Radmacher <jradmacher@gmx.de>, Yang Hongyang <burnef@gmail.com>, coldnew.tw@gmail.com, George Hilios <ghilios@gmail.com>, Janez Urevc <janez@janezurevc.name>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> IIRC these models use SPI instead of USB for the keyboard/trackpad, so
> the commits you are referencing will not work for you.

Ah, okay. Figures.

> I do not know if anyone is looking into getting SPI variants to work.

I'm guessing the current effort for supporting Apple hardware in
drivers/hid/ isn't going to be much use if one were to try to
implement a driver for this hardware?


-- 
Aleksa Sarai (cyphar)
www.cyphar.com
