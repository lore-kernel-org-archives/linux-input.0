From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hidraw: fix power sequence when closing device
Date: Mon, 2 Oct 2017 11:46:44 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021146341.17517@jbgna.fhfr.qr>
References: <20170920013746.GA33367@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751070AbdJBJqq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 05:46:46 -0400
In-Reply-To: <20170920013746.GA33367@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Oliver Neukum <oneukum@suse.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 19 Sep 2017, Dmitry Torokhov wrote:

> We should not try to bring HID device out of full power state before
> calling hid_hw_close(), so that transport driver operates on powered up
> device (making this inverse of the opening sequence).
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to for-4.14/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

