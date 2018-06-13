From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time
 configuration
Date: Wed, 13 Jun 2018 08:47:17 +0300
Message-ID: <f9354bee-3e44-eb93-05bc-58b8a9078b72@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-4-andr2000@gmail.com> <20180612220722.GA38773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612220722.GA38773@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 06/13/2018 01:07 AM, Dmitry Torokhov wrote:
> On Tue, Jun 12, 2018 at 10:48:56AM +0300, Oleksandr Andrushchenko wrote:
>>   
>> +	if (!(with_kbd | with_ptr | with_mtouch)) {
> I changed this to logical "OR" and applied, thank you.
Yes, that's better, thank you
>> +		ret = -ENXIO;
>> +		goto error;
>> +	}
>> +
>>   	ret = xenkbd_connect_backend(dev, info);
>>   	if (ret < 0)
>>   		goto error;
>> -- 
>> 2.17.1
>>
