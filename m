From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 2.6.38.7 0/3] xpad: wireless controller fixes
Date: Sun, 12 Jun 2011 17:12:59 -0700
Message-ID: <1307923980.8254.5.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50383 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab1FMANB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 20:13:01 -0400
Received: by pwi15 with SMTP id 15so1890258pwi.19
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 17:13:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This set of patches implement rumble support for XBox360 Wireless
Controllers, and also fixes LED setup and implements a set of LED
commands for the same controllers.

