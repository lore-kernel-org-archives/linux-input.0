From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] input: cyapa: fix the report events may lost issue
 during set power mode
Date: Thu, 14 Jan 2016 21:34:10 -0800
Message-ID: <20160115053410.GA21967@hudson.localdomain>
References: <1452750033-25692-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36595 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcAOFeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 00:34:11 -0500
Content-Disposition: inline
In-Reply-To: <1452750033-25692-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: dmitry.torokhov@gmail.com, eugenesan@gmail.com, bleung@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Thu, Jan 14, 2016 at 01:40:33PM +0800, Dudley Du wrote:
> When driver set the power mode to change the scan rate in auto suspend
> process, some events may be lost because
> 1) for gen3 trackpad, the driver must msleep() some time to avoid issuing
> next command encounter error;
> 2) for gen5 and later trackpads, the queue dumping function will simply
> ignore the events when waiting for the set power mode command response.
> so, when auto resume process will be executed, the set power mode command
> will be issued can cause the events may be lost.
> The solution is kept polling and report those valid events when the set
> power mode command is in progress.
> 
> TEST=test on Acer C720P Chromebook
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>
> ---
>  drivers/input/mouse/cyapa.c      |  22 ++++----
>  drivers/input/mouse/cyapa.h      |  14 ++++-
>  drivers/input/mouse/cyapa_gen3.c | 108 ++++++++++++++++++++++++++++-----------
>  drivers/input/mouse/cyapa_gen5.c |  99 +++++++++++++++++++++++++++++------
>  drivers/input/mouse/cyapa_gen6.c |   4 +-
>  5 files changed, 188 insertions(+), 59 deletions(-)
> 
[...]

I tested this on my Acer C720 and it appears to work properly.

Tested-by: Jeremiah Mahler <jmmahler@gmail.com>

-- 
- Jeremiah Mahler
