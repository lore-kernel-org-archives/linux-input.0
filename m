From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: fix masks for x and w_x data
Date: Fri, 16 May 2014 11:14:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405161114290.16459@pobox.suse.cz>
References: <1400187149-7619-1-git-send-email-aduggan@synaptics.com> <20140515211123.GA10497@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35329 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbaEPJOp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2014 05:14:45 -0400
In-Reply-To: <20140515211123.GA10497@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 15 May 2014, Benjamin Tissoires wrote:

> > The F11 data in the HID report contains four bits of data for w_x and the least significant bits
> > of x. Currently only the first three bits are being used which is resulting in small jumps in
> > the position data on the x axis and in the w_x data.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > ---
> 
> Good catch. I might have considered that 3:0 means 3 bits, not 4. I must
> have been tired while writing it :)
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
