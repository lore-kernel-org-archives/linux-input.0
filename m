From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 08/11] HID: hid-multitouch: fix Win 8 protocol
Date: Wed, 31 Oct 2012 19:53:32 +0100
Message-ID: <20121031185332.GA1745@polaris.bitmath.org>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
 <1351241067-9521-9-git-send-email-benjamin.tissoires@gmail.com>
 <20121029221905.GA15537@polaris.bitmath.org>
 <CAN+gG=ESZLHneinkc6kdkazRBfsGP70GaBPfV=jLhnTtZMVrKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:46907 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2JaSsk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 14:48:40 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=ESZLHneinkc6kdkazRBfsGP70GaBPfV=jLhnTtZMVrKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> On Mon, Oct 29, 2012 at 11:19 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> > On Fri, Oct 26, 2012 at 10:44:24AM +0200, Benjamin Tissoires wrote:
> >> Win 8 specification is much more precise than the Win 7 one.
> >> Moreover devices that need to take certification must be submitted
> >> to Microsoft.
> >>
> >> The result is a better protocol support and we can rely on that to
> >> skip all the messy tests we used to do.
> >>
> >> The protocol specify the fact that each valid touch must be reported
> >> within a frame, and that the release touch coordinate must be the
> >> same than the last known touch.
> >> So we can use the always_valid quirk and dismiss reports when we
> >> touch coordiante do not follow this rule.
> >>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> >> ---
> >>  drivers/hid/hid-multitouch.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > Why do we need this patch?
> 
> This patch prevents a corner case where the device use contactID 0 for
> it's first reported touch.
> Once you got the invalid touches, most of the time, contactID will be
> 0, x, y, and other fields too. So this ensures to avoid conflict
> between valid values and garbage values. The problem lies in the fact
> that we don't have the whole overview of the frame (with the contact
> count) to decide which contacts are good and which are not.

I am sorry, but your explanation did not make me any wiser. :-) Are
you saying that touch state changes and touch property changes are
mutually exclusive? For all win8 devices, or just for the serial
protocol ones? For what devices is the current implementation a
problem?

I am asking because this looks more like a device quirk than anything
else.

Thanks,
Henrik
