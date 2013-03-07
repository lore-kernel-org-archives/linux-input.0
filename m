From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: holtek: Holtek devices depends on USB_HID
Date: Thu, 7 Mar 2013 15:28:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303071528020.28677@pobox.suse.cz>
References: <1362649709-9608-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab3CGO2M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Mar 2013 09:28:12 -0500
In-Reply-To: <1362649709-9608-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 7 Mar 2013, Benjamin Tissoires wrote:

> In the HID drivers tranport cleanup series, I removed the dependency
> between hid-holtek and usbhid. This was wrong as hid-holtek.c relies
> extensively on usb calls.
> 
> This fixes compilation error when CONFIG_USB_SUPPORT is not enabled.

Applied.

-- 
Jiri Kosina
SUSE Labs
