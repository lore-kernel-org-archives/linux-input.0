From: simon@mungewell.org
Subject: Re: [RFC] [BUG?] Sixaxis Value Ranges
Date: Wed, 7 Sep 2011 14:48:32 -0400
Message-ID: <376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
References: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58302 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1IGSsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 14:48:38 -0400
In-Reply-To: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Michael <fedora.dm0@gmail.com>
Cc: linux-input@vger.kernel.org

> The sixaxis accelerometers/gyroscope from the joystick interface use a
> "flat" value that causes an input range of length ~128 of 1024 to be
> mapped to zero.

> Thanks for any suggestions on the issue.

Hi David,
Are you sure that the dead zone is being applied in the device itself, and
not by the '/dev/input/js0' system?

You can look directly at the streaming HID bytes hex(although I can't
remember how, someone here suggested a method a couple of months back) to
confirm this.

You could also try to completely disable the 'dead zone' on the joystick
sub-system.
Simon

