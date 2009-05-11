From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] autocentering support for Logitech Force 3D Pro
Date: Mon, 11 May 2009 17:08:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111705540.22712@wotan.suse.de>
References: <bb829a0b0905081244j36d069bfre73eba5d170494b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-1480924963-1242054492=:22712"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42785 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbZEKPIM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 11:08:12 -0400
In-Reply-To: <bb829a0b0905081244j36d069bfre73eba5d170494b3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?KOI8-R?B?88XSx8XKIOLFzNHbz9c=?= <sergey.belyashov@gmail.com>
Cc: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-1480924963-1242054492=:22712
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 8 May 2009, ?????? ??????? wrote:

> >   I am ready to create autocenter support patch for Logitech Force 3D
> > Pro (046d:c286). But all tested by me Logitech Joysticks with FF has
> > support for autocentering in same way. May be it is good idea to add
> > this feature for all joysticks in hid-lgff.c? If some joystick do not
> > support it (users reported), then it is possible to exclude
> > autocentering for this joystick later.

The standard doesn't mandate anything, as far as I know. Also, we know how 
creative HID vendors are when braking all kinds of 
specifications/reasonable expectations.

So I'd propose to go with enabling the feature only for those joysticks 
for which it is verified to work.

Therefore, I would propose merging your patch no. 1, if you agree.

Thanks,

-- 
Jiri Kosina
SUSE Labs
--168427776-1480924963-1242054492=:22712--
