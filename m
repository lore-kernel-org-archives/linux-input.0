From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Disable PS/2 mode of XPS 13 2015 touchpad
Date: Mon, 11 May 2015 16:21:28 -0500
Message-ID: <55511D58.4020309@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:37936 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbEKVVl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2015 17:21:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

As I previously mentioned, the synaptics touchpad in the XPS 13 (2015) supports both I2C and PS2 modes.  It's very stable and well featured in I2C mode.  Some users have reported that if the psmouse driver is built into the kernel rather than a module it causes the touchpad to not enter I2C mode.  This appears to be due to a timeout in the firmware that it won't toggle modes if it doesn't see any I2C data in a certain amount of time.

I checked with Synaptics and they said that the PNP ID for this trackpad (DLL0665) is only used in projects with this trackpad or one very similar.  It is safe to blacklist PS2 support if we only want I2C when this trackpad is shown.

I tried to prevent psmouse from loading the synaptics protocol when the PNP ID of the touchpad was found, but I realized that this still isn't correct and doesn't fix the problem.  Instead I think it's appropriate to block the serio driver from initializing the PS2 aux port when this ID is found.  I wanted to see if you guys agreed this is the proper place.  I was thinking in i8042-x86ia64io.h where the PNP ID's for the mouse are detected.

Thanks,
