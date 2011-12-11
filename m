From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Sun, 11 Dec 2011 22:48:30 +0100
Message-ID: <20111211214830.GA14097@tapura>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:33969 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab1LKVsd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Dec 2011 16:48:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by v36691.1blu.de (Postfix) with ESMTP id D16198950018
	for <linux-input@vger.kernel.org>; Sun, 11 Dec 2011 22:48:31 +0100 (CET)
Received: from v36691.1blu.de ([127.0.0.1])
	by localhost (v36691.1blu.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zOcEksmg-s6i for <linux-input@vger.kernel.org>;
	Sun, 11 Dec 2011 22:48:31 +0100 (CET)
Received: from tapura (p4FF0FC3D.dip.t-dialin.net [79.240.252.61])
	by v36691.1blu.de (Postfix) with ESMTPSA id 7FFF78950017
	for <linux-input@vger.kernel.org>; Sun, 11 Dec 2011 22:48:31 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Simon!

Let's continue the discussion on the list. I did made some progress
that requires input from the HID maintainers.

> You have to check the rsize, otherwise you might have problems writing
> outside the size of the original descriptor.

That's exactly what I've been doing, or did I miss something?
In fact, I wanted to be absolutely sure and only mess with the descriptor
when the sizes match.  (*rsize == 137)

> Note a D-Pad might be defined as 'Buttons', a 'D-Pad' or as a 'Hat'. You
> need to check out the values change in the HID stream.

It's defined as a 'Hat' with 8 different directions.

> Send me a copy of the original descriptor and I'll have a look.

Should already be on the list. And I was able to identify the culprit so
no need to bother you.

The problem is the following code in hidinput_configure_usage
(drivers/hid/hid-input.c):

	if (field->flags & HID_MAIN_ITEM_CONSTANT)
		goto ignore;

The buttons and the hat are defined with the constant flag enabled.
Now I might be reading the spec wrong, but I'm not so sure that we can
simply skip constant values.
This is the description of the data/constant flag.

    Indicates whether the item is data or a constant
    value. Data indicates the item is defining report
    fields that contain modifiable device data. Constant
    indicates the item is a static read-only field in a
    report and cannot be modified (written) by the
    host.


Well, I need to patch the descriptor nevertheless because it defines a
non-existing sixth axis. Might as well remove the constant flag on the
buttons and hat. However, other devices might be affected as well, so
I'd like to get some input on how to deal with the situation.


Andreas
