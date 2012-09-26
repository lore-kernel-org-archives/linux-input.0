From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: uinput and unit tests
Date: Wed, 26 Sep 2012 12:42:21 +0200
Message-ID: <CAH9NwWeFjLuwbN82eVqti6fPBJUh3KhfVtJYbWbKt5vNMGEvrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45638 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2IZKmn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Sep 2012 06:42:43 -0400
Received: by lbon3 with SMTP id n3so1459693lbo.19
        for <linux-input@vger.kernel.org>; Wed, 26 Sep 2012 03:42:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all.

I have here a custom matrix keyboard where the kernel driver simply
reports cell and row
of pressed key. The whole logic and key mapping is done in user space.

Does anybody knows an existing tool or framework to run unit tests? In
the end I would like
to simulate key presses and test the logic part.

thanks
---
Christian Gmeiner, MSc
