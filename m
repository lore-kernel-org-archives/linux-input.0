From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/2] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Mon, 29 Jul 2019 20:14:52 +0200
Message-ID: <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
References: <1564415994-22871-1-git-send-email-info@metux.net>
 <20190729172607.GB755@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729172607.GB755@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 29.07.19 19:26, Dmitry Torokhov wrote:

Hi,

> As I think I mentioned a while back I would prefer to get gpiolob > support swnode-backed properties so that the driver would not need 
to> know about differences between ACPI, DT and static board files.
Indeed would be nice. But I think we should get rid of raw gpio IDs in
favour of gpiod lookup tables first.

> I just recently re-posted patches for this, let's see if we can get them > landed in the kernel.
Can you give me a pointer ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
