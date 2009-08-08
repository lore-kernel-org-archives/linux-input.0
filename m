From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Fri, 7 Aug 2009 22:23:21 -0300
Message-ID: <200908072223.21450.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LNX.2.00.0908080237090.25797@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JONfK3MJ7DVMYY8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:52058 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbZHHBXd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 21:23:33 -0400
Received: by gxk9 with SMTP id 9so2622745gxk.13
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 18:23:34 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908080237090.25797@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

--Boundary-00=_JONfK3MJ7DVMYY8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> Hi,
>
> we'd need to know a little bit more to be able to interpret that data
> packet. Could you please
>
> - compile the kernel with CONFIG_HID_DEBUG option set
> - modprobe the 'hid' module with 'debug=2' option
>
> and provide the dmesg output that appears when the device is
> connected (so that we have contents of the HID report descriptor and
> kernel interpretation of it) and also after the data packet containing the
> mentioned sequence has been received?

	Hi, 

	Here is the dmesg output. The mouse constantly emmits those 9-bytes frames 
even if I do not touch it, which probably is why it also affects my notebook's 
touchpad.

-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/

--Boundary-00=_JONfK3MJ7DVMYY8
Content-Type: application/x-gzip;
  name="dmesg_bluetooth_mouse.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg_bluetooth_mouse.txt.gz"

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

--Boundary-00=_JONfK3MJ7DVMYY8--
