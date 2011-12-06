From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Tue, 6 Dec 2011 09:56:35 +0000
Message-ID: <CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com>
References: <4EC75224.7070207@goop.org>
	<alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	<4EC820F8.4070900@goop.org>
	<alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	<4ECA7E7D.80207@goop.org>
	<alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	<4ECAE019.4000409@goop.org>
	<alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	<4ECCB38A.8000503@goop.org>
	<alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
	<CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
	<4ED90E6D.8090402@goop.org>
	<CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
	<4ED9BDF8.3010600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33765 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093Ab1LFJ4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2011 04:56:36 -0500
Received: by eaak14 with SMTP id k14so4903525eaa.19
        for <linux-input@vger.kernel.org>; Tue, 06 Dec 2011 01:56:35 -0800 (PST)
In-Reply-To: <4ED9BDF8.3010600@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>

On 3 December 2011 06:13, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> The only functional change I made from Daniel's patch is keeping the power_supply type as BATTERY rather
> than USB.

How is upower supposed to know that the device is:

a) a mouse
b) not powering the computer

Any ideas welcome. I suppose we could look at the hid device, but this
seems like a hack. Thanks.

Richard.
