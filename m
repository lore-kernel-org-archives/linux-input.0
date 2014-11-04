From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/2] HID: logitech-hidpp: fix negated returns
Date: Tue, 4 Nov 2014 11:11:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411041111190.19451@pobox.suse.cz>
References: <1415048999-4490-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41998 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbaKDKLm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Nov 2014 05:11:42 -0500
In-Reply-To: <1415048999-4490-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 3 Nov 2014, Benjamin Tissoires wrote:

> Reported by Dan Carpenter:
> 
> drivers/hid/hid-logitech-hidpp.c:359 hidpp_root_get_protocol_version() warn: should this return really be negated?
> drivers/hid/hid-logitech-hidpp.c:398 hidpp_devicenametype_get_count() warn: should this return really be negated?
> drivers/hid/hid-logitech-hidpp.c:417 hidpp_devicenametype_get_device_name() warn: should this return really be negated?
> drivers/hid/hid-logitech-hidpp.c:524 hidpp_touchpad_get_raw_info() warn: should this return really be negated?
> 
> The problem lies in hidpp_send_message_sync() which can return 2 types of
> errors depending of their sign. Adding a comment there to clarify what is
> happening.
> 
> To solve that, print an error in case of a protocol problem, and raise
> -EPROTO instead.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Changes in v2:
> - also return if the ret code is negative

Applied.

-- 
Jiri Kosina
SUSE Labs
