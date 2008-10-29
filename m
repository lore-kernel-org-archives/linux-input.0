From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [RFC] Matrix keypad driver for Cirrus EP93xx
Date: Wed, 29 Oct 2008 13:21:02 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909C2891C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909BD0BCD@mi8nycmail19.Mi8.com> <20081029040943.GD27906@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og108.obsmtp.com ([64.18.1.21]:34844 "HELO
	exprod6og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752841AbYJ2RVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2008 13:21:23 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20081029040943.GD27906@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday, October 28, 2008 9:10 PM, Dmitry Torokhov wrote:
>> Following is a new input keyboard driver for the Cirrus Logic EP93xx 
>> keypad matrix peripheral. This driver is based on the pxa27x_keypad 
>> driver.
>> 
>> This is my first driver submission please forgive me if this is the 
>> wrong place or something is just plain wrong.
>> 
>
> The driver looks great, can I please have your "Signed-off-by" so I
> can apply it to the 'next' branch? Thanks!

Hello Dmitry,

Thanks for the positive response.  I did not initially add the
Signed-off-by since I figured I would have to fix something. ;-)

The part you reviewed is complete but arch/arm/mach-ep93xx/clock.c needs
to be patched to support the "key_clk" used by this driver. I have the
patch ready but still need to submit it to the linux-arm-kernel list for
review.

Thanks,
Hartley

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
