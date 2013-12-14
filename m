From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: Why does adding HID USB ID allow a keyboard to work?
Date: Sat, 14 Dec 2013 01:14:14 -0600
Message-ID: <CA+BWVUT_v4nQTY7DHfdwegJ8rKOEraodReAkWt4y7Ck93_-PBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47288 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab3LNHOg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 02:14:36 -0500
Received: by mail-wi0-f174.google.com with SMTP id z2so188786wiv.13
        for <linux-input@vger.kernel.org>; Fri, 13 Dec 2013 23:14:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a basic question about the way the linux kernel handles human
input devices. I bought a Surface Pro 2 with a Type cover keyboard.
This did not work out of the box with stock linux kernel 3.11. When I
added the hardware id of the device to the hid-microsoft.c driver it
worked.

Does this work simply because when I add the hardware id to the
driver, the kernel knows to use usb-hid generic driver with the
device? I'm trying to understand the hid-microsoft driver and it seems
to apply quirks/hacks that enable Microsoft devices to work with the
hid driver. Such as remapping keys. I don't need any of these quirks
as all the media keys on the keyboard work all by adding the hardware
id.

Why doesn't the device work out of the box? Is the device not
advertising itself as a hid device over usb? I'm little confused as to
how this should be fixed. Does the kernel fail in noticing this hid
device or does the device fail in telling the kernel it is a
keyboard/mouse?
