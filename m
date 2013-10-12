From: Bastien Nocera <hadess@hadess.net>
Subject: Problem with Mighty Mouse
Date: Sun, 13 Oct 2013 01:48:46 +0200
Message-ID: <1381621726.21761.7.camel@nuvo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49750 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab3JLXxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Oct 2013 19:53:34 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 6057353510E
	for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 01:49:12 +0200 (CEST)
Received: from mfilter20-d.gandi.net (mfilter20-d.gandi.net [217.70.178.148])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 7C30241C04B
	for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 01:48:49 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter20-d.gandi.net (mfilter20-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id d17zcYWkgG9v for <linux-input@vger.kernel.org>;
	Sun, 13 Oct 2013 01:48:47 +0200 (CEST)
Received: from [192.168.0.14] (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A08D541C051
	for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 01:48:47 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heya,

I've tested a Bluetooth Apple Mighty Mouse (AA1197) and though I can
move the cursor without a problem, none of the buttons work. evtest
doesn't see any button events.

Any ideas what I should look at, or which tool I could use to capture
the raw data?

Cheers

