From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESENT] Input: elan_i2c - enable ELAN0600 acpi panels
Date: Mon, 20 Jul 2015 09:56:59 -0700
Message-ID: <20150720165659.GC30252@dtor-ws>
References: <1437158979-12381-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1507201129390.1141@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34263 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbbGTQ5E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 12:57:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1507201129390.1141@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Duson Lin <dusonlin@emc.com.tw>, Alessio Treglia <alessio@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 20, 2015 at 11:30:02AM +0200, Jiri Kosina wrote:
> On Fri, 17 Jul 2015, Benjamin Tissoires wrote:
> 
> > ELAN0600 seems to work just fine in mouse emulation mode through i2c-hid,
> > but to have full raw touch support we need to register it in elan_i2c.ko
> > 
> > Reported-and-tested-by: Alessio Treglia <alessio@debian.org>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Acked-by: Jiri Kosina <jkosina@suse.com>

Applied, thank you.

-- 
Dmitry
