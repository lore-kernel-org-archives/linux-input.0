From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Thu, 3 May 2012 08:13:56 -0500
Message-ID: <20120503131356.GC16978@burratino>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120503130821.GB16978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43407 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2ECNOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 May 2012 09:14:14 -0400
Received: by yenm10 with SMTP id m10so1197764yen.19
        for <linux-input@vger.kernel.org>; Thu, 03 May 2012 06:14:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120503130821.GB16978@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Jonathan Nieder wrote:

> An alternative method would be to boot with "hid.hid_debug=1
> log_buf_len=2097152" and run dmesg.

Apparently I can't spell.  An alternative method would be to run with
"hid.debug=1 log_buf_len=..." or to do

	modprobe -r hid-logitech-dj
	modprobe -r usbhid
	modprobe -r hid
	modprobe hid debug=1
	modprobe hid-logitech-dj
	dmesg

Sorry for the confusion.
Jonathan
