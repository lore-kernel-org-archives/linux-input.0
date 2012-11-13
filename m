From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 11/13] HID: hid-multitouch: support for hovering
 devices
Date: Tue, 13 Nov 2012 19:55:05 +0100
Message-ID: <20121113185505.GA3641@polaris.bitmath.org>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
 <1352306256-12180-12-git-send-email-benjamin.tissoires@gmail.com>
 <20121113164239.GA712@polaris.bitmath.org>
 <CAN+gG=EbAdfOG_vwt2uamV+JcAKLFqM=zTo9oRQ9RLayrpdsoA@mail.gmail.com>
 <20121113180453.GA3622@polaris.bitmath.org>
 <CAN+gG=HyDrr7mWsYGFue_xuzX0xm45n1EDpsDgU1RKJ8SkuP9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:44760 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab2KMSso (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Nov 2012 13:48:44 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=HyDrr7mWsYGFue_xuzX0xm45n1EDpsDgU1RKJ8SkuP9Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> I just intend to force the update of the distance value at the
> beginning of the touch.
> This is just to send a coherent state when the finger goes in range,
> and to make sure that user-space application do not rely on the
> undefined value (0) whereas the kernel thought it was set to 1.

Right, so we use EVIOCGMTSLOTS. This "problem" occurs with
ABS_MT_ORIENTATION as well.

Thanks,
Henrik
