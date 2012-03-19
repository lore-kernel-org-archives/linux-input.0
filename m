From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 06/20] Input: atmel_mxt_ts - allow writing to object
 sysfs entry
Date: Mon, 19 Mar 2012 09:04:02 +0100
Message-ID: <20120319080402.GA15965@polaris.bitmath.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-7-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:38281 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab2CSIBj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 04:01:39 -0400
Content-Disposition: inline
In-Reply-To: <1331640263-18935-7-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

Hi Daniel,

> Userspace can write a 24-bit value (encoded as a 6 character hex string)
> to the 'object' sysfs entry to modify a single byte of the object table.
> The hex string encodes a 3 bytes, in the following format:
>  TTFFVV
> 
> Where:
>  TT = object type
>  FF = object offset
>  VV = byte value
> 
> The object table is modified in device ram, which means the change is
> volatile, and will be overwritten on the next device reset.  To make
> changes permanent, the new settings should be persisted in the device's
> Non-Voltatile Memory using the updatenv sysfs entry.
> 
> Also, since the device driver initializes itself by reading some values
> from the object table, the entire driver may need to be unloaded and
> reloaded after writing the values for the driver to stay in sync.  Whether
> this is required depends on exactly which values were updated.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---

Perhaps you could give an example of why this is needed?

Thanks,
Henrik
