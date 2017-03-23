From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 3/3] Input: qt1070 - Add OF device ID table
Date: Thu, 23 Mar 2017 16:14:56 -0300
Message-ID: <387639b5-01f4-2ba7-3065-5679571c08db@osg.samsung.com>
References: <20170222144005.23447-1-javier@osg.samsung.com>
 <20170222144005.23447-3-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222144005.23447-3-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

On 02/22/2017 11:40 AM, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> The compatible strings don't have a vendor prefix because that's how it's
> used currently, and changing this will be a Device Tree ABI break.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 

What's your decision about this patch series?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
