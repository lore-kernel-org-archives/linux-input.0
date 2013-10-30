From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: logitech-dj: small cleanup in rdcat()
Date: Wed, 30 Oct 2013 14:45:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301444550.21144@pobox.suse.cz>
References: <20131019090859.GD9312@longonot.mountain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20131019090859.GD9312@longonot.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 19 Oct 2013, Dan Carpenter wrote:

> We could pass the "rdsec" pointer instead of the address of the "rdesc"
> and it's a little simpler.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Cosmetic change on a borderline of being justified to bother with :) 
Thanks Dan, applying now for 3.13.

-- 
Jiri Kosina
SUSE Labs
