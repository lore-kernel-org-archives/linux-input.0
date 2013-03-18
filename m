From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: [PATCH] HID: usbhid: quirk for MSI GX680R led panel
Date: Mon, 18 Mar 2013 11:41:43 -0400
Message-ID: <20130318154143.GE11243@hansolo.jdub.homelinux.org>
References: <20130318134702.GB11243@hansolo.jdub.homelinux.org>
 <alpine.LNX.2.00.1303181454500.9529@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9528 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868Ab3CRPm2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 11:42:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1303181454500.9529@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com

On Mon, Mar 18, 2013 at 02:54:58PM +0100, Jiri Kosina wrote:
> On Mon, 18 Mar 2013, Josh Boyer wrote:
> 
> > This keyboard backlight device causes a 10 second delay to boot.  Add it
> > to the quirk list with HID_QUIRK_NO_INIT_REPORTS.
> 
> Applied, thanks.

Ugh.  Typo in this patch that prevents it from building.  I shall hang
my head in shame and send a fixed v2.  My apologies.

josh
