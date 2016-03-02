From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] Input: byd - enable absolute mode
Date: Tue,  1 Mar 2016 21:27:29 -0800
Message-ID: <1456896450-29653-1-git-send-email-pospeselr@gmail.com>
References: <20160302005549.GA17074@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35841 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcCBF2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 00:28:18 -0500
Received: by mail-pf0-f180.google.com with SMTP id l6so29531281pfl.3
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 21:28:18 -0800 (PST)
In-Reply-To: <20160302005549.GA17074@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: chris@diamand.org, linux-input@vger.kernel.org, Richard Pospesel <pospeselr@gmail.com>


Removed and replaced jiffie logic per Dmitry's suggestion in offline
conversation.  Got rid of the 'now' variable entirely and instead
use jiffies directly instead of caching.

Verified updated patch works as intended on device.

---

The Windows driver's settings dialog contains a visualization of the
regions for the hardware edge scrolling capability, which uses a
temporarily-enabled limited-resolution absolute mode.

This patch enables this during normal operation, and combines the
absolute packets with the existing relative packets to provide
accurate absolute position and touch reporting.

It also adds documentation for all known gesture packets and
initialization commands.

Reviewed-by: Chris Diamand <chris@diamand.org>
Signed-off-by: Richard Pospesel <pospeselr@gmail.com>
