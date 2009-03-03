From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: Touchpad on Dell Latitude XT (alps 73 00 14)
Date: Tue, 03 Mar 2009 16:09:31 -0500
Message-ID: <49AD9C8B.1000009@seas.upenn.edu>
References: <4967E317.6040407@seas.upenn.edu> <20090111235407.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:51758 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZCCVUg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 16:20:36 -0500
Received: from [158.130.38.88] (SEASNet-38-079.seas.upenn.edu [158.130.38.88])
	(authenticated bits=0)
	by stag.seas.upenn.edu (8.13.6/8.13.6) with ESMTP id n23L9avn011817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 3 Mar 2009 16:09:37 -0500
In-Reply-To: <20090111235407.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

>> { { 0x73, 0x00, 0x14 }, 0xf8, 0xf8, 0 }
>>
>> How can I determine what values to use for those last three fields?
>>
> 
> f your touchpad works (you don't see any messages from psmouse in dmesg
> and every button works fine) then these are correct values.

I took another look at it and would appreciate a little more advice.

First off, it seems that regardless of which flags I use (except for
ALPS_PASS), the first byte is 0xff for all packets.  So those masks
don't seem to do anything useful for my device.

The touchpad does work fine.  And with ALPS_DUALPOINT, packet[5] always
comes out as 127.  However those 4 bytes in the middle act a little
weird.  It looks to me like they are just rotating as if the packet size
is incorrect.

[ 1325.709029] alps packet: ff 02 00 00 08 7f
[ 1325.722834] alps packet: ff 00 08 02 02 7f
[ 1325.737028] alps packet: ff 08 02 00 00 7f
[ 1325.760152] alps packet: ff 01 00 00 08 7f
[ 1325.773963] alps packet: ff 00 08 01 00 7f
[ 1325.824228] alps packet: ff 00 01 00 08 7f
[ 1325.838144] alps packet: ff 01 08 00 00 7f



Where do the first and last bytes come from?  Are they being sent by the
device, or added by a driver?

Any thoughts?

Rafi
