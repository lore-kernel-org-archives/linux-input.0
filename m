From: Tom Gundersen <teg@jklm.no>
Subject: WPC8769L (WEC1020) support in winbond-cir?
Date: Mon, 14 Oct 2013 15:16:20 +0200
Message-ID: <CAG-2HqX-TO7h8zJ6F01r2LfRVjQtb0pK_1wKGsYVKzB0zC7TQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:56848 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab3JNNQl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Oct 2013 09:16:41 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so2691393bkb.29
        for <linux-input@vger.kernel.org>; Mon, 14 Oct 2013 06:16:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Juan J. Garcia de Soria" <skandalfo@gmail.com>, =?UTF-8?Q?David_H=C3=A4rdeman?= <david@hardeman.nu>
Cc: Sean Young <sean@mess.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi David and Juan,

I'm going through the various out-of-tree LIRC drivers to see if we
can stop shipping them in Arch Linux [0]. So far it appears we can
drop all except for lirc_wpc8769l [1] (PnP id WEC1020).

I noticed the comment in windownd-cir [2]:

 *  Currently supports the Winbond WPCD376i chip (PNP id WEC1022), but
 *  could probably support others (Winbond WEC102X, NatSemi, etc)
 *  with minor modifications.

What are your thoughts on adding support for WEC1020 upstream? Is
anyone interested in doing this work (I sadly don't have the correct
device, so can't really do it myself)?

Cheers,

Tom

[0]: <https://mailman.archlinux.org/pipermail/arch-dev-public/2013-October/025541.html>
[1]: <http://sourceforge.net/p/lirc/git/ci/master/tree/drivers/lirc_wpc8769l/>
[2]: <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/media/rc/winbond-cir.c#n5>
