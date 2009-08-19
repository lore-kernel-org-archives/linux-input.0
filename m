From: Bogdan Puscas <rftghost@gmail.com>
Subject: Design problem around fixup driver for Saitek Cyborg Mouse
Date: Wed, 19 Aug 2009 18:14:37 +0300
Message-ID: <dc9421000908190814w5adafae9x8a13a3ca7a17c923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43973 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbZHSPOi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2009 11:14:38 -0400
Received: by ewy3 with SMTP id 3so2180042ewy.18
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2009 08:14:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm working to create a fixup driver for the Saitek Cyborg Mouse
(http://www.saitek.com/UK/prod/cyborgmouse.htm) device.
So far I'm almost done with it, but I have a problem with the
"trademark" feature of the Cyborg line... the 3 mode switch.

I hardcoded the keys/buttons as follows:
a. For all the modes, the buttons 1,2,3, the wheel axis and the X/Y
axis are defaults
b. The buttons 4,5,6 and the D-Pad (another 4 buttons) have this mapping:

static unsigned red_code[]= {BTN_0, BTN_1, BTN_2, BTN_3, BTN_4, BTN_5, BTN_6};
static unsigned green_code[] = {BTN_BACK, BTN_FORWARD, BTN_SIDE,
BTN_0, BTN_1, BTN_2, BTN_3};
static unsigned yellow_code[] = {BTN_BACK, BTN_FORWARD, BTN_SIDE,
KEY_UP, KEY_RIGHT, KEY_DOWN, KEY_LEFT};

My problem is how to expose these to the user. What is the
common/linux/whatever standard way to do this? IOCTL? sysfs?

I'm also working to get the Cyborg Command Unit
(http://www.saitek.com/UK/prod/cyborgcommand.htm) and the X52 Joystick
(http://www.saitek.com/UK/prod/x52.htm) working with modal switch.

Thanks,
Bogdan.
