From: Mikael Pettersson <mikpelinux@gmail.com>
Subject: keyboard problems on Dell Latitude E6230
Date: Thu, 6 Feb 2014 10:13:57 +0100
Message-ID: <21235.21077.175269.903168@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:63640 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbaBFJOC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 04:14:02 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I'm having problems with the built-in keyboard on Dell Latitude E6230
laptops and Linux 3.12/3.13 kernels:

- sometimes the keyboard just keeps sending the same key code, as if
  the key was held down permanently; sometimes that can be cured by
  pressing ^C or something, but often only a reboot fixes it

- sometimes the keyboard just stops sending key codes; only a reboot
  fixes it

This issue has plagued me since Nov last year when I got my first E6230.
Last week I got a replacement machine, but it too has the same problems.

Since I haven't seen this problem with any other laptop under Linux for
the last 15 years or so, I have to conclude that there's some HW issue
with these machines that the Linux kernel doesn't handle.

Any ideas?
