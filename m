From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 1/4] input: Set default events per packet.
Date: Tue, 5 Apr 2011 14:16:45 +0200
Message-ID: <20110405121645.GB19391@polaris.bitmath.org>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:39939 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1DEMQU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 08:16:20 -0400
Content-Disposition: inline
In-Reply-To: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Brown <jeffbrown@android.com>
Cc: dmitry.torokhov@gmail.com, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Brown <jeffbrown@google.com>

On Fri, Apr 01, 2011 at 11:54:16PM -0700, Jeff Brown wrote:
> From: Jeff Brown <jeffbrown@google.com>
> 
> Calculate a default based on the number of ABS axes, REL axes,
> and MT slots for the device during input device registration.
> 
> Signed-off-by: jeffbrown@android.com
> ---

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
