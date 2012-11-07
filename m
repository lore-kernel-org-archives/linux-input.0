From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4] staging: ste_rmi4: Convert to Type-B support
Date: Wed, 7 Nov 2012 20:57:08 +0100
Message-ID: <20121107195708.GA3754@polaris.bitmath.org>
References: <20121103013623.0f3a1b28168a9a42881b0b00@tw.synaptics.com>
 <20121107134934.b37e923588f4a24af146a93b@tw.synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:60991 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab2KGTv1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 14:51:27 -0500
Content-Disposition: inline
In-Reply-To: <20121107134934.b37e923588f4a24af146a93b@tw.synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandra Chin <Alexandra.Chin@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>

Hi Alexandra,

> Convert to MT-B because Synaptics touch devices are capable of tracking
> identifiable fingers.
> 
> Signed-off-by: Alexandra Chin <alexandra.chin@tw.synaptics.com>
> ---
> Changes from v4:
>         - Incorporated Henrik's review comments
>           *split function synpatics_rmi4_touchscreen_report
>           *split function synaptics_rmi4_i2c_query_device

Thanks for the changes. The patch looks cleaner, but also much larger,
containing many changes irrelevant to the commit message (and to what
has hitherto been reviewed). Please resend a minimum patch, there is
plenty of room for additional patches after this one. :-)

Thanks,
Henrik
