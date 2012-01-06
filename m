From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: evdev - Add EVIOC mechanism to extract the MT
 slot state
Date: Fri, 6 Jan 2012 19:45:53 +0100
Message-ID: <20120106184553.GA2795@polaris.bitmath.org>
References: <1325863019-2242-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=FUEH851Um4Lco0avqdE2Eup3Jo79Ti4T7XhxT=PO6WeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:57394 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933241Ab2AFSp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2012 13:45:59 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=FUEH851Um4Lco0avqdE2Eup3Jo79Ti4T7XhxT=PO6WeQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

> However, back in January 2011, Dmitry raised the problem that this
> code was not thread safe.

I had forgotten about that respin, thanks for the reminder.

> What happens if 2 applications ask for
> different slots values (let say X.org and utouch-frame)?

As already pointed out, nothing bad.

[...]
> Asking for the current active slot (of the device) is allowed and
> should be done by every application that starts to talk to evdev.

Right you are. The hunk can be removed at the cost of loss of
symmetry, but then it starts to look really ugly. ;-)

Cheers,
Henrik
