From: Dharam Kumar <dharam.kumar.gupta@gmail.com>
Subject: Missing Key-codes from <linux/input.h> file
Date: Mon, 25 Jun 2012 19:39:25 +0530
Message-ID: <CAOt5+pRZ=qqEZ2Ra3yFbLqoHhDGFkzHs4cEXvFv5trbukd4MdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50883 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070Ab2FYOJr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 10:09:47 -0400
Received: by lbbgm6 with SMTP id gm6so6552654lbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 07:09:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi,
I'm working on a module which is an input device and hence it needs to
report certain key events.

While browsing through the <linux/input.h>, I did find most of the
key-codes(which I need to use) already defined but not all.

Few of the KEY_xxx which i could not find are:

a.) A Key for going to the previous channel.
b.) Keys for Moving upper-right, lower-right, upper-left and
lower-left direction(probably a GUI(or a grid of icons),where you move
diagonally)
d.) A key for Subpicture (this 'subpicture' key is defined in CEA-931C).

Any pointers?

Thanks,
Dharam
