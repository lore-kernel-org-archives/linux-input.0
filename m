From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: roccat: prevent an out of bounds read in
 kovaplus_profile_activated()
Date: Tue, 23 Jan 2018 15:47:17 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231547100.11852@cbobk.fhfr.pm>
References: <20180110093903.yyoknoi7oc2cd5iy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180110093903.yyoknoi7oc2cd5iy@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 10 Jan 2018, Dan Carpenter wrote:

> We get the "new_profile_index" value from the mouse device when we're
> handling raw events.  Smatch taints it as untrusted data and complains
> that we need a bounds check.  This seems like a reasonable warning
> otherwise there is a small read beyond the end of the array.
> 
> Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

