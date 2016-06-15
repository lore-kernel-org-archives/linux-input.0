From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] Alps I2C HID Touchad-Stick support
Date: Wed, 15 Jun 2016 09:10:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606150909280.6874@cbobk.fhfr.pm>
References: <1464601398-8085-1-git-send-email-masaki.ota@jp.alps.com> <OSXPR01MB040899934F12D66E75E6D600C7450@OSXPR01MB0408.jpnprd01.prod.outlook.com> <alpine.LNX.2.00.1606011520390.11844@cbobk.fhfr.pm> <OSXPR01MB0408CB1262F438E79F98204EC7590@OSXPR01MB0408.jpnprd01.prod.outlook.com>
 <alpine.LNX.2.00.1606140115120.6874@cbobk.fhfr.pm> <OSXPR01MB04086A33D420C26506F1BDF8C7540@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60469 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbcFOHKN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 03:10:13 -0400
In-Reply-To: <OSXPR01MB04086A33D420C26506F1BDF8C7540@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: "benjamin.tissorires@redhat.com" <benjamin.tissorires@redhat.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 14 Jun 2016, Masaki Ota wrote:

> I have made the document for this device. Actually, the device structure 
> is the same as PS2 Touchpad + Stickpinter. You can see StickPointer code 
> in alps.c

Thanks. Could you please resubmit the full patch with the DMA-on-stack 
fixes and extended changelog / documentation, as discussed in this thread? 
Thanks.

-- 
Jiri Kosina
SUSE Labs

