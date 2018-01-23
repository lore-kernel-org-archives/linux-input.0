From: "Devin J. Pohly" <djpohly@gmail.com>
Subject: New input driver for PIUIO input/output board
Date: Tue, 23 Jan 2018 13:20:28 -0600
Message-ID: <20180123192029.9468-1-djpohly@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:43669 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeAWTTz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 14:19:55 -0500
Received: by mail-it0-f44.google.com with SMTP id u62so2285281ita.2
        for <linux-input@vger.kernel.org>; Tue, 23 Jan 2018 11:19:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi all,

I've written an input driver for a custom I/O board often found in
arcade dance machines.  I have maintained it out-of-tree on my GitHub
(https://github.com/djpohly/piuio) for a number of years, and it has
been running on a handful of "production" systems for just as long.

This is my first major submission to the kernel, so I would welcome any
comments or criticisms that people may have.

Thanks!
*dp

