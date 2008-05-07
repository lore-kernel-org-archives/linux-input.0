From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] xpad - Allow mapping D-pad to buttons for all pads
Date: Wed, 7 May 2008 11:19:35 -0400
Message-ID: <20080507111713.ZZRA012@mailhub.coreip.homeip.net>
References: <20080505103400.284050@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:30897 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbYEGPTk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 11:19:40 -0400
Received: by wr-out-0506.google.com with SMTP id c48so136453wra.1
        for <linux-input@vger.kernel.org>; Wed, 07 May 2008 08:19:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080505103400.284050@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Gruber <backup.mg@gmx.de>
Cc: linux-input@vger.kernel.org

Hi Michael,

On Mon, May 05, 2008 at 12:34:00PM +0200, Michael Gruber wrote:
> From: Michael Gruber <lists.mg@googlemail.com>
> 
> If the new module option force_dpad_to_buttons is set, the directional pad will
> be mapped to 4buttons instead of 2axes for all controllers. This includes those
> in the list of known controllers which are not affected by the existing option
> dpad_to_buttons.
>

The option was there to adapt mappings for the new controllers we
don'ty know about yet. Coudl you explain why one would want to map
axes to buttons on a controller that is known to be not a d-pad?

Thanks!

-- 
Dmitry
