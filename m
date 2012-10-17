From: Ming Lei <ming.lei@canonical.com>
Subject: [BUG] capslock works across all keyboards but LED does not
Date: Wed, 17 Oct 2012 20:44:12 +0800
Message-ID: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50752 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab2JQMoO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Oct 2012 08:44:14 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1TOSyq-0006yF-Gj
	for linux-input@vger.kernel.org; Wed, 17 Oct 2012 12:44:12 +0000
Received: by mail-ee0-f46.google.com with SMTP id b15so4004592eek.19
        for <linux-input@vger.kernel.org>; Wed, 17 Oct 2012 05:44:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

There is one report on the below problem:[1]

        - connect one usb keyboard into laptop
        - press capslock on internal ps/2 keyboard
        - input from both two keyboards  becomes upper case state
        - but only capslock led is on in ps/2 keyboard and not on in
usb keyboard

or
        - connect one usb keyboard into laptop
        - press capslock on usb keyboard
        - input from both two keyboards  becomes upper case state
        - but only capslock led is on in usb keyboard and not on in
internal ps/2 keyboard

No such problem on windows, and capslock input is always consistent with the led
state on both keyboards.

I can reproduce the above problem 100% on my T410 laptop.

[1], https://bugs.launchpad.net/ubuntu/+source/linux/+bug/830063

Thanks,
--
Ming Lei
