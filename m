From: Melchior FRANZ <mfranz@aon.at>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Mon, 21 Dec 2009 01:22:01 +0100
Message-ID: <200912210122.01504@rk-nord.at>
References: <4B26B824.8010403@physik.uni-muenchen.de> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:34890 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753677AbZLUA2r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Dec 2009 19:28:47 -0500
Received: from unknown (HELO email.aon.at) ([172.18.1.197])
          (envelope-sender <mfranz@aon.at>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 21 Dec 2009 00:22:06 -0000
Received: from 188-23-90-143.adsl.highway.telekom.at (HELO server.lan) ([188.23.90.143])
          (envelope-sender <mfranz@aon.at>)
          by smarthub98.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 21 Dec 2009 00:21:59 -0000
Received: from server.localnet (localhost [127.0.0.1])
	by server.lan (Postfix) with ESMTP id 3F17517EAE0
	for <linux-input@vger.kernel.org>; Mon, 21 Dec 2009 01:22:02 +0100 (CET)
In-Reply-To: <4B2D6377.1020703@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

* Johannes Ebke -- Sunday 20 December 2009:
> It seems that the force feedback works well, I have ported the force
> feedback for my favorite game to linux now, and it works well.

How do you handle joystick calibration? Or does your js not need that?
Mine does, and it looks like I can either have a working (= calibrated)
js (/dev/input/js?), *or* ff (/dev/input/event?), which is rather
unfortunate.

m.
