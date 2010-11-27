From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 11:06:43 +0300
Message-ID: <4CF0BC13.2010800@gmail.com>
References: <4CEE6D2A.9040408@euromail.se>	<4CEE6EE8.4060805@gmail.com> <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44679 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0K0IHH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:07:07 -0500
Received: by ewy5 with SMTP id 5so1260301ewy.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:07:05 -0800 (PST)
In-Reply-To: <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On 11/27/2010 02:02 AM, Chris Bagwell wrote:
> When I looked at input_absinfo.resolution, I see only synaptics.c is
> using it right now and it is defined using units/mm.
I'm not sure if it matters a lot, but Jiri has accepted my resolution
calculation patch to hid-input.c [1] which does it in *units/inch* for
generic HID devices, which choose to provide correct information in their
report descriptors.

Sincerely,
Nick

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;f=drivers/hid/hid-input.c;h=8e733b6eae27587366c138187e59119b2b49ec35;hp=6c03dcc5760a277097bb17d866cc33aa17db484a;hb=4ea6e4ffb4acdaaf9ba7687dbd84ae36e26cef9e;hpb=b6dc79929fa18a97bbc08400db72405ad835622f
