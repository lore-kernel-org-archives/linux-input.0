From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 0/4] Input: use parallel port device model
Date: Tue, 29 Sep 2015 22:06:30 +0530
Message-ID: <1443544594-5800-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36359 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934840AbbI2Qgs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 12:36:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi,
This series will convert the other remaining drivers to use parallel
port device model. Changes are similar to the changes done in db9.c

regards
sudip

Sudip Mukherjee (4):
  Input: gamecon - use parallel port device model
  Input: turbografx - use parallel port device model
  Input: serio - use parallel port device model
  Input: walkera0701 - use parallel port device model

 drivers/input/joystick/gamecon.c     | 100 +++++++++++++++++++----------------
 drivers/input/joystick/turbografx.c  | 100 ++++++++++++++++++-----------------
 drivers/input/joystick/walkera0701.c |  64 ++++++++++++----------
 drivers/input/serio/parkbd.c         |  55 ++++++++++++-------
 4 files changed, 178 insertions(+), 141 deletions(-)

-- 
1.9.1

