From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v1 31/63] Input: atmel_mxt_ts - add memory access
 interface via sysfs
Date: Fri, 23 Aug 2019 12:00:49 +0900
Message-ID: <94d1ef09-811b-4109-e3d4-4f4f4e9ac89c@mentor.com>
References: <20190816083451.18947-1-jiada_wang@mentor.com>
 <20190816083451.18947-2-jiada_wang@mentor.com>
 <20190816172920.GK121898@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816172920.GK121898@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry

On 2019/08/17 2:29, Dmitry Torokhov wrote:
> On Fri, Aug 16, 2019 at 05:34:19PM +0900, Jiada Wang wrote:
>> From: Nick Dyer <nick.dyer@itdev.co.uk>
>>
>> Atmel maXTouch chips can be addressed via an "Object Based Protocol" which
>> defines how i2c registers are mapped to different functions within the
>> chips. This interface exposes the register map and allows user-space
>> utilities to inspect and alter object configuration, and to view diagnostic
>> data, while the device is running.
> 
> I'd say if we want this we should look into write support in regmap and
> switching the driver over.
> 
since switch to regmap is non-trival, I will drop this patch in v2 patchset

Thanks,
Jiada
> Thanks.
> 
