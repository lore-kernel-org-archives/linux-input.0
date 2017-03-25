From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 0/2] Support additional Xbox One pads
Date: Sat, 25 Mar 2017 15:31:00 -0700
Message-ID: <20170325223102.21136-1-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33393 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCYWbY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 18:31:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

This series adds support for several new or quirky Xbox One pads.

Patch 1 of this series may be considered a v2 for patches 1-3 of my
previous series:

  https://lkml.org/lkml/2017/2/4/189

I'm now only sending the quirk packets to the specific gamepads that
need them, per Dmitry's feedback on the last series.

Patch 2 is a trivial new device ID addition that I've tagged for
stable. This one is not purely cosmetic because we won't currently
bind to any Xbox One pads with Razer's VID without it.


Cameron Gutman (2):
  Input: xpad - support some quirky Xbox One pads
  Input: xpad - add support for Razer Wildcat gamepad

 drivers/input/joystick/xpad.c | 116 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 13 deletions(-)

-- 
2.9.3

