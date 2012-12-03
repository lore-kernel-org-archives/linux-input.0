From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 2/4] input: Cypress PS/2 Trackpad psmouse driver
Date: Mon, 3 Dec 2012 07:31:24 +0100
Message-ID: <20121203063124.GA2609@polaris.bitmath.org>
References: <1354226281-3476-1-git-send-email-kamal@canonical.com>
 <1354226281-3476-3-git-send-email-kamal@canonical.com>
 <B27AC323FA92C946BA36D2913DDC8E370234D97E49AE@VMBX126.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:43366 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2LCG3n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Dec 2012 01:29:43 -0500
Content-Disposition: inline
In-Reply-To: <B27AC323FA92C946BA36D2913DDC8E370234D97E49AE@VMBX126.ihostexchange.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Kamal Mostafa <kamal@canonical.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, customercare <customercare@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>, "dudl@cyress.com" <dudl@cyress.com>

Hi Dudley,

> Another question is that new interface input_mt_assign_slots() is introduced since 3.7-rc7 or later,
> So we could not support the kernel releases that earlier than 3.7-rc7 with this driver.

The patch is a submission to mainline, so of course it should be in sync with mainline.

Thanks.
Henrik
