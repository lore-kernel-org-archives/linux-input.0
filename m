From: Arnd Bergmann <arnd@arndb.de>
Subject: Input: two merge window build fixes
Date: Thu, 19 May 2016 15:52:23 +0200
Message-ID: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60218 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbcESNwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 09:52:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

I ran into two new build regressions in the input subsystem with
today's linux-next, maybe you can apply these fixes before sending
off the pull request for v4.7.

	Arnd

[PATCH 1/2] Input: atmel captouch depends on i2c
[PATCH 2/2] Input: migor-ts: mark PM functions as __maybe_unused
