From: George Pantalos <gpantalos@gmail.com>
Subject: ALPS v4 Semi-mt Support
Date: Tue, 10 Apr 2012 17:01:31 +0300
Message-ID: <1824214.pvvijqYDYe@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56663 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2DJN7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 09:59:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so4240566bkc.19
        for <linux-input@vger.kernel.org>; Tue, 10 Apr 2012 06:59:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I have created a crude patch to add Semi-MT support for v4 ALPS touchpads 
based on the work by Seth Forshee. [1]

This patch works ok for Single-Touch Events however the Left Half side of the 
touchpad is far less accurate than the Right Half for Semi-mt events 
(synclient -m 10 shows f alternating constantly between 1 and 2 fingers with 
two fingers touching it and one finger touch erroneously reports as 2 finger 
touch sometimes.)

I hope this is useful and maybe it could be improved and approved :)

Sorry for the code quality, I am not a programmer.

[1]  http://people.canonical.com/~sforshee/alps-touchpad/psmouse-
alps-0.10/
