From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC 1/5] INPUT: xpad: Add minimal support for Logitech G920
 Wheel
Date: Fri, 30 Oct 2015 14:51:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510301450380.17538@pobox.suse.cz>
References: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36975 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758934AbbJ3Nvs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Oct 2015 09:51:48 -0400
In-Reply-To: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, 23 Oct 2015, Simon Wood wrote:

> When plugged in the Logitech G920 wheel starts with USBID 046d:c261
> and behaviors as a vendor specific class. If a 'magic' byte sequence
> is sent the wheel will detach and reconnect as a HID device with the
> USBID 046d:c262.

[ Benjamin added to CC ]

Benjamin, before I proceed with this series, I'd like you to have review 
the HID++ bits at least, if possible. Thanks,

-- 
Jiri Kosina
SUSE Labs

