From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Make Dell keyboard repeat quirk apply to a wider range
	of hardware
Date: Fri, 15 Aug 2008 15:04:44 -0400
Message-ID: <20080815150420.ZZRA012@mailhub.coreip.homeip.net>
References: <20080814033255.GA21721@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:40570 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758030AbYHOTEr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 15:04:47 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1164508wri.5
        for <linux-input@vger.kernel.org>; Fri, 15 Aug 2008 12:04:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080814033255.GA21721@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 14, 2008 at 04:32:55AM +0100, Matthew Garrett wrote:
> Dell laptops fail to send key up events for several of their special 
> keys. There's an existing quirk in the kernel to handle this, but it's 
> limited to the Latitude range. This patch extends it to cover all 
> portable Dells.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> 

Applied to 'next', thank you Matthew.

-- 
Dmitry
