From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Is it possible to debounce button events?
Date: Tue, 23 Jul 2013 05:38:25 +1000
Message-ID: <20130723053825.7b6b37a7@korath.teln.shikadi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab3GVTkE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jul 2013 15:40:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1V1Lxj-0006m6-B2
	for linux-input@vger.kernel.org; Mon, 22 Jul 2013 21:40:03 +0200
Received: from 124-171-210-100.dyn.iinet.net.au ([124.171.210.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 22 Jul 2013 21:40:03 +0200
Received: from a.nielsen by 124-171-210-100.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 22 Jul 2013 21:40:03 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

In every mouse I have ever owned, as it ages the buttons become less
and less reliable.  Usually this means it starts to send multiple
button press events each time the button is clicked.  The Logitech
mouse I am currently using is now producing double-clicks about 10% of
the time when I only press the left button once.

Rather than replace an otherwise perfectly working device, or
disassemble and clean the switches (again), I am wondering whether
there is any sort of debounce option in the input subsystem.

I am looking for some setting where I can tell the input subsystem to
ignore button-press/release events if they occur within a configurable
amount of time after the initial event, e.g. 10 milliseconds.

This would be quick enough that it would not interfere with intentional
double-clicks, but unintentional double-clicks would be eliminated.

It looks like a few input drivers internally implement debouncing, so
I'm wondering whether there is a generic mechanism that can be used for
any button on any input device?

Many thanks,
Adam.


