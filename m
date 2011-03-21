From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 4/4] Input: atmel_mxt_ts - Convert to MT protocol B
Date: Mon, 21 Mar 2011 09:24:18 +0100
Message-ID: <20110321082418.GA3556@polaris.bitmath.org>
References: <1299826046-20081-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:35232 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757Ab1CUIVA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 04:21:00 -0400
Content-Disposition: inline
In-Reply-To: <1299826046-20081-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

On Fri, Mar 11, 2011 at 03:47:26PM +0900, Joonyoung Shim wrote:
> Atmel touchscreen chips can use MT protocol B because they can assign
> unique id to ABS_MT_TRACKING_ID from finger id provided by hardware.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---

Looks good,

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thank you.
Henrik
