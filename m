From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [RFC] Matrix keypad driver for Cirrus EP93xx
Date: Wed, 3 Dec 2008 12:39:44 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909E0E8ED@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909BD0BCD@mi8nycmail19.Mi8.com> <20081029040943.GD27906@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:37902 "HELO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751005AbYLCRkb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2008 12:40:31 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20081029040943.GD27906@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday, October 28, 2008 9:10 PM, Dmitry Torokhov wrote:
>> Hello all,
>> 
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

Dmitry,

Did you get my "Signed-off-by"?  What is that status of this driver
submission?  

I still need to add support to arm/mach-ep93xx for the key_clk but
Russell has added a new simple clk API to arm.  I'm waiting for that to
show up in the kernel so I can add it correctly.

Do you want to hold off applying the driver until that happens?  If so I
can re-submit the driver with all the necessary pieces at that time.

Thanks,
Hartley
