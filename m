From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree
 module device table
Date: Mon, 29 Apr 2019 12:48:40 -0700
Message-ID: <90c8f98d-eabc-c131-aaf5-9ccaec4c9aab@gmail.com>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-2-git-send-email-info@metux.net>
 <20190419074021.tigbyfezmt4erjms@penguin>
 <fc747fb3-e670-79a2-f4bc-b989dee469fa@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc747fb3-e670-79a2-f4bc-b989dee469fa@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 4/24/19 3:48 AM, Enrico Weigelt, metux IT consult wrote:
> On 19.04.19 09:40, Dmitry Torokhov wrote:
>> Hi Enrico,
>>
>> On Tue, Apr 16, 2019 at 09:57:22PM +0200, Enrico Weigelt, metux IT consult wrote:
>>> Little helper macro that declares an oftree module device table,
>>> if CONFIG_OF is enabled. Otherwise it's just noop.
>>>
>>> This is also helpful if some drivers can be built w/ or w/o
>>> oftree support.
>>
>> This should go to OF folks, please.
> 
> hmm, they should be CCed, if my script works right.
> This one is only needed for the 4th patch (skip oftree...).

Your script did not work (BTDT).  I just happened to notice this on lkml.

-Frank

> 
> 
> --mtx
> 
