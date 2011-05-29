From: Alberto Mardegan <mardy@users.sourceforge.net>
Subject: Reporting screen/laptop orientation data to userspace
Date: Sun, 29 May 2011 10:49:19 +0300
Message-ID: <4DE1FA7F.3050308@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50842 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab1E2HtZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 May 2011 03:49:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

Hi all,
  the WMI interfaces in some Lenovo Ideapad laptops provide notification
callbacks when the laptop orientation changes, reporting 4 different
values defining the new orientation.

I'd like to extend the ideapad-laptop driver with this information; but
how should it be reported to userspace? I initially thought of the input
subsystem, but I cannot find any suitable event codes; then I would
probably export it as a device under /sys, or are there better options?

Are there other devices which provide coarse orientation data to
userspace, which I might want to use as a reference?
I guess that at least some display screens have this feature.

TIA,
  Alberto

-- 
http://blog.mardy.it <- geek in un lingua international!
