From: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v3 09/11] Input: alps - remove unlikely() from IS_ERR*()
 condition
Date: Sat, 31 Aug 2019 18:50:34 +0300
Message-ID: <e1713d4e-c12e-8925-a93a-50da560c6c13@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
 <20190829165025.15750-9-efremov@linux.com> <20190829175039.GA187474@dtor-ws>
 <20190831152500.eg7xqo5ace6wu427@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831152500.eg7xqo5ace6wu427@pali>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 31.08.2019 18:25, Pali Rohár wrote:
> On Thursday 29 August 2019 10:50:39 Dmitry Torokhov wrote:
>> On Thu, Aug 29, 2019 at 07:50:23PM +0300, Denis Efremov wrote:
>>> "unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already uses
>>> unlikely() internally.
>>
>> The keyword here is _internally_.
>>
>> https://lore.kernel.org/lkml/20190821174857.GD76194@dtor-ws/
>>
>> So please no.
> 
> Dmitry and I already rejected this patch, see also linked-list:
> https://lore.kernel.org/lkml/20190820111719.7blyk5jstgwde2ae@pali/
>

Looks like this is a very long recurring story with this patch.
Thanks, for the clarification.

Regards,
Denis
