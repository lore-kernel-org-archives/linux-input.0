From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bcm5974: Switch back to normal mode when closing
Date: Sun, 14 Sep 2008 11:18:26 -0400
Message-ID: <20080914151824.GB5391@amd.corenet.prb>
References: <48CD25C3.8050008@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.245]:10674 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbYINPSf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2008 11:18:35 -0400
Received: by hs-out-0708.google.com with SMTP id 4so572447hsl.5
        for <linux-input@vger.kernel.org>; Sun, 14 Sep 2008 08:18:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48CD25C3.8050008@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Sun, Sep 14, 2008 at 04:54:59PM +0200, Henrik Rydberg wrote:
> Staying in multi-touch mode after closing the device sometimes makes the keyboard drop keys or
> repeat keys irratically. The conjecture is that some internal buffer starts to overflow,
> resulting in undefined behavior. Switching back to normal mode when closing the device makes the
> problem go away.
> 

Makes sense, will apply.

-- 
Dmitry
