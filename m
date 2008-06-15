From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: serial touchscreen and inputattach
Date: Sun, 15 Jun 2008 21:57:40 +0200
Message-ID: <87zlpmo4i3.fsf@macbook.be.48ers.dk>
References: <200806152101.10156.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:13558 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYFOT5o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jun 2008 15:57:44 -0400
Received: by ug-out-1314.google.com with SMTP id h2so294782ugf.16
        for <linux-input@vger.kernel.org>; Sun, 15 Jun 2008 12:57:42 -0700 (PDT)
In-Reply-To: <200806152101.10156.markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\, 15 Jun 2008 21\:01\:09 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: markus.heidelberg@web.de
Cc: linux-input@vger.kernel.org

>>>>> "Markus" == Markus Heidelberg <markus.heidelberg@web.de> writes:

Hi,

 Markus> Is there an official version of inputattach? I found
 Markus> different sources. The last change at [1] is about 2 years
 Markus> ago. At [2] there is a broken CVS link to [1]. The
 Markus> inputattach tool in buildroot's tslib package is derived from
 Markus> [1] with some minor changes. The inputattach from Debian's
 Markus> joystick package is derived from a three years old version of
 Markus> [1], the tool from Gentoo's joystick package is the same as
 Markus> in [1].

In buildroot we actually also have the Debian version
(package/input-tools) to add to the confusion ;)

-- 
Bye, Peter Korsgaard
