From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series
 80)
Date: Wed, 16 May 2018 16:48:40 +0800
Message-ID: <602f9462-08f2-10f9-9ad6-1129dee1bca5@canonical.com>
References: <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
 <00f701d3d627$bcf41de0$36dc59a0$@emc.com.tw>
 <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
 <20180516.160915.1252752723511457980.teika@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516.160915.1252752723511457980.teika@gmx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Teika Kazura <teika@gmx.com>, dmitry.torokhov@gmail.com
Cc: benjamin.tissoires@redhat.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 05/16/2018 03:09 PM, Teika Kazura wrote:
> From: Aaron Ma <aaron.ma@canonical.com>
> Date:   Tue, 17 Apr 2018 19:42:27 +0800
> 
>> Could you apply my patch too?
>>
>> It add LEN0096 that Benjamin's patch doesn't include.
>>
>> +	"LEN0096", /* X280 */
> Aaron, in your original patch in last Oct [1], both *LEN0092 and* LEN0096 were aded. Which should be the case, both two, or only LEN0096?

Hi Teika:

Both LEN0096/LENO0092 are needed, so I think my original patch should be
merged, Benjamin's patch only include one of them.

Regards,
Aaron

> 
> [1] https://www.spinics.net/lists/kernel/msg2625450.html
> 
> Teika (Teika kazura)
> 
