From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: input: Synaptics touchscreen driver followup
Date: Wed, 13 Oct 2010 21:50:33 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53046845F248@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53046845F22B@dlee03.ent.ti.com>
 <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5FB@USW-EX2K7-1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44024 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab0JNCur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 22:50:47 -0400
In-Reply-To: <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5FB@USW-EX2K7-1.synaptics-inc.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: William Manson <WManson@synaptics.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: Allie Xiong <axiong@synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>, Jean Delvare <khali@linux-fr.org>

Hi William,

> 
> Hi Abraham -
> What were the compile errors you got? Were they only for building on Omap or
> do you get them when compiling for other Linux (x86 for example)? I would like
> to know because we didn't get any compile errors.
> 

A minor one when compiled as modules

 ERROR: "FN_11_report" [drivers/input/touchscreen/rmi_core.ko] undefined!
 ERROR: "FN_11_config" [drivers/input/touchscreen/rmi_core.ko] undefined!
 ERROR: "FN_11_init" [drivers/input/touchscreen/rmi_core.ko] undefined!
 ERROR: "FN_11_detect" [drivers/input/touchscreen/rmi_core.ko] undefined!

but no issues when working built-in after some changes

 input: RMI4 Touchpad as /devices/virtual/input/input1
 rmi_register_phys_driver: rmi4_ts: Registering phys driver rmi4_i2c_ts
 omap_device: i2c_omap.2: new worst case activate latency 0: 61035
 rmi_register_phys_driver: rmi4_ts: could not find support for function 0x34
 rmi_register_phys_driver: rmi4_ts: could not find support for function 0x8
 probe: Found 301 data sources for : dfb56974
 match_and_bind: rmi4_ts is rmi4_touchpad bound to rmi4_i2c_ts
 config: could not find support for function 0x32
 config: could not find support for function 0xff
 config: could not find support for function 0xff

The link to my changes is below so I could have all layers registered without kernel panics, this is a diff between initial commit in input tree and initial commit + my changes in linux omap.

http://pastebin.com/54d7d3b0

I have not dig into details and fixes, I'll wait for your patch after review to make it my baseline.

Please let me know any other request, thanks for your help!

Best Regards
Abraham

