From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: cp2112: fix to force single data-report reply
Date: Wed, 8 Jul 2015 12:41:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081240530.10183@pobox.suse.cz>
References: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com> <55939F3E.7070505@cumulusnetworks.com> <alpine.LNX.2.00.1507081115220.10183@pobox.suse.cz> <559CFA67.70301@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:33113 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbGHKlZ (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 8 Jul 2015 06:41:25 -0400
In-Reply-To: <559CFA67.70301@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Wed, 8 Jul 2015, Ellen Wang wrote:

> > > Works as described.  Thank you!
> > > 
> > > By the way, I tested the code with and without your fix on my rev 2 chip,
> > > and
> > > it behaved the same way as you describe on your rev 1 chip.
> > 
> > Ellen, are you okay with me applying the patch with
> > 
> > 	Tested-by: Ellen Wang <ellen@cumulusnetworks.com>
> > 
> > ?
> > 
> > Thanks,
> 
> Yes.  Thank you.

Ammended with Cc: stable tag, and applied to for-4.2/upstream-fixes. 
Thanks,

-- 
Jiri Kosina
SUSE Labs
