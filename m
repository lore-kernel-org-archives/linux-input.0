From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Sat, 19 May 2012 01:10:35 -0300
Message-ID: <CACo8zOc_kO81Mo9FDuON5Ru-jhsNp+2d+jP30Sewan+kA3uQmw@mail.gmail.com>
References: <4EC75224.7070207@goop.org>
	<alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	<4EC820F8.4070900@goop.org>
	<alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	<4ECA7E7D.80207@goop.org>
	<alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	<4ECAE019.4000409@goop.org>
	<alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	<4ECCB38A.8000503@goop.org>
	<alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
	<CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
	<4ED90E6D.8090402@goop.org>
	<CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
	<4ED9BDF8.3010600@goop.org>
	<alpine.LNX.2.00.1112061016020.18207@pobox.suse.cz>
	<4EE01936.70807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33656 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2ESEKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 May 2012 00:10:36 -0400
Received: by obbtb18 with SMTP id tb18so4840455obb.19
        for <linux-input@vger.kernel.org>; Fri, 18 May 2012 21:10:35 -0700 (PDT)
In-Reply-To: <4EE01936.70807@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I was just informed that my HID patch to probe the
battery status was merged upstream, but it misses
my:
USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI
on the hid-input.c file, also if you notice Jeremy Fitzhardinge
tested on  a 2011 model which had the issue, my model
is from 2007 and also has the issue, shouldn't we include
the models in between?
As I don't have commit access should I make a proper
patch just for this extra quirk?

BTW, these Apple devices allow for changing their
names, when you pair them on a Mac the OS put
it's hostname on the device, I don't think automating
to this level is useful but the feature is important
since my devices have my boss Mac hostname :/
is this already available on HID devices or would be
another specif addition?

Thanks.

static const struct hid_device_id hid_battery_quirks[] = {
	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
	{}
};
