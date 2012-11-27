From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory
 allocation failure
Date: Tue, 27 Nov 2012 10:55:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211271053450.15521@pobox.suse.cz>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org> <alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz> <20121126180530.GE14623@core.coreip.homeip.net> <alpine.LNX.2.00.1211262308230.15521@pobox.suse.cz>
 <CAK9yfHxRAqau-Xj6uSjjoy0zxLf=47rN0LcLEPKrPvHJ0P8DiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36573 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758349Ab2K0Jzt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 04:55:49 -0500
In-Reply-To: <CAK9yfHxRAqau-Xj6uSjjoy0zxLf=47rN0LcLEPKrPvHJ0P8DiA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, jic23@kernel.org, patches@linaro.org

On Tue, 27 Nov 2012, Sachin Kamat wrote:

> > Fully agree with you.
> >
> > But I'd like to have both sides changed together once someone starts
> > taking care of fixing it.
> 
> The proposed change is done in the function hiddev_connect which
> returns 0 on success.
> The caller only checks if the return value is 0 or not
> (!hdev->hiddev_connect(...)). In this case
> what is the change that you would like to see on the caller side?

A check whether the value returned by hiddev_connect() is error code 
(through IS_ERR_VALUE() or something similar), and continue propagating 
the error out of hid_connect().

-- 
Jiri Kosina
SUSE Labs
