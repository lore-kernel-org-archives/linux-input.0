From: Douglas Christman <douglaschristman@gmail.com>
Subject: ALPS DualPoint double click bug
Date: Sun, 19 Jul 2015 09:29:26 -0400
Message-ID: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36746 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbbGSN31 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Jul 2015 09:29:27 -0400
Received: by iehx8 with SMTP id x8so22639147ieh.3
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2015 06:29:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello all,

Kernel v4.1 introduces a bug for my laptop's (Toshiba Tecra A10)
touchpad.  Clicking twice only registers as a single click (and three
clicks are needed to double-click).

The touchpad shows up as 'AlpsPS/2 ALPS DualPoint' in dmesg.
Bisecting drivers/input/mouse suggests that commit 92bac83d introduced
the bug.

Please let me know if I can provide any other information that would be useful.

Filed as bug #101701 on bugzilla.

Thank you,
Doug
