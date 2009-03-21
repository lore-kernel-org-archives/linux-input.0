From: Richie Ward <richies@gmail.com>
Subject: G25 and Saitek Evo Force
Date: Sat, 21 Mar 2009 01:36:59 +0000
Message-ID: <6b33c0ac0903201836qb6dc872pdadb56679bce0b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:58979 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbZCUBhD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 21:37:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so489320fkq.5
        for <linux-input@vger.kernel.org>; Fri, 20 Mar 2009 18:37:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, I have 2.6.28 with jaunty beta and I have managed to get my
g25's force feedback working in compatibility mode (Bus 003 Device
007: ID 046d:c294 Logitech, Inc. Driving Force) but when in native
mode, it does not work (Bus 003 Device 010: ID 046d:c299 Logitech,
Inc.).

Since it just says Logitech, Inc, does this mean support is missing in kernel?

Also I cannot seem to get force feedback working with my Saitek Evo
Force (Bus 004 Device 002: ID 06a3:ffb5 Saitek PLC Cyborg Evo Force
Joystick), it does not respond at all.

I am using input-utils from svn co
https://linuxconsole.svn.sourceforge.net/svnroot/linuxconsole/trunk/utils
input-utils

Furthermore, ffmvforce is the only tool that can make my g25's force
feedback work.

-- 
Thanks, Richie Ward
