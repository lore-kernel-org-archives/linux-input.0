From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/03] input: mode 6 patches for sh_keysc
Date: Mon, 08 Feb 2010 15:32:16 +0900
Message-ID: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:44357 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0BHGi5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 01:38:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

input: mode 6 patches for sh_keysc

[PATCH 01/03] input: break out hw access functions in sh_keysc 
[PATCH 02/03] input: bitmap update for sh_keysc
[PATCH 03/03] input: update sh_keysc driver with mode 6

These patches improve the sh_keysc driver with mode 6 support.

The earlier submitted patch for mode 4 and mode 5 extended the
driver with up to 6 * 7 keys. Mode 6 support included in this
patch set allows up to 7 * 7 keys.

The sh_keysc driver has so far only been used with hardware
where the number of keys can fit in a 32-bit bitmap, but from
mode 4 and up these 32 bits are no longer enough. To address
this proper bitmaps are made use of instead 32-bit integers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |  155 ++++++++++++++++++++++++-------------
 include/linux/input/sh_keysc.h    |    6 -
 2 files changed, 106 insertions(+), 55 deletions(-)
