From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Thu, 3 May 2012 08:08:39 -0500
Message-ID: <20120503130821.GB16978@burratino>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38641 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab2ECNJA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 May 2012 09:09:00 -0400
Received: by obbtb18 with SMTP id tb18so2459446obb.19
        for <linux-input@vger.kernel.org>; Thu, 03 May 2012 06:08:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Nestor Lopez Casado wrote:

> Thanks for reporting this issue. This is not a known problem.
>
> It does point to an endianess issue.

Good to know.  Thanks for a quick reply.

> As I do not have readily available PowerPC HW and we have some urgent
> things to work on right now: Would it be possible if you help us by doing
> the same tests, but enabling the debug log on hid ?

Hugo: please attach full output from "dmesg" after running

	modprobe -r hid-logitech-dj
	modprobe -r usbhid
	echo 1 >/sys/module/hid/parameters/debug
	modprobe usbhid
	modprobe hid-logitech-dj

An alternative method would be to boot with "hid.hid_debug=1
log_buf_len=2097152" and run dmesg.

Hope that helps,
Jonathan
