From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Improve Alps HID Touchpad code
Date: Tue, 21 Jun 2016 10:22:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606211021350.6874@cbobk.fhfr.pm>
References: <1466496899-9392-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51640 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697AbcFUIWe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 04:22:34 -0400
In-Reply-To: <1466496899-9392-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Tue, 21 Jun 2016, Masaki Ota wrote:

> >From Masaki Ota <masaki.ota@jp.alps.com>
> 
> Remove the unnecessary codes.
> Add the device ID of "HID_DEVICE_ID_ALPS_U1_DUAL" to hid-ids.h
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

I have already accepted the previous version on the driver and made a 
couple of fixes on top (I've CCed you on all the patches).

Could you please base your further fixes on top of the 'for-4.8/alps' 
branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git

tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs

