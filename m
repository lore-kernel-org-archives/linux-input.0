From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: cleanup of hiddev
Date: Tue, 04 Nov 2008 16:33:49 +0100
Message-ID: <49106B5D.5020701@gmail.com>
References: <200811031731.38055.oliver@neukum.org> <200811041317.40482.oliver@neukum.org> <4910681D.6020701@gmail.com> <200811041629.39945.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:39296 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYKDPeC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 10:34:02 -0500
In-Reply-To: <200811041629.39945.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Oliver Neukum napsal(a):
> Yes, I see. However, the device must not be registered before the table
> is correctly filled and the minor must be filled out before. A mutex then?

It's enough to assign the hiddev_table after the register, isn't it?
Actually, it's how it's done now... BTW what was the reason to move with that?
