From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [patch] HID: roccat: silence an uninitialized variable warning
Date: Mon, 4 Apr 2016 09:50:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604040949540.16158@cbobk.fhfr.pm>
References: <20160402044432.GA11775@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51600 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcDDHuE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2016 03:50:04 -0400
In-Reply-To: <20160402044432.GA11775@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, 2 Apr 2016, Dan Carpenter wrote:

> My static checker complains because we use "dev_id" before we check for
> errors so it could be uninitialized.  Fix this by moving the error
> handling forward a couple lines.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

