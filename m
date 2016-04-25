From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Cypress APA cursor jumps (fdo bug #94910)
Date: Mon, 25 Apr 2016 09:33:43 +0200
Message-ID: <CAN+gG=GeBP=tb6S3N1zPxaUwbO=wtEBufnSJ42NXe9e4qmre6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36421 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbcDYHdo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 03:33:44 -0400
Received: by mail-yw0-f174.google.com with SMTP id o66so193274763ywc.3
        for <linux-input@vger.kernel.org>; Mon, 25 Apr 2016 00:33:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Dudley,

[Also including the Chromium team, as this is related to a Chromebook].

A user reported that his HP Chromebook 14 (Falco) experiences some
cursor jumps with the integrated cyapa touchpad[1].

>From what we can gather, there is a jump from the cursor when the user
tries to click on the clickpad (see the bug for an evemu recording).
Is it something known? and is there some work around we could use?

The ultimate solution will be to activate the in-kernel tracking, but
these events seem to be just wrong, and the kernel tracking might
corrupt even more the data stream.

Any help would be appreciated :)

Cheers,
Benjamin

[1] https://bugs.freedesktop.org/show_bug.cgi?id=94910
