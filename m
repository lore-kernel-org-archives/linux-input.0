From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 0/2] input: rotary-encoder: add support for half-period encoders
Date: Tue,  5 Apr 2011 20:15:11 +0200
Message-ID: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50965 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716Ab1DESPr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:15:47 -0400
Received: by ewy4 with SMTP id 4so203813ewy.19
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:15:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Hi, 

These patches add support for rotary-encoders which have two stable states per
input signal period.

The first patch refactors state retrieval and event reporting and the second
adds support for such half-period encoders.

Thanks,
Johan


Johan Hovold (2):
  input: rotary-encoder: refactor and clean up
  input: rotary-encoder: add support for half-period encoders

 Documentation/input/rotary-encoder.txt |   13 ++++
 drivers/input/misc/rotary_encoder.c    |  124 ++++++++++++++++++++++----------
 include/linux/rotary_encoder.h         |    1 +
 3 files changed, 101 insertions(+), 37 deletions(-)

-- 
1.7.4.1

