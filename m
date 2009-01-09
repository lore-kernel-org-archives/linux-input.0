From: "Nelson Castillo" <arhuaco@freaks-unidos.net>
Subject: [RFC] Touchscreen Filters in Kernel Space
Date: Fri, 9 Jan 2009 02:17:57 -0500
Message-ID: <2accc2ff0901082317k504c52baxc75be6fbda106fe2@mail.gmail.com>
Reply-To: arhuaco@freaks-unidos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17503 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZAIHR7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 02:17:59 -0500
Received: by qw-out-2122.google.com with SMTP id 3so8338800qwe.37
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2009 23:17:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input Mailing List <linux-input@vger.kernel.org>

Hello.

We have been working on a solution for a problem we have: lots of noise in the
touchscreen of the Openmoko Neo1973/FreeRunner.

Thanks to teamwork now we have a working solution that depends on the named
filters.

We are using a small touchscreen filtering framework in kernel
space for the S3C2410/S3C2442 touchscreen controllers. The filters can be used
by other drivers as well (we've noticed a few drivers include
averaging and some other
custom filters).

We do not want to port tslib to kernel space. The big difference is
that in tslib
you cannot give feedback to an interrupt handler. tslib does what it can, but
we have the power in kernel space to do better.

With the current implementation we try to get as many points as we need to in
order to provide a clean input event that does not need further
user-space mangling.
If we fail to get a valid point after some time we just ignore the
event. In our tests
this approach has been performing very well. Some of us think it would be nice
if a program can gather clean touchscreen data from /dev/inputX.

Here is a document that explains the filters with links to source code
that lives in our
GIT repository and some videos (the videos are not polished but they
illustrate what
we'd like to show).

https://wiki.openmoko.org/wiki/Touchscreen_Filters

We hope this work is suitable for mainline inclusion. if it is not, we
also hope to get some
feedback from the Linux input developers.

We will be waiting for your comments.

Thanks,
Nelson, on behalf of all who contributed to what is proposed in this email.
