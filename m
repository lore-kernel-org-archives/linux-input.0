From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: [RFC] HID and multitouch
Date: Sun, 6 Dec 2009 11:58:18 +0100
Message-ID: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:44084 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642AbZLFLGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 06:06:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, Peter Hutterer <peter.hutterer@who-t.net>

Dear Jiri,

over the last few months I have been working on HID quirks for a =20
bunch of multitouch devices: NTrig, two flavours of Stantum devices, =20
3M, Acer T230H. For each of these I have working code, which I should =20
be able to submit real soon now.

However, people are asking me questions about why a specific driver =20
is needed for each device. Answers are starting to emerge, and it =20
looks like they might lead to some work on the Linux HID code itself:

- the one-to-one mapping between HID and evdev is stretched to its =20
limits with these devices that have several times the same group of =20
HID fields in the same event: an event is made of fingers, each =20
finger is made of an X, a Y and a few other fields. We need a =20
mechanism to emit SYN_MT_REPORT between fingers.

- furthermore, some fingers have to be discarded because they are =20
placeholders with no valid data, and we know if to dump them only =20
when they have been fully parsed. Therefore, we need a mechanism to =20
cache finger data until the decision is made. Currently, the caching =20
mechanism has to be device-dependent because the fields are not =20
exactly the same and they come in a device-dependent order.

- for all these devices, it is very tempting to have a touchscreen =20
emulation so as to use them with existing software (X.org, =20
particularly). Rafi and I share the idea that this should be done by =20
creating two evdev nodes: a backward-compatible touchscreen, and a =20
multitouch one. Most of the corresponding code could be shared among =20
drivers. However, the algorithm for producing the touchscreen events =20
differs from one device to another and we need to support this.


Any opinions or suggestions?

Cheers

St=E9phane

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
