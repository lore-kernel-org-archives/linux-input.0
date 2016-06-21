From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Mon, 20 Jun 2016 23:36:55 -0700
Message-ID: <20160621063655.GA26764@dtor-ws>
References: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com>
 <20160621033925.GB35864@dtor-ws>
 <OSXPR01MB0408A3C101E1D36D1F4FEC76C72B0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36792 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbcFUGit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 02:38:49 -0400
Received: by mail-pa0-f42.google.com with SMTP id wo6so3263657pac.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 23:36:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <OSXPR01MB0408A3C101E1D36D1F4FEC76C72B0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Masaki Ota <012nexus@gmail.com>, "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissorires@redhat.com" <benjamin.tissorires@redhat.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Naoki Saito <naoki.saito@jp.alps.com>

Hi Masaki,

On Tue, Jun 21, 2016 at 04:43:05AM +0000, Masaki Ota wrote:
> Hi, Dmitry,
> 
> > +struct u1_dev *priv;
> I do not understand why you need this global. You can allocate arbitrary memory in probe() and you actually already do that, why do you need second copy?
> 
> Yes, actually I don't want to use global, but I want to use it in alps_raw_event() for StickPointer.
> Do you have any idea?

What is wrong with using input2 pointer in hdata (provided you set it up
properly when probing the device)?

Thanks.

-- 
Dmitry
