From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid: assorted usage updates from hut 1.12
Date: Wed, 18 May 2011 17:08:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105181708210.28291@pobox.suse.cz>
References: <4DADDEBF.3050407@redhat.com> <1303241310-21354-1-git-send-email-jarod@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33594 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232Ab1ERPI4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 11:08:56 -0400
In-Reply-To: <1303241310-21354-1-git-send-email-jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 19 Apr 2011, Jarod Wilson wrote:

> I've got a Tivo Slide bluetooth remote/dongle, which uses a fair number
> of hid usages that aren't currently mapped in hid-input.c. I'd initially
> written additions to hid-input.c with just this device in mind,
> including some bits that were specific to the device. This go around,
> I'm looking at adding/correcting as many generic HID usages from the HID
> Usage Tables, version 1.12, as I can -- which also serves to enable all
> but four of the buttons on the Tivo Slide remote[*].
> 
> Outside of fixing the obviously incorrect mapping of 0xc 0x45 from
> KEY_RADIO to KEY_RIGHT, and making use of the new KEY_IMAGES (just added
> in 2.6.39-rc4) for AL Image Browser instead of KEY_MEDIA, these are
> purely additions, and thus should have no negative impact on any already
> functional HID devices. Most of the added mappings seemed to be
> perfectly logical to me, but there were a few that were mapped on more
> of an "I think this makes the most sense" basis.

It took me quite some time to go over the individual changes, sorry for 
the delay. I have applied the patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
