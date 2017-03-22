From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] Docs: Input: initial uinput documentation
Date: Tue, 21 Mar 2017 23:58:16 -0300
Message-ID: <20170322025820.4108-1-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34673 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758621AbdCVC6x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 22:58:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: corbet@lwn.net, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, peter.hutterer@who-t.net
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Hi guys,

so, after taking some time to understand how to work with uinput, and to grab some examples
on web, I discovered that kernel doesn't have any "official" documentation about it.

So, here we are :)

I added some examples based in my tests, there are samples of EV_REL and EV_KEY, but
we can add more in the future to cover other cases.

Notes:
* I created the doc in rst format, following the trend to adapt all documentation using the
  new format (although input subsystem still have some work to do...)
* This documentation was converted to HTML, and it can be checked here:
  https://marcosps.github.io/
* Let me know if you find anything that can make the documentation more clear, or
  anything that can make the code better

Marcos Paulo de Souza (1):
  Documentation: Input: Add uinput documentation

 Documentation/input/uinput.rst | 158 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/input/uinput.rst

-- 
2.9.3

