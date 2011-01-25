From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4] input: wacom - Pass touch resolution to clients
 through input_absinfo
Date: Tue, 25 Jan 2011 20:55:15 +0100
Message-ID: <20110125195515.GA1834@polaris.bitmath.org>
References: <1295984309-9408-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:50208 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752179Ab1AYTyl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 14:54:41 -0500
Content-Disposition: inline
In-Reply-To: <1295984309-9408-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, Jan 25, 2011 at 11:38:29AM -0800, Ping Cheng wrote:
> Fixed the workaround used for kernels older than 2.6.35.
> 
> This version added a funtion, wacom_calculate_touch_res, to calculate
> touch resolutions. The word "touch" is needed since the routine does
> not apply to pen tablets.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---

The SOB area should still contain the original text, explaining the
reason for the patch... other than that, it all looks fine to me.

Thanks,
Henrik
