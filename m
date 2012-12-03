From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v3 2/4] input: Cypress PS/2 Trackpad psmouse driver
Date: Mon, 3 Dec 2012 01:31:45 -0500
Message-ID: <B27AC323FA92C946BA36D2913DDC8E370234D97E49B8@VMBX126.ihostexchange.net>
References: <1354226281-3476-1-git-send-email-kamal@canonical.com>
 <1354226281-3476-3-git-send-email-kamal@canonical.com>
 <B27AC323FA92C946BA36D2913DDC8E370234D97E49AE@VMBX126.ihostexchange.net>
 <20121203063124.GA2609@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.ihostexchange.net ([66.46.182.52]:56282 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab2LCGbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Dec 2012 01:31:48 -0500
In-Reply-To: <20121203063124.GA2609@polaris.bitmath.org>
Content-Language: zh-CN
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Kamal Mostafa <kamal@canonical.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, customercare <customercare@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>, "dudl@cyress.com" <dudl@cyress.com>

Hi Henrik,

Okay, agree.
Thanks.

Best Wishes,
Dudley Du
dudl@cypress.com

-----Original Message-----
From: Henrik Rydberg [mailto:rydberg@euromail.se]
Sent: Monday, December 03, 2012 2:31 PM
To: Dudley Du
Cc: Kamal Mostafa; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Dmitry Torokhov; David Solda; Troy Abercrombia; customercare; Kyle Fazzari; Mario Limonciello; Tim Gardner; Herton Krzesinski; dudl@cyress.com
Subject: Re: [PATCH v3 2/4] input: Cypress PS/2 Trackpad psmouse driver

Hi Dudley,

> Another question is that new interface input_mt_assign_slots() is
> introduced since 3.7-rc7 or later, So we could not support the kernel releases that earlier than 3.7-rc7 with this driver.

The patch is a submission to mainline, so of course it should be in sync with mainline.

Thanks.
Henrik

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
