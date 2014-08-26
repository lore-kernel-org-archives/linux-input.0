From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: elantech: Correct the sign of the x/y
 movement for trackpoint
Date: Tue, 26 Aug 2014 15:45:22 -0700
Message-ID: <20140826224521.GA8377@core.coreip.homeip.net>
References: <20140824221424.GA15090@core.coreip.homeip.net>
 <1409081423-2259-1-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47221 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbaHZWp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 18:45:26 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so24432880pab.20
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 15:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409081423-2259-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

Hi Ulrik,

On Tue, Aug 26, 2014 at 09:30:23PM +0200, Ulrik De Bie wrote:
> Hi Dmitry,
> 
> Thank you for your feedback !
> 
> The x/y movement calculation was wrong, probably caused by my wrong
> documentation at the beginning of the elantech_report_trackpoint
> function.  When applying this patch to your patch, it works.

Thank you for testing and providing both the original patch and the
fixup. I folded everything together and applied, I'll try to get it in
3.17.

Thanks!

-- 
Dmitry
