From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHv3 0/3] Sixaxis plugin for Bluez
Date: Wed,  8 Jun 2011 15:09:14 +0200
Message-ID: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41427 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab1FHNJm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jun 2011 09:09:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

Hi,

it is still not perfect but I don't want to hold this for too long, the 
remaining details can be fixed later.

Patches 1/3 and 2/3 are unchanged. 

Changes since v2 for patch 3/3:

  - Rebased on latest bluez from git.

  - Write the trust file earlier: if we write the trust file before 
    calling adapter_get_device() manual authorization is not asked to 
    the user anymore on the very first connection.

  - Move call to btd_device_add_uuid() inside 
    create_sixaxis_association(): there is no need for a 'struct 
    btd_device *device' variable to be out of that function.

  - Do not use newlines in DBG() calls.

  - Consider also "Sony Computer Entertainment Wireless Controller" when 
    detecting the Sixaxis, I get this identifier sometimes.

  - Add fallback ioctl definition to allow compilation with older kernel 
    headers, I tried running the plugin on older kernels too and it 
    fails gracefully. The configure-time check is now removed, we just check 
    udev to be enabled.

  - Print file and function in error() messages, maybe this can be done 
    globally, but for now I added it locally to know where the failures 
    where happening. 

  - Fix a mem leak in get_feature_report(): free(buf) in the error path.

  - Make set_master_bdaddr() return the int error value instead of a 
    boolean.

  - Don't print the "New Master Bluetooth address" message when we fail 
    to set it.


TODO:

  - When the controller is connected via USB the led is set, but then it 
    goes blinking again waiting for the PS button to be pressed, maybe 
    we should wait for the PS button before setting leds, maybe with a 
    simple blocking read() on the hidraw device.

  - When the controller is connected via USB after it is working over 
    BT, it is seen as a second controller and the second led it turned 
    on, should we force BT disconnection on USB connection?

  - Test with multiple controllers, and/or multiple BT adapters, which I 
    can't do right now.

A remainder, if anyone wants to take a look at USB dumps of pairing and 
led setting, they are here: http://ps3.jim.sh/sixaxis/dumps/
Maybe the gyro initialization is there too.

Thanks,
   Antonio

Antonio Ospite (2):
  Remove input/sixpair.c
  Add sixaxis plugin: USB pairing and LEDs settings

Bastien Nocera (1):
  Re-add manager_get_default_adapter()

 Makefile.am       |    9 +-
 acinclude.m4      |   10 +
 input/sixpair.c   |  299 ------------------------------
 plugins/sixaxis.c |  528 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/manager.c     |    5 +
 src/manager.h     |    1 +
 6 files changed, 551 insertions(+), 301 deletions(-)
 delete mode 100644 input/sixpair.c
 create mode 100644 plugins/sixaxis.c

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
