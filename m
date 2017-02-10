From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Fix for out of range for THT 2p arcade controller
Date: Fri, 10 Feb 2017 03:05:55 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702100304250.24579@cbobk.fhfr.pm>
References: <CAJRvzP98MyLzm5OZgUm6zVWFFVtwr2fe42FxY8UMeAQwyARmcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbdBJCZH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Feb 2017 21:25:07 -0500
In-Reply-To: <CAJRvzP98MyLzm5OZgUm6zVWFFVtwr2fe42FxY8UMeAQwyARmcw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stein <peter@stuntstein.dk>
Cc: linux-input@vger.kernel.org

On Thu, 9 Feb 2017, Peter Stein wrote:

> There is a new clone of the XIN MO arcade controller which has same issue
> with out of range like the original.
> This fix will solve the issue where 2 directions on the joystick are not
> recognized by the new THT 2P arcade controller with device ID 0x75e1.
> In details the new device ID is added the hid-id list and the hid-xinmo
> source code.
> 
> Signed-off-by: Peter Stein <peter@stuntstein.dk>

Peter,

thanks for the patch. Unfortunately your mail client completely corrupted 
the formatting (line breaks, whitespaces, ...). Could you please fix that 
up and resend?

-- 
Jiri Kosina
SUSE Labs

