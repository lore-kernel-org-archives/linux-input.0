From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: 3.5.1 hid_generic causes mouse locking until a button is clicked
Date: Sat, 11 Aug 2012 16:55:57 -0300
Message-ID: <k06dcc$u9q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48758 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab2HKUAH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Aug 2012 16:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1T0Hqv-00018Z-4z
	for linux-input@vger.kernel.org; Sat, 11 Aug 2012 22:00:05 +0200
Received: from 187.37.50.86 ([187.37.50.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 11 Aug 2012 22:00:05 +0200
Received: from fragabr by 187.37.50.86 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 11 Aug 2012 22:00:05 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

	I upgraded from 3.4.4 to 3.5.1 kernel and now I see the new
hid_generic module is causing problem with my mouse (a regular Logitech
USB optical mouse).

	The problem is: after 2 seconds without moving the mouse, the
pointer will NOT move again UNLESS I click a mouse button.

	So now I have to click a button everytime I want to "unlock"
the mouse pointer. It didn't happen with 3.4.4 so it's clearly a
regression.

Any hints? I can try patches. Thanks.

-- 
http://www.youtube.com/DanielFragaBR


