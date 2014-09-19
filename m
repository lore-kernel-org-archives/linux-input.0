From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 0/2 v2]  Add OF match tables for the ChromeOs EC subdevices
Date: Fri, 19 Sep 2014 10:08:11 +0200
Message-ID: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:41409 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaISIJ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2014 04:09:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

[ This is essentially a resend, adding Javiers reviewed-by and fixing some small
identation issues in the second patch. Also added Wolfgang and Dimitry in the
to, as i missed them last time ]

The ChromeOS EC MFD driver registers its sub-devices with both a (platform)
name and an OF compatibility string. As a result of this the modalias passed on
to user-space will be based on the OF compatibility string. Thus to be able to
rely on autoloading in case the subdevices are build as modules they need to
export the necessary module aliases based to match the of information.

The two patches in these series add the requird of match information to the EC
subdevices

I guess the first patch should through the i2c tree while the second one would
be for the input tree?

Sjoerd Simons (2):
  i2c: cros-ec-tunnel: Add of match table
  input: cros_ec_keyb: Add of match table

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 9 +++++++++
 drivers/input/keyboard/cros_ec_keyb.c   | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.1.0

