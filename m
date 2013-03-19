From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/7] HID: multitouch: support of hybrid finger/pen devices
Date: Tue, 19 Mar 2013 22:40:57 +0100
Message-ID: <20130319214057.GA7902@polaris.bitmath.org>
References: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1303182313080.9529@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:59970 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab3CSVg0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Mar 2013 17:36:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1303182313080.9529@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri, Benjamin,

> > So the solution consists in relying inconditionaly to the quirk MULTI_INPUT for
> > hid-multitouch. Before registering the input device in hid-input, we can test if
> > it has been populated, and if not, then we simply don't register it. In order to
> > prevent a regression for drivers that do not fill the input device, we need to
> > add an other quirk.
> 
> Hi everybody,
> 
> I am in progress of reviewing this patchset, and so far don't have any 
> major obejctions; I expect to have the review finished this week, so 3.10 
> is definitely a realistic target.

I agree, I think it looks sound in general.

> Just to set my own expectations correctly -- Henrik, are you going to 
> review this patchset as well, or there is no need for me to wait for your 
> feedback?

No need to wait any longer ;-)

Cheers,
Henrik
