From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C
 transport driver
Date: Fri, 30 Sep 2016 20:03:29 -0700
Message-ID: <66fca804-53e3-6bae-b1af-dd3cd2187ac6@roeck-us.net>
References: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
 <20160929175540.GF7509@tuxbot> <20160930225403.GG30208@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45063 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbcJADDd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Sep 2016 23:03:33 -0400
In-Reply-To: <20160930225403.GG30208@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On 09/30/2016 03:54 PM, Dmitry Torokhov wrote:
> On Thu, Sep 29, 2016 at 10:55:40AM -0700, Bjorn Andersson wrote:
>> On Wed 28 Sep 17:37 PDT 2016, Guenter Roeck wrote:
>>
>>> Instantiating the rmi4 I2C transport driver without interrupts assigned
>>> (for example using manual i2c instantiation from the command line)
>>> caused the driver to fail to load, but it does not clean up its
>>> regulator or transport device registrations. Result is a crash at a later
>>> time, for example when rebooting the system.
>>>
>>> Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
>>
>> Sorry for that.
>>
>>> Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Applied, thank you.
>
> It looks like we have similar issue in rmi_spi.c. Can I get another
> patch?
>

Sure.

Guenter


