From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 0/4] Input: xpad: extend device support
Date: Fri, 27 May 2016 02:16:08 +0200
Message-ID: <CA+b0ujdfg82DcWkmTqtjwUTLZgQC5NjOks3ssWrMjv95fguiPQ@mail.gmail.com>
References: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33665 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbcE0AQ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 20:16:28 -0400
Received: by mail-yw0-f172.google.com with SMTP id h19so92233230ywc.0
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 17:16:28 -0700 (PDT)
In-Reply-To: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

sorry, I messed up the cover letter. this is the correct one:

to be applied on the for-linus branch.

Patch 1 corrects a bug that caused packets to be dropped if they were sent
immediately one after the other.

Patch 2 filters spurious packets similar to the x360w path.

Patch 3 adds more third party controller ids

Patch 4 adds support for the elite controller

Patches 5-7 contain some minor code cleanup and can be applied to taste.

Cameron Gutman (1):
  Input: xpad: prevent spurious input from wired Xbox 360 controllers

Daniel Tobias (2):
  Input: xpad: correctly sort vendor id's
  Input: xpad: move reporting xbox one home button to common function

Pavel Rojtberg (4):
  Input: xpad: move pending clear to the correct location
  Input: xpad: add more third-party controllers
  Input: xpad: xbox one elite controller support
  Input: xpad: simplify error condition in init_output

 drivers/input/joystick/xpad.c | 90
++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

-- 
2.7.4
