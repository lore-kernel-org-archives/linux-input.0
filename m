From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] ep93xx_keypad.c: update driver to new core support
Date: Thu, 10 Dec 2009 11:34:10 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB0EB2@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB0DB6@mi8nycmail19.Mi8.com> <20091210031130.GG10138@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og116.obsmtp.com ([64.18.1.37]:53177 "EHLO
	exprod6og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761006AbZLJQjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 11:39:37 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20091210031130.GG10138@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wednesday, December 09, 2009 8:12 PM, Dmitry Torokhov wrote:
> On Wed, Dec 09, 2009 at 05:20:53PM -0500, H Hartley Sweeten wrote:
>> ep93xx_keypad.c: update driver to new core support
>> 
>> This driver was merged before the ep93xx core support was added
>> for the keypad clock and acquiring/releasing the necessary gpio's.
>> Now that the proper support is in the ep93xx core this driver
>> needs to be updated to work correctly.
>> 
>> Summary of changes:
>>   1) Remove some unused members from the platform data.
>>   2) Remove the custom KEY macro and use the ones available in
>>      <linux/input/matrix_keypad.h>
>>   3) Remove the keypad_{readl/writel} macros and just use
>>      __raw_{readl/writel} directly.
>>   4) Update the clk_set_rate() call to work with the core support.
>>   5) Cleanup the probe routine and remove some unneeded messages.
>>   6) Use the ep93xx core functions to acquire and release the gpio's.
>>   7) Fix the clk_get() call to get the keypad clock.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Thank you Hartley. I will change 'enabled' to bool while we are at it
> and apply for the next pull.

Thanks.  Sorry for the trouble with this driver.  :-)

Regards,
Hartley
