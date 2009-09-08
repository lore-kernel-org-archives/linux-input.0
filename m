From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Wed, 9 Sep 2009 00:43:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>  <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de>  <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>  <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
 <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-735595320-1252449827=:23856"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45124 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbZIHWnp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Sep 2009 18:43:45 -0400
In-Reply-To: <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergey Kolesnikov <rockingdemon@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tim Cole <tim.cole@canonical.com>, Tim Gardner <tim.gardner@canonical.com>, Amit Kucheria <amit.kucheria@canonical.com>, Stefan Bader <stefan.bader@canonical.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-735595320-1252449827=:23856
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 9 Sep 2009, Sergey Kolesnikov wrote:

> Yes, reverting this commit helps. I've tried jstest and succeeded to 
> change the state of each available button/axis.

Thanks for verifying.

> May be there is another way to distinguish between such joysticks and 
> digitizers?  

Well, first I'll need the report descriptor dump (i.e. the HID debugging 
output, see one of the previous mails), to see how the device is 
presenting itself to the system. And then possibly fix the input mapping 
in HID code, so that we don't infringe on mappings of different device 
classes.

-- 
Jiri Kosina
SUSE Labs
--168427776-735595320-1252449827=:23856--
