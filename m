From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 2/3] Input: synaptics_i2c - Add OF device ID table
Date: Thu, 23 Feb 2017 09:40:41 -0300
Message-ID: <25a045ad-70b9-5f07-dc09-cb6594512f20@osg.samsung.com>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <20170221181254.14748-2-javier@osg.samsung.com>
 <20170223083143.GD18639@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170223083143.GD18639@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-kernel@vger.kernel.org, Aniroop Mathur <a.mathur@samsung.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

On 02/23/2017 05:31 AM, Dmitry Torokhov wrote:
> On Tue, Feb 21, 2017 at 03:12:53PM -0300, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
> 
> This driver is for touchpad controller on a specific device, and as far
> as I understand, for a specific firmware. I am not sure if it will ever
> be reused.
> 
> Igor, maybe we need to drop it altogether?
> 

It's used in a mainline DTS (arch/arm/boot/dts/imx23-sansa.dts), that's why
I included in the set.

>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
