From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Sun, 6 May 2012 01:23:10 -0500
Message-ID: <20120506062309.GB26002@burratino>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar>
 <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49576 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2EFGXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 May 2012 02:23:23 -0400
Received: by obbtb18 with SMTP id tb18so6444663obb.19
        for <linux-input@vger.kernel.org>; Sat, 05 May 2012 23:23:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA6162F.1020408@osvaldobarrera.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Hugo Osvaldo Barrera wrote:
> On 2012-05-06 02:55, Jonathan Nieder wrote:

>> The pairing (...add_djhid_device) happens during initialization,
>> before the mouse is turned on...
>
> I don't think I quite follow there.  By "pairing" I though you meant
> when the receiver connects to the mouse.  How can the pairing be done
> while the device is off?  Or what am I missing here?

I'm guessing the actual pairing happens without Linux being involved.
Then the driver sends a "get paired devices" request during
initialization and the device sends the "device paired" notifications
I'm interested in in response.

> Do I need to apply only this patch, or both the previous one and this one?

Only this patch.

Cheers,
Jonathan
