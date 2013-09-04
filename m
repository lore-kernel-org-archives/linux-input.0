From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: uhid: improve uhid example client
Date: Wed, 4 Sep 2013 11:37:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041135380.3684@pobox.suse.cz>
References: <1378071918-1152-1-git-send-email-dh.herrmann@gmail.com> <CAN+gG=GbY9mQGQhRZcf9Osc1q5YjwpGVExhH6pAN9X0urcRv0w@mail.gmail.com> <CANq1E4QwPRgCkROyLWNU7KtVDU6DAoLG+pD2_6brD90gSiJ9pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47133 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934373Ab3IDJhH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 05:37:07 -0400
In-Reply-To: <CANq1E4QwPRgCkROyLWNU7KtVDU6DAoLG+pD2_6brD90gSiJ9pg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Anderson Lizardo <anderson.lizardo@openbossa.org>

On Mon, 2 Sep 2013, David Herrmann wrote:

> But thanks for the usb-spec hint, haven't looked there, yet.

There is also HID report descriptor tool available at

	http://www.usb.org/developers/hidpage/

The tool itself isn't that earth-shaking (and you have to run it in wine 
:) ), but it contains a load of pre-defined example descriptors for 
various devices.

> No intention to modify it. Looks all good to me now.

Now applied, thanks.

-- 
Jiri Kosina
SUSE Labs
