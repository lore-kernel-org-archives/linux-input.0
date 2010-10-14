From: William Manson <WManson@synaptics.com>
Subject: RE: input: Synaptics touchscreen driver followup
Date: Wed, 13 Oct 2010 19:28:25 -0700
Message-ID: <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5FB@USW-EX2K7-1.synaptics-inc.local>
References: <27F9C60D11D683428E133F85D2BB4A53046845F22B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:62793 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0JNC2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 22:28:33 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53046845F22B@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'Arce, Abraham'" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: Allie Xiong <axiong@synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>, Jean Delvare <khali@linux-fr.org>

Hi Abraham -
What were the compile errors you got? Were they only for building on Omap or do you get them when compiling for other Linux (x86 for example)? I would like to know because we didn't get any compile errors.

Thanks,
William


-----Original Message-----
From: Arce, Abraham [mailto:x0066660@ti.com]
Sent: Wednesday, October 13, 2010 7:11 PM
To: William Manson; linux-input@vger.kernel.org; Dmitry Torokhov
Cc: Allie Xiong; Christopher Heiny; Jean Delvare
Subject: RE: input: Synaptics touchscreen driver followup

Hi William,

> Hi Abraham -
>
> You mentioned you are using the OMap kernel. Is that the 2.6.29 for the
> Omap2/3 or the 2.6.32 for the Omap4? The reason I ask is that this code
> probably won't compile on versions of the kernel earlier than 2.6.31 due to
> architectural changes that were done to i2c.
>

Yes, linux omap, I was working with 2.6.37 rc7... omap2plus_defconfig

Best Regards
Abraham
