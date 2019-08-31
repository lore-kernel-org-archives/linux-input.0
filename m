From: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v3 01/11] checkpatch: check for nested (un)?likely() calls
Date: Sat, 31 Aug 2019 20:07:34 +0300
Message-ID: <c5e4479d-2fb3-b5a5-00c3-b06e5177d869@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
 <0d9345ed-f16a-de0b-6125-1f663765eb46@web.de>
 <689c8baf-2298-f086-3461-5cd1cdd191c6@linux.com>
 <493a7377-2de9-1d44-cd8f-c658793d15db@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <493a7377-2de9-1d44-cd8f-c658793d15db@web.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anton Altaparmakov <anton@tuxera.com>, Andy Whitcroft <apw@canonical.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Boris Pismenny <borisp@mellanox.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Leon Romanovsky <leon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, linux-rdma@vger.kernel.org, linux-wimax@intel.com
List-Id: linux-input@vger.kernel.org



On 31.08.2019 19:45, Markus Elfring wrote:
>>>> +# nested likely/unlikely calls
>>>> +        if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>>>> +            WARN("LIKELY_MISUSE",
>>>
>>> How do you think about to use the specification “(?:IS_ERR(?:_(?:OR_NULL|VALUE))?|WARN)”
>>> in this regular expression?
> …
>>    IS_ERR
>>    (?:_ <- Another atomic group just to show that '_' is a common prefix?
> 
> Yes. - I hope that this specification detail can help a bit.

I'm not sure that another pair of brackets for a single char worth it.

>>            Usually, Perl interpreter is very good at optimizing such things.

The interpreter optimizes it internally:
echo 'IS_ERR_OR_NULL' | perl -Mre=debug -ne '/IS_ERR(?:_OR_NULL|_VALUE)?/ && print'
Compiling REx "IS_ERR(?:_OR_NULL|_VALUE)?"
Final program:
   1: EXACT <IS_ERR> (4)
   4: CURLYX[0]{0,1} (16)
   6:   EXACT <_> (8)      <-- common prefix
   8:   TRIE-EXACT[OV] (15)
        <OR_NULL> 
        <VALUE>
...
> 
> Would you like to help this software component by omitting a pair of
> non-capturing parentheses at the beginning?
> 
> \b(?:un)?likely\s*

This pair of brackets is required to match "unlikely" and it's
optional in order to match "likely".

Regards,
Denis
