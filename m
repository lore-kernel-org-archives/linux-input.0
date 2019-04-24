From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree
 module device table
Date: Wed, 24 Apr 2019 12:48:08 +0200
Message-ID: <fc747fb3-e670-79a2-f4bc-b989dee469fa@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-2-git-send-email-info@metux.net>
 <20190419074021.tigbyfezmt4erjms@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419074021.tigbyfezmt4erjms@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 19.04.19 09:40, Dmitry Torokhov wrote:
> Hi Enrico,
> 
> On Tue, Apr 16, 2019 at 09:57:22PM +0200, Enrico Weigelt, metux IT consult wrote:
>> Little helper macro that declares an oftree module device table,
>> if CONFIG_OF is enabled. Otherwise it's just noop.
>>
>> This is also helpful if some drivers can be built w/ or w/o
>> oftree support.
> 
> This should go to OF folks, please.

hmm, they should be CCed, if my script works right.
This one is only needed for the 4th patch (skip oftree...).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
