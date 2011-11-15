From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Changing the settings of the device driver
Date: Tue, 15 Nov 2011 09:34:09 -0800
Message-ID: <20111115173409.GB15114@core.coreip.homeip.net>
References: <4EC29492.5030209@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50035 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825Ab1KOReO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:34:14 -0500
Received: by pzk36 with SMTP id 36so16153877pzk.1
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC29492.5030209@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

Hi Nuno,

On Tue, Nov 15, 2011 at 04:34:26PM +0000, Nuno Santos wrote:
> Hi,
> 
> I have been reading about linux kernel development and ioctl seems
> to be discouraged by kernel developers.
> 
> However ioctl is precisely what i'm looking for to mimic what I have
> in my Windows driver version.

Because Linux not Windows mimicking one platform's behavior on another
is usually not the best option. We actually discouraging driver- and
vendor-specific interfaces between kernel and userspace and striving
towards drivers (both kernel- and user-space) that are able to handle
multitude of devices from different vendors.

Maybe if you provided more details about your device (what it is
exactly, what the protocol is, what exact issues you are trying to
solve) people could direct you towards some of existing solutions.

Thanks.

-- 
Dmitry
