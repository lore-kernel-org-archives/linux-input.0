From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 3/3] Input: qt1070 - Add OF device ID table
Date: Thu, 23 Feb 2017 09:39:08 -0300
Message-ID: <a3e6c909-76d5-1a75-5933-485c0587d67b@osg.samsung.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <20170221181254.14748-3-javier@osg.samsung.com>
 <20170223082524.GB18639@dtor-ws> <20170223082751.GC18639@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:49625
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751070AbdBWMjQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 07:39:16 -0500
In-Reply-To: <20170223082751.GC18639@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

Hello Dmitry,

On 02/23/2017 05:27 AM, Dmitry Torokhov wrote:
> On Thu, Feb 23, 2017 at 12:25:24AM -0800, Dmitry Torokhov wrote:
>> On Tue, Feb 21, 2017 at 03:12:54PM -0300, Javier Martinez Canillas wrote:
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
>>
>> Are you saying that all legacy I2C names now form DT ABI? Even for
>> drivers that do not have of_match_table or OF MODULE_DEVICE_TABLE not
>> binding documentation?
>>
>> I think this is a bit too much.
> 
> Ah, I see that it is actually used in various DTSes.
>

Yes, I'm only posting patches for drivers whose I2C device ID .name are
either used by a DTS or its .name mentioned in a binding as a compatible.

The idea is to eventually fix the I2C core to report a proper of MODALIAS
so people won't have to add a duplicated I2C device ID table only for it.
 
> OK, I think we still need the proper compatible ("atmel,qt1070") along
> with the legacy compatible string.
>

I didn't add it because no DTS or DT binding doc mentions the complete
compatible string, so I would had to guess the vendor prefix. Yes, it's
quite likely "atmel", but how can I tell if that's really the case?

IOW, I just want to make sure that no driver module auto-loading will
regress once the I2C core starts reporting MODALIAS=of:N*T*Cqt1070
instead MODALIAS=i2c:qt1070. So I would prefer if someone who cares
about this driver can propose a patch on top to add the compatible
with a vendor prefix.

>>
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> ---
>>>
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
