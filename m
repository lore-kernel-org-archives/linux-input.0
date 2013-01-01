From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Tue, 01 Jan 2013 19:46:26 +0000
Message-ID: <1357069586.8915.11.camel@localhost>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
	 <CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
	 <CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
	 <CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:58273 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab3AAUeF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jan 2013 15:34:05 -0500
In-Reply-To: <CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Dnia 2012-12-27, czw o godzinie 22:16 -0200, Daniel Nicoletti pisze:
> Hi, I've sent this message a while ago but forgot to add
> linux-input, I'm really willing to give it a final fix to the issue
> but I need directions, I really can't see what's wrong with
> the udev thing, so again (with linux-input):
> 
> The problem is that when a HID device that has a battery
> is added to the system it doesn't emit the udev events
> for the battery added or removed, which breaks upower..s
Hi Daniel,
I have a wacom device with battery. A "udevadm monitor" report when
connecting Intuos4 Wireless over bluetooth: http://pastebin.com/zyaXeqcS

Battery state is only updated when the tablet is in use. 

What kind of problems you have? Intuos4 Wireless battery reporting seems
to be working fine (except wrong name, but that's a gnome issue) 
-- 
Kind regards,
Przemo Firszt


