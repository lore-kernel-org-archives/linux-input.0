From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 3/4] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Wed, 24 Apr 2019 12:59:35 +0200
Message-ID: <9819838f-9e35-c504-61da-f8c3f9b7ac8e@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-4-git-send-email-info@metux.net>
 <20190419074811.7rkq3p6t7s56g4fo@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419074811.7rkq3p6t7s56g4fo@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 19.04.19 09:48, Dmitry Torokhov wrote:

> I would prefer if gpiod API could parse static board data/gpio lookup
> tables for child nodes, instead of adding this to gpio-keys. Now that
> Heikki Krogerus work on software nodes has landed I need to resurrect
> my patch to gpiolib.

Of course, a more generic approach would be better.

I did it that way I wasn't that aware that a more generic approach is
in the pipeline, and I needed something usable now.

The patch is already used in the field and seems to work quite well,
but if I'm alway open for better solutions.

I figure that the generic solution will still take some time, so can we
take this one for the next merge window and rework it in the next one ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
