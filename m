From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 3/3] Input: qt1070 - Add OF device ID table
Date: Mon, 27 Mar 2017 11:16:31 -0400
Message-ID: <544a9efa-a9b5-326e-4930-b185ab51644c@osg.samsung.com>
References: <20170222144005.23447-1-javier@osg.samsung.com>
 <20170222144005.23447-3-javier@osg.samsung.com>
 <387639b5-01f4-2ba7-3065-5679571c08db@osg.samsung.com>
 <20170323214559.GB11818@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34906
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752439AbdC0PQp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:16:45 -0400
In-Reply-To: <20170323214559.GB11818@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hello Dmitry,

On 03/23/2017 06:45 PM, Dmitry Torokhov wrote:
> On Thu, Mar 23, 2017 at 04:14:56PM -0300, Javier Martinez Canillas wrote:
>> Hello Dmitry,
>>
>> On 02/22/2017 11:40 AM, Javier Martinez Canillas wrote:
>>> The driver doesn't have a struct of_device_id table but supported devices
>>> are registered via Device Trees. This is working on the assumption that a
>>> I2C device registered via OF will always match a legacy I2C device ID and
>>> that the MODALIAS reported will always be of the form i2c:<device>.
>>>
>>> But this could change in the future so the correct approach is to have an
>>> OF device ID table if the devices are registered via OF.
>>>
>>> The compatible strings don't have a vendor prefix because that's how it's
>>> used currently, and changing this will be a Device Tree ABI break.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> ---
>>>
>>
>> What's your decision about this patch series?
> 
> OK, I queued them for -next. Could you also make a patch to update

Great, thanks a lot!

> binding docs for silead?
> 

Of course, I will.

> Thanks!
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
