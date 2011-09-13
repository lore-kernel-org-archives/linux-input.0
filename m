From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] TSC-40: fix checkstyle issues
Date: Tue, 13 Sep 2011 09:37:22 -0700
Message-ID: <20110913163722.GB2915@core.coreip.homeip.net>
References: <CAH9NwWfEAag2+d_s3tbNyLV_oi23fTaeXtWvCm8-W+E69fxDcA@mail.gmail.com>
 <20110913084720.GB27776@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63104 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab1IMQh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 12:37:27 -0400
Received: by gyg10 with SMTP id 10so608793gyg.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 09:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110913084720.GB27776@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, linux-input@vger.kernel.org

On Tue, Sep 13, 2011 at 10:47:20AM +0200, Sebastian Andrzej Siewior wrote:
> * Christian Gmeiner | 2011-09-13 10:18:35 [+0200]:
> 
> >Subject: [PATCH 2/3] TSC40: fix checkstyle issues
> >
> >This patch fixes all found problems.
> 
> Besides the checkpatch fixes you also increased the msleep delay. For
> the checkpatch part it is probably better in include it in the previous
> patch unless Dmitry prefers something different. The same goes probably
> for the msleep part but pleae denote why this was required.

Yes, please fold the cleanup patches into the original patch.

Thanks.

-- 
Dmitry
