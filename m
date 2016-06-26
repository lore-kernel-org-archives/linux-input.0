From: Richard Pospesel <pospeselr@gmail.com>
Subject: Input: byd - fix issue where generic PS/2 mice are detected as BYD touchpad
Date: Sat, 25 Jun 2016 19:25:20 -0700
Message-ID: <1466907921-10210-1-git-send-email-pospeselr@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34844 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbcFZCZr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 22:25:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id c2so50688010pfa.2
        for <linux-input@vger.kernel.org>; Sat, 25 Jun 2016 19:25:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: chris@diamand.org, dmitry.torokhov@gmail.com, phonesyfreakies@gmail.com


The secret handshake used was not sufficient to determine whether the connected
device was actually a BYD touchpad.  Added some restrictions on what the first
byte returned may be (based off of experiments with BYD touchapd) and added a
subsequent call to byd_reset which attemtps to configure the BYD touchpad using
BYD-specific commands.  Fixes bug 1201781.  Tested on laptop with BYD touchpad
hardware.

Applied against commit fcd6eb50eadd83f857eac55f99316f1789707cdb

Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
