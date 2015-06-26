From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: wacom: NULL dereferences on error in probe()
Date: Fri, 26 Jun 2015 14:08:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506261408070.10183@pobox.suse.cz>
References: <20150624142743.GA1702@mwanda> <558C6BA5.8040905@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <558C6BA5.8040905@gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 25 Jun 2015, Jason Gerecke wrote:

> > Fixes: 2a6cdbdd4cc0 ('HID: wacom: Introduce new 'touch_input' device')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Looks reasonable to me.
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.2/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
