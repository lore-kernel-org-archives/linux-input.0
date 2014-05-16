From: "Kieran Kunhya" <kierank@obe.tv>
Subject: usbhid: PicoLCD 256x64 USB error -71
Date: Fri, 16 May 2014 23:28:41 +0100
Message-ID: <032001cf7156$31a75610$94f60230$@obe.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:64942 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaEPW2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2014 18:28:42 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so5482457wgg.0
        for <linux-input@vger.kernel.org>; Fri, 16 May 2014 15:28:40 -0700 (PDT)
Received: from KieranPC (cpc1-aztw23-2-0-cust1.aztw.cable.virginm.net. [77.98.155.2])
        by mx.google.com with ESMTPSA id dn1sm597343wid.6.2014.05.16.15.28.39
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 15:28:39 -0700 (PDT)
Content-Language: en-gb
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

As requested I forward my bug report to the list:

=46rom time to time on an ASRock IMB-181D motherboard this device fails=
 to be
added.=A0
It seems to work reliably when using Windows 7.=A0
The errors in dmesg vary but usually take the form:=A0
[=A0 5.328040] usb 3-7: string descriptor 0 read error: -71=A0
(snip)=A0
[=A0 10.333605] usbhid 3-7:1.0: can't add hid device: -71=A0
[=A0 10.333639] usbhid: probe of 3-7:1.0 failed with error -71=A0
I can provide a PicoLCD unit if necessary and possibly also fund a
fix/workaround.

More information is available here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D76341

Kieran Kunhya

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
