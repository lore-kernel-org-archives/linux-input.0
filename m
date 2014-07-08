From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/2] synaptics_usb trackpoint cursor movement improvements
Date: Tue, 08 Jul 2014 14:43:41 +0200
Message-ID: <87ha2sc96q.fsf@rasmusvillemoes.dk>
References: <20130915160134.cd2eb260d8a5703a78ebfe84@dson.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:48147 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbaGHMnq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jul 2014 08:43:46 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so3962783lan.30
        for <linux-input@vger.kernel.org>; Tue, 08 Jul 2014 05:43:44 -0700 (PDT)
In-Reply-To: <20130915160134.cd2eb260d8a5703a78ebfe84@dson.org> (Andrew
	Deason's message of "Sun, 15 Sep 2013 16:01:34 -0500")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Deason <adeason@dson.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Andrew Deason <adeason@dson.org> writes:

> Also, I've been testing these changes with my own devices just by
> myself; I would welcome feedback from others with similar devices if any
> of them see this. It's difficult to objectively test how the trackpoint
> "feel"s with different parameters.

Hi Andrew,

I ran into the same issue after upgrading to Ubuntu 14.04 (with kernel
3.13); found <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=682413>,
and now finally got around to compile a kernel with your patches [1],[2]
applied. I can confirm that the "feel" of the trackpoint is back to
normal.

Also, the various workarounds mentioned at
http://unix.stackexchange.com/questions/43430 do not work nearly as good
(and of course, it would be much better if the trackpoint "just worked").

[0] http://thread.gmane.org/gmane.linux.kernel.input/31934
[1] http://thread.gmane.org/gmane.linux.kernel.input/31935
[2] http://thread.gmane.org/gmane.linux.kernel.input/31936

I have no idea whether those patches are the "right" fix, but FWIW, you
can add 'Tested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>'.

Thanks,
Rasmus
