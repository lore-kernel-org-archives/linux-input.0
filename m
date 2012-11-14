From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4 09/14] Input: introduce EV_MSC Timestamp
Date: Wed, 14 Nov 2012 18:53:33 +0100
Message-ID: <20121114175333.GA4804@polaris.bitmath.org>
References: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
 <1352908766-4492-10-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:35817 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423096Ab2KNRrF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 12:47:05 -0500
Content-Disposition: inline
In-Reply-To: <1352908766-4492-10-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 14, 2012 at 04:59:21PM +0100, Benjamin Tissoires wrote:
> Some devices provides the actual timestamp (hid_dg_scan_time in win8 ones)
> computed by the hardware itself. This value is global to the frame and is
> not specific to the multitouch protocol.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
> ---

Does not directly apply to 3.7 due to the uapi changes, but trivial enough.

Henrik
