From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] hid-multitouch: Auto detection of maxcontacts
Date: Wed, 9 Mar 2011 09:42:22 +0100
Message-ID: <20110309084222.GA3569@polaris.bitmath.org>
References: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
 <1299601979-4871-2-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:60339 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756782Ab1CIIjw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 03:39:52 -0500
Content-Disposition: inline
In-Reply-To: <1299601979-4871-2-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> This patch enables support of autodetection of maxcontacts.
> We can still manually provide maxcontact in case the device
> lies on it.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>

It seems quite alright to let the classes contain the expected number
of contacts, so I do not really see the reason for that part of the
patch. How about keeping the maxcontacts in the class, and then do
max(hid-provided-maxcontacts, default-maxcontacts)?

Thanks,
Henrik
