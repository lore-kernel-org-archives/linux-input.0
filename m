From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] HID: hid-logitech-dj: add some range checks
Date: Tue, 5 Mar 2013 20:45:35 +0300
Message-ID: <20130305174535.GD9189@mwanda>
References: <20130305130626.GA17801@longonot.mountain>
 <CAN+gG=E_b3ydgPpt1c0-5Z6Ktkzw1bN7Kro=WUC7UmJenPAfMg@mail.gmail.com>
 <CAE7qMrouxdpjtBRpTUjKBdiAr-wwhy8x3M23Q_twP+kkTFFALA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30650 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab3CERqj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Mar 2013 12:46:39 -0500
Content-Disposition: inline
In-Reply-To: <CAE7qMrouxdpjtBRpTUjKBdiAr-wwhy8x3M23Q_twP+kkTFFALA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Tue, Mar 05, 2013 at 05:34:08PM +0100, Nestor Lopez Casado wrote:
> > If you want to add a check, it need to be in logi_dj_recv_forward_report().
> > The current access to djrcv_dev->paired_dj_devices[] in
> > delayedwork_callback() has been removed in latest HID tree:
> > https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-3.10/logitech
> The test could be added there. It would be quite defensive though, as
> we should always get the right device indexes.


Ah...  I appologize for the noise.  I misunderstood how
hid_input_report() works.  I thought it could be called with user
supplied parameters.

Never mind.

regards,
dan carpenter

