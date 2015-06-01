From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] Add driver for mouse logitech M560
Date: Mon, 1 Jun 2015 14:39:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506011437270.16120@pobox.suse.cz>
References: <1432976427-12013-1-git-send-email-kreijack@libero.it> <1432976427-12013-3-git-send-email-kreijack@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47038 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbbFAMjS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Jun 2015 08:39:18 -0400
In-Reply-To: <1432976427-12013-3-git-send-email-kreijack@libero.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, linux-input@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>

On Sat, 30 May 2015, Goffredo Baroncelli wrote:

> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The Logitech M560 is a wireless mouse designed for windows 8 which uses
> the unifying receiver.
> Compared to a standard one, some buttons (the middle one and the
> two ones placed on the side) are bound to a key combination
> instead of a generating classic "mouse" button events.
> 
> The device shows up as a mouse and keyboard combination: when the middle
> button is pressed it sends a key (as keyboard) combination, the same
> happens for the two side button. The left/right/wheel work as expected
> from a mouse. To complicate things further, the middle button sends
> different keys combinations between odd and even presses.
> In the "even" press it also sends a left click. But the worst thing
> is that no event is generated when the middle button is released.
> 
> It is possible to re-configure the mouse sending a command (see function
> m560_send_config_command()). After this command the mouse sends some
> useful data when the buttons are pressed and/or released.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 227 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 224 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 5fd530a..a5c71c2 100644
[ ... snip ... ]
> +		v = hid_snto32(hidpp_field_extract(hdev, data+3, 0, 12), 12);
> +		input_report_rel(mydata->input, REL_X, v);
> +
> +		v = hid_snto32(hidpp_field_extract(hdev, data+3, 12, 12), 12);
> +		input_report_rel(mydata->input, REL_Y, v);

There is no hidpp_field_extract() any more in this version of the 
patchset.

I've fixed that up and queued in for-4.2/logitech.

-- 
Jiri Kosina
SUSE Labs
