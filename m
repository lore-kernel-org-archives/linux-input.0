From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Subject: Synaptics Multi touch capabilities
Date: Wed, 23 Dec 2009 12:13:04 +0100
Message-ID: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:28201 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbZLWLNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 06:13:06 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3075446fgg.1
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2009 03:13:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I have a ASUS 1005HA netbook equipped with a Synaptics touch pad:
[ =A0 18.341491] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1a0b1,
caps: 0xd04731/0xa40000

In Linux, no multitouch capabilities are detected (Zoom, two and three
finger button presses etc.).
This all works with the same hardware in windows 7.
Is there a bug in the linux driver preventing multitouch to work?

Best regards,
Erik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
