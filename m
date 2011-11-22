From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Tue, 22 Nov 2011 01:03:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
 <4ECAE019.4000409@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33212 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab1KVADE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 19:03:04 -0500
In-Reply-To: <4ECAE019.4000409@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On Mon, 21 Nov 2011, Jeremy Fitzhardinge wrote:

> > So I take it that you are now working on that, is my understanding 
> > correct?
> 
> Yep, though I'm still trying to see how it all fits together.  For
> example, in which function should I check to see if BatteryStrength is
> in the table?

Well, parsing HID report descriptor is not completely trivial, although 
it's not a heart surgery either.

It's all done by 'hid_parse()' main routine, which calls one of 
hid_parser_main(), hid_parser_global(), hid_parser_local() or 
hid_parse_reserved(), depending on the type of the item.

For hid-input usages, the most important part of the setup is then done in 
hidinput_configure_usage().

The actual 'reaction' to the event once it is signalled by device then 
happens in hidinput_hid_event(). This is being called from 
hid_process_event() handler, and individual drivers can register their own 
callbacks for event processing that get called before this 'global' 
handler executes (see for example logi_dj_ll_input_event() in 
drivers/hid/hid-logitech-dj.c).

Hope this helps,

-- 
Jiri Kosina
SUSE Labs
