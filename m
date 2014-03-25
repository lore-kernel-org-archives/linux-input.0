From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Regression: mouse pointer stuck in KDE with kernel 3.13 and above
Date: Mon, 24 Mar 2014 23:28:50 -0300
Message-ID: <lgqpkj$ie$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39950 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbaCYC3A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2014 22:29:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1WSH6p-00080g-FS
	for linux-input@vger.kernel.org; Tue, 25 Mar 2014 03:28:59 +0100
Received: from 177.189.67.147 ([177.189.67.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 25 Mar 2014 03:28:59 +0100
Received: from fragabr by 177.189.67.147 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 25 Mar 2014 03:28:59 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

	I'd like some help to debug this regression. After upgrading
from kernel 3.12 to 3.13, my mouse gets stuck after entering in KDE (at
console with gpm everything is fine).

	Bisect is worthless in this case, because this bug doesn't
trigger everytime. USB is not the problem, since usbmon trace shows
activity even with the mouse pointer stuck.

	What can I do do debug this? Any hints?

	Thanks.

-- 
Linux 3.12.14: Shuffling Zombie Juror
http://www.youtube.com/DanielFragaBR
http://mcxnow.com?r=danielfragabr
Bitcoin: 12H6661yoLDUZaYPdah6urZS5WiXwTAUgL


