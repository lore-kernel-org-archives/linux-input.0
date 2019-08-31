From: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v3 01/11] checkpatch: check for nested (un)?likely() calls
Date: Sat, 31 Aug 2019 18:54:12 +0300
Message-ID: <689c8baf-2298-f086-3461-5cd1cdd191c6@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
 <0d9345ed-f16a-de0b-6125-1f663765eb46@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0d9345ed-f16a-de0b-6125-1f663765eb46@web.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anton Altaparmakov <anton@tuxera.com>, Andy Whitcroft <apw@canonical.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Boris Pismenny <borisp@mellanox.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "David S. Miller" <davem@davemloft.net>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Leon Romanovsky <leon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, linux-rdma@vger.kernel.org, linux-wimax@intel.com
List-Id: linux-input@vger.kernel.org



On 31.08.2019 12:15, Markus Elfring wrote:
>> +# nested likely/unlikely calls
>> +        if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>> +            WARN("LIKELY_MISUSE",
> 
> How do you think about to use the specification “(?:IS_ERR(?:_(?:OR_NULL|VALUE))?|WARN)”
> in this regular expression?

Hmm, 
(?:   <- Catch group is required here, since it is used in diagnostic message,
         see $1
   IS_ERR
   (?:_ <- Another atomic group just to show that '_' is a common prefix?
           I'm not sure about this. Usually, Perl interpreter is very good at optimizing such things.
           You could see this optimization if you run perl with -Mre=debug.
     (?:OR_NULL|VALUE))?|WARN)

Regards,
Denis
