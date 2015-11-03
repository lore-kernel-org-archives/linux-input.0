From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/3] HID: wacom: Remove useless conditions from
 'wacom_query_tablet_data'
Date: Tue, 3 Nov 2015 14:39:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511031438190.22567@pobox.suse.cz>
References: <1446507673-4458-1-git-send-email-killertofu@gmail.com> <1446507673-4458-2-git-send-email-killertofu@gmail.com> <CAF8JNhKX0hk_Ozsyur1mv=NVP23cr5z7nLTNYmfWNJYNQpMAzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59866 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbbKCNjP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Nov 2015 08:39:15 -0500
In-Reply-To: <CAF8JNhKX0hk_Ozsyur1mv=NVP23cr5z7nLTNYmfWNJYNQpMAzg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 2 Nov 2015, Ping Cheng wrote:

> On Mon, Nov 2, 2015 at 3:41 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > When support for the Cintiq Companion Hybrid and Cintiq Companion 2 was
> > added (36d3c51 and f7acb55), the 'wacom_query_tablet_data' function was
> > updated to include references to CINTIQ_HYBRID and CINTIQ_COMPANION_2
> > with the thought that they were necessary to switch the touch interface
> > into the proper mode. This is unnecessary, however, since those types
> > are only ever associated with the pen interface -- the touch interfaces
> > are either CINTIQ_24HDT or HID_GENERIC. To avoid confusion in the future,
> > we remove the unnecessary CINTIQ_HYBRID and CINTIQ_COMPANION_2 conditions.
> >
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> 
> Reviewed-by: Ping Cheng <pingc@wacom.com>
> 
> for this patch and the 3/3 of this set.

This is really late in the game (the merge window is already open), but 
given the nature of the patches (we'll be sending them as -rc bugfixes 
later anyway), I've just picked those up to for-4.4/wacom.

1/1 I am sure you two will have some more discussion about :) so I am 
ignoring it for now.

-- 
Jiri Kosina
SUSE Labs

