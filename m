From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 2/4] hid: hid-input: Remove obsolete default events
 per packet setting.
Date: Tue, 5 Apr 2011 14:20:16 +0200
Message-ID: <20110405122016.GA19455@polaris.bitmath.org>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
 <1301727259-5185-2-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:56304 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1DEMTz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 08:19:55 -0400
Content-Disposition: inline
In-Reply-To: <1301727259-5185-2-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Brown <jeffbrown@android.com>
Cc: dmitry.torokhov@gmail.com, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Brown <jeffbrown@google.com>

On Fri, Apr 01, 2011 at 11:54:17PM -0700, Jeff Brown wrote:
> From: Jeff Brown <jeffbrown@google.com>
> 
> The hardcoded default is no longer needed because the input core now
> calculates an appropriate value when the input device is registered.
> 
> Signed-off-by: jeffbrown@android.com
> ---

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
