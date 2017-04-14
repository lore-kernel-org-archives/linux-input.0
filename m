From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH v2] Input: ar1021-i2c - fix too long name in driver's
 device table
Date: Fri, 14 Apr 2017 09:23:58 +0200
Message-ID: <61ca3a06-4ab9-59a8-ee05-a82493a34de3@ginzinger.com>
References: <20170413233225.GA30465@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:19413 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdDNHYE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2017 03:24:04 -0400
In-Reply-To: <20170413233225.GA30465@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, m.frohiky@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org



On 2017-04-14 01:32, Dmitry Torokhov wrote:
> The name field in structure i2c_device_id is 20 characters, and we expect
> it to be NULL-terminated, however we are trying to stuff it with 21 bytes
> and thus NULL-terminator is lost. This causes issues when one creates
> device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the last "C",
> and automatic module loading by alias does not work as result.
> 
> The -I2C suffix in the device name is superfluous, we know what bus we are
> dealing with, so let's drop it. Also, no other driver uses capitals, and
> the manufacturer name is normally not included, except in very rare cases
> of incompatible name collisions.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
> Fixes: dd4cae8bf166 ("Input: Add Microchip AR1021 i2c touchscreen")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
