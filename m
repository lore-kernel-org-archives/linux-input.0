From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Mon, 21 Dec 2009 01:24:19 +0100
Message-ID: <200912210124.19544@rk-nord.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:31188 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756205AbZLUAbB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Dec 2009 19:31:01 -0500
Received: from unknown (HELO email.aon.at) ([172.18.1.196])
          (envelope-sender <melchior.franz@gmail.com>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 21 Dec 2009 00:24:19 -0000
Received: from 188-23-90-143.adsl.highway.telekom.at (HELO server.lan) ([188.23.90.143])
          (envelope-sender <melchior.franz@gmail.com>)
          by smarthub97.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 21 Dec 2009 00:24:17 -0000
Received: from server.localnet (localhost [127.0.0.1])
	by server.lan (Postfix) with ESMTP id C4E4083BF6
	for <linux-input@vger.kernel.org>; Mon, 21 Dec 2009 01:24:19 +0100 (CET)
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



(resending with subscribed email address, sorry)
