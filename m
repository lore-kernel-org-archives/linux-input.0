From: fcooper@ti.com
Subject: [RFC 0/4] Input: edt-ft5506 - Adding support for FT5506
Date: Wed,  7 Oct 2015 07:21:37 -0500
Message-ID: <1444220501-23623-1-git-send-email-fcooper@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:32974 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbJGMWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 08:22:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, fcooper@ti.com, maxime.ripard@free-electrons.com, LW@KARO-electronics.de, jg1.han@samsung.com, asaf.vertz@tandemg.com

From: Franklin S Cooper Jr <fcooper@ti.com>

This series adds support for the FT5506 tsc. The biggest difference
between this tsc vs the ones currently supported by the driver is the
ability to handle upto 10 touch points.

The FT5506 tsc that I currently have seems to be based on the M09
firmware which I have documentation for. However, I haven't been able
to find documentation for the tsc that use the M06 firmware. Therefore,
the calculation I made to determine the amount of data to read for the M06
is at best an educated guess.

If anyone has the doc for the old firmware please send it to me if
possible or double check the code I use to determine the amount of bytes
to read.

Also I had to work around a weird bug that I'm only seeing on the FT5506.
I tested this patch set on another board (AM437x SK) that uses the FT5306
and didn't see any problems.

This patchset is built on top of linux-input master

Franklin S Cooper Jr (4):
  Input: edt-ft5x06 - Use max support points to determine how much to
    read
  Input: edt-ft5x06 - Add support for different max support points
  Input: edt-ft5x06 - Add support for FT5506
  Input: edt-ft5x06 - Work around FT5506 firmware bug

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  2 +
 drivers/input/touchscreen/edt-ft5x06.c             | 69 ++++++++++++++++++----
 2 files changed, 59 insertions(+), 12 deletions(-)

-- 
2.6.1

