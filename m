From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] i2c-hid: don't push static constants on stack for
 %*ph
Date: Mon, 5 Aug 2013 11:21:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308051121170.17512@pobox.suse.cz>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com> <CAN+gG=FQqAGV1ykq9RBzwkbp6vLAJwLP1L1y76NcyUP_iYZ6cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45186 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab3HEJVZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Aug 2013 05:21:25 -0400
In-Reply-To: <CAN+gG=FQqAGV1ykq9RBzwkbp6vLAJwLP1L1y76NcyUP_iYZ6cQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, 2 Aug 2013, Benjamin Tissoires wrote:

> <andriy.shevchenko@linux.intel.com> wrote:
> > There is no need to pass constants via stack. The width may be explicitly
> > specified in the format.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
