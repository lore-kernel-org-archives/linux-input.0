From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: input: Synaptics touchscreen driver followup
Date: Wed, 13 Oct 2010 21:10:53 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53046845F22B@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A530468370A42@dlee03.ent.ti.com>
 <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5EB@USW-EX2K7-1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53041 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0JNCLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 22:11:08 -0400
In-Reply-To: <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5EB@USW-EX2K7-1.synaptics-inc.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: William Manson <WManson@synaptics.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: Allie Xiong <axiong@synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>, Jean Delvare <khali@linux-fr.org>

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
