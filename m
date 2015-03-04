From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/2] Replace KEY_DIRECTION with KEY_ROTATE_DISPLAY
Date: Thu, 5 Mar 2015 00:31:08 +0100
Message-ID: <50f35802-77cf-4caf-bfa6-cf3b1dfd21f7@HUB2.rwth-ad.de>
References: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:56994 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbCDXbV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 18:31:21 -0500
In-Reply-To: <9963784C-E91D-4222-999F-10D04C0FB4E0@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>

The description was requested 5 years ago: https://lkml.org/lkml/2010/2=
/27/36
See also http://comments.gmane.org/gmane.linux.kernel.input/11175

Stefan Br=C3=BCns (2):
  Add alias KEY_ROTATE_DISPLAY for KEY_DIRECTION, add description
  use more descriptive KEY_ROTATE_DISPLAY instead of KEY_DIRECTION

 drivers/hid/hid-debug.c               | 2 +-
 drivers/platform/x86/fujitsu-tablet.c | 6 +++---
 drivers/platform/x86/hp-wmi.c         | 2 +-
 include/uapi/linux/input.h            | 3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
