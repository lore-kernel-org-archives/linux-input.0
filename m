From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.1-rc6
Date: Fri, 5 Jun 2015 17:04:49 -0700
Message-ID: <20150606000449.GA6397@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33588 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbbFFAEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 20:04:54 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a couple touchpad
drivers fixups.

Changelog:
---------

Hans de Goede (2):
      Input: elantech - fix detection of touchpads where the revision m=
atches a known rate
      Input: alps - do not reduce trackpoint speed by half

=E6=B4=AA=E4=B8=80=E7=AB=B9 (1):
      Input: elantech - add new icbody type


Diffstat:
--------

 drivers/input/mouse/alps.c     | 5 ++---
 drivers/input/mouse/elantech.c | 8 +++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
