From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: quirk for MSI GX680R led panel
Date: Mon, 18 Mar 2013 14:54:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303181454500.9529@pobox.suse.cz>
References: <20130318134702.GB11243@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43897 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab3CRNzA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 09:55:00 -0400
In-Reply-To: <20130318134702.GB11243@hansolo.jdub.homelinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com

On Mon, 18 Mar 2013, Josh Boyer wrote:

> This keyboard backlight device causes a 10 second delay to boot.  Add it
> to the quirk list with HID_QUIRK_NO_INIT_REPORTS.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
