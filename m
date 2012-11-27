From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 01/11] HID: hid-input factorize hid_input allocation
Date: Tue, 27 Nov 2012 20:45:43 +0100
Message-ID: <20121127194543.GA774@polaris.bitmath.org>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
 <1353684694-5723-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:36878 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab2K0Tol (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 14:44:41 -0500
Content-Disposition: inline
In-Reply-To: <1353684694-5723-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Nov 23, 2012 at 04:31:24PM +0100, Benjamin Tissoires wrote:
> This just refactors the allocation of hid_input.

I think "breaks out the allocation" would be a more appropriate description.

> No semantic changes.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-input.c | 61 +++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
