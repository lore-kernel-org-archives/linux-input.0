From: simon@mungewell.org
Subject: Re: [RFC] [BUG?] Sixaxis Value Ranges
Date: Wed, 7 Sep 2011 14:58:58 -0400
Message-ID: <c863ec6b1479d2b7c79b8e5b318371db.squirrel@host171.canaca.com>
References: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
    <376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:42955 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1IGS7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 14:59:07 -0400
In-Reply-To: <376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: David Michael <fedora.dm0@gmail.com>, linux-input@vger.kernel.org


> You can look directly at the streaming HID bytes hex(although I can't
> remember how, someone here suggested a method a couple of months back) to
> confirm this.

from http://www.pabr.org/sixlinux/sixlinux.en.html#inop:

# hexdump -v -e '48/1 "%02x " "\n"' < /dev/hidraw1   # For kernels <  2.6.26
# hexdump -v -e '49/1 "%02x " "\n"' < /dev/hidraw1   # For kernels >= 2.6.26
00 00 00 00 00 74 7b 7c 7c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 02 ee 10 00 00 00 00 02 b2 77 01 81 02 05 01 ed 01 a4 00 02

Simon


