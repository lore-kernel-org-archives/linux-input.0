From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ELAN1000 not working on Asus Zenbook UX305CA-EHM1
Date: Fri, 20 Nov 2015 09:34:52 -0800
Message-ID: <20151120173452.GB26895@dtor-ws>
References: <CAN+gG=EHEtTyWUQsYJ6HDMr-O_D6XVYWoWkMTS9wqeL2TDZLnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35863 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760851AbbKTRez (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 12:34:55 -0500
Received: by pacdm15 with SMTP id dm15so122414637pac.3
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 09:34:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=EHEtTyWUQsYJ6HDMr-O_D6XVYWoWkMTS9wqeL2TDZLnw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Duson Lin <dusonlin@emc.com.tw>, linux-input <linux-input@vger.kernel.org>

On Fri, Nov 20, 2015 at 09:52:14AM +0100, Benjamin Tissoires wrote:
> Hi Duson,
> 
> A user reported a non working touchpad on his Asus Zenbook UX305CA.
> The touchpad is the ELAN1000 which has been added to v4.3:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1281990
> 
> In the logs, I see:
> 
> [   16.636101] i2c_designware i2c_designware.0:
> i2c_dw_handle_tx_abort: lost arbitration
> [   16.636110] elan_i2c i2c-ELAN1000:00: writing cmd (0x0005) failed: -11
> [   16.636113] elan_i2c i2c-ELAN1000:00: device reset failed: -11
> [   16.636115] elan_i2c i2c-ELAN1000:00: device initialize failed: -11
> 
> I wonder if you could have a look at this and tell us whether the
> touchpad is failing (I mean the driver) or if the i2c bus driver is at
> fault.

The designware controller reports that it lost arbitration, as if there
were 2 masters on the same I2c bus, which is unlikely. I'd be looking
into i2c bus driver first.

Thanks.

-- 
Dmitry
