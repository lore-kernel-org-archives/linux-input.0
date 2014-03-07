From: Tolga Cakir <cevelnet@gmail.com>
Subject: Re: [PATCH 0/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 7 Mar 2014 19:20:16 +0100
Message-ID: <CABcamCAaB1pfq37Fm9bqoQLUt4Jtf=bbc3Nxpn4fcjgvFVELxA@mail.gmail.com>
References: <5319EB7C.5070209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:40834 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaCGSUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 13:20:17 -0500
Received: by mail-bk0-f41.google.com with SMTP id d7so997429bkh.0
        for <linux-input@vger.kernel.org>; Fri, 07 Mar 2014 10:20:16 -0800 (PST)
In-Reply-To: <5319EB7C.5070209@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz

2014-03-07 16:53 GMT+01:00 Derya <derya.kiran@yahoo.de>:
> The MS Surface Pro 2 has a very annoying USB composite device on port=
 2.3.
> It has 3 interfaces:
> - Interface 0 is the sensor-hub
> - Interface 1 is the wacom digitizer=B2 (it's one without finger inpu=
t, there
> is an atmel digitizer on port 2.4 for finger input)
> - Interface 2 is the keyboard, if a keyboard cover is attached.
>
> This USB composite device changes it product id depending if and whic=
h
> keyboard cover is attached.
> Each of this hid devices contains several collections, this complicat=
ed
> everything.
> I have uploaded a lsusb output to: http://pastebin.com/Jun5sa2t
>
> We also need the HID_QUIRK_NOGET for this usb composite device, witho=
ut it
> hid-sensor-hub fails with a submit urb failure evertime a keyboard co=
ver is
> (de)attached and it takes some seconds until the keyboard and wacom
> digitizer responds.

I had a similar issue while implementing Sidewinder X4 support. Can
you check the output of hid->type for each of these interfaces? I was
able to differentiate between the interfaces on my devices by checking
"hid->type", this might help here, too.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
