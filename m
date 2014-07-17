From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4] Input: Add driver for Microchip's CAP1106
Date: Thu, 17 Jul 2014 09:55:54 +0200
Message-ID: <53C7818A.30703@zonque.org>
References: <1405348082-24210-1-git-send-email-zonque@gmail.com> <20140714184642.GA38980@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:56640 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbaGQHz6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2014 03:55:58 -0400
In-Reply-To: <20140714184642.GA38980@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, dh.herrmann@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com

On 07/14/2014 08:46 PM, Dmitry Torokhov wrote:
> On Mon, Jul 14, 2014 at 04:28:02PM +0200, Daniel Mack wrote:
>> +
>> +static int cap1106_i2c_remove(struct i2c_client *i2c_client)
>> +{
>> +	struct cap1106_priv *priv = i2c_get_clientdata(i2c_client);
>> +
>> +	input_unregister_device(priv->idev);
>> +
> 
> No need to call unregister on managed input devices.

Addressed in v5, which I posted already.

> Otherwise if DT guys are happy with bindings I am happy with the patch.

That seems to be the case. I guess we're done then :)

Thanks again for the reviews, everyone.


Daniel

