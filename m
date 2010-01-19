From: "Gunn, Brian" <bgunn@solekai.com>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Tue, 19 Jan 2010 12:47:54 -0800
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD101B5F8BA4@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 ,<1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9D@EXMBXSD.dm.solekai.com>,<1263920596.1816.56.camel@localhost.localdomain>,<FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9E@EXMBXSD.dm.solekai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.solekai.com ([72.34.65.115]:3837 "EHLO mail.solekai.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab0ASUvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 15:51:20 -0500
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9E@EXMBXSD.dm.solekai.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gunn, Brian" <bgunn@solekai.com>, Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>, Jiri Kosina <jikos@jikos.cz>

Brian Gunn wrote:

>I used a custom remote control under development by the company I'm contracted to.
>We have custom HID output reports that trigger actions on the remote.
>I was able to send the output reports and get the behavior I expected on the remote.
>I have no faith that the company developing the remote implemented their side
>correctly and would like to try it with the control socket instead.

BTW:  The Sony PS3 controller requires sending of HID reports as well.  I just checked the one implementation of this I've seen (input/device.c in the BlueZ source) and I see that it uses the control socket.

Once we get implementation of sending HID reports to the control socket implemented elsewhere, this kludge can be removed from the BlueZ source.

Brian
