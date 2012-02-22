From: Jiri Slaby <jslaby@suse.cz>
Subject: Lost ps/2 input in 3.2.5 (aka PCI: Rework ASPM disable code)
Date: Wed, 22 Feb 2012 20:24:22 +0100
Message-ID: <4F4540E6.2020708@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2BVTY1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 14:24:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stable <stable@kernel.org>
Cc: mjg@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, "jirisl >> Jiri Slaby" <jirislaby@gmail.com>

Hi,

so I finally decided to commit 3.2.5 into the opensuse kernel. However
it does not even work on my laptop.

Both keyboard and touchpad are not detected. They are connected via PS/2.

I see
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please
boot with i8042.nopnp

Without that patch this warning is gone and devices properly enumerated.

thanks,
-- 
js
suse labs
