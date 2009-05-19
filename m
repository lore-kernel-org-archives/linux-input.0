From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH  2/3] hid: Multitouch support for the N-Trig
 touchscreen
Date: Tue, 19 May 2009 16:46:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905191643290.22712@wotan.suse.de>
References: <2DB714C8-82E9-411A-881D-5327C521B5FC@enac.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-1678057659-1242744360=:22712"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46746 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbZESOqE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 10:46:04 -0400
In-Reply-To: <2DB714C8-82E9-411A-881D-5327C521B5FC@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-1678057659-1242744360=:22712
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


[ added Rafi Rubin to CC ]


On Tue, 19 May 2009, Stéphane Chatty wrote:

> Exported hidinput_hid_event, so as to be able to call it from device-specific
> drivers.
> 
> Signed-off-by: Stephane Chatty <chatty@enac.fr>
> 
> diff -rupN a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> --- a/drivers/hid/hid-input.c	2009-05-09 02:14:14.000000000 +0200
> +++ b/drivers/hid/hid-input.c	2009-05-16 16:10:39.000000000 +0200
> @@ -653,6 +653,7 @@ void hidinput_hid_event(struct hid_devic
> 	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type ==
> 	EV_KEY))
> 		input_event(input, usage->type, usage->code, 0);
> }
> +EXPORT_SYMBOL_GPL(hidinput_hid_event);

Why is this needed? ->event() callback is called for every HID driver 
which has this callback registered, and fallback to hidinput_hid_event() 
is performed in cases the driver-specific ->event() handler returns return 
value > 0 , signalizing that the event hasn't been fully processed and 
processing by generic layer is needed.

-- 
Jiri Kosina
SUSE Labs
--168427776-1678057659-1242744360=:22712--
