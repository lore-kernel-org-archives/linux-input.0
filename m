From: "Bob Copeland" <me@bobcopeland.com>
Subject: 2.6.26-rc3 - appletouch resume "incomplete data package"
Date: Sun, 25 May 2008 16:24:13 -0400
Message-ID: <b6c5339f0805251324k70a3a56ci9cab5274acc2d01d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:43429 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbYEYUYN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 May 2008 16:24:13 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1976973rvb.1
        for <linux-input@vger.kernel.org>; Sun, 25 May 2008 13:24:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

This appears to be a regression since 2.6.25.  After resuming, I get:

    appletouch: incomplete data package (first byte: 2, length: 4).
    appletouch: incomplete data package (first byte: 2, length: 4).
    appletouch: incomplete data package (first byte: 2, length: 4).
    [...]

And the touchpad doesn't work.  This is on a first gen MacBook.  I
didn't see any changes to the driver itself in that timeframe.
Anyone have ideas, or should I try a bisect?

-- 
Bob Copeland %% www.bobcopeland.com
