From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/2] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Wed, 31 Jul 2019 19:26:51 +0200
Message-ID: <af12954c-2f14-1655-70b1-928f4f20bfe2@metux.net>
References: <1564415994-22871-1-git-send-email-info@metux.net>
 <20190729172607.GB755@penguin>
 <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
 <20190729184306.GA767@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729184306.GA767@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 29.07.19 20:43, Dmitry Torokhov wrote:

Hi,

> https://patchwork.kernel.org/cover/11042915/

Thanks.

> I tried putting you on CC list there, did you not get them?

hmm, maybe it went to one of the dozens of mailboxes where I didn't
look at careful enough ... I'm currently just sorting by mailing list,
but don't separate out stuff that's directly addressed to me - guess
I'll have to fix up my mail filter rules :o

Regarding your patch:

How should I now setup a proper swnode object and pass it to the
driver ?

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
