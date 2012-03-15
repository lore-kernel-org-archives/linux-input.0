From: re06huxa@stud.informatik.uni-erlangen.de (Thorsten Wissmann)
Subject: Mixed "pen" and multitouch input devices
Date: Thu, 15 Mar 2012 16:52:35 +0100
Message-ID: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:64282 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031096Ab2COQDN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 12:03:13 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
Cc: Maximilian =?iso-8859-1?Q?Kr=FCger?= <maxfragg@gmail.com>

Hi,

we are working on already existing multitouch driver for a Promethean
ActivBoard, which supports both multiple fingers and pens. The pens
behave Wacom-like, i.e. the device actually can tell a cursor position
without a button action.

Because of the (up to 4) fingers, we use the input_mt_* functions. Is it
possible to just update the cursor position without a button action? (As
it is can be done with plain input_* functions?) Or do we have to create
two input devices? (one with multitouch input_mt_* and one for the pens?)

Information about our context: We took the partial working and GPL
licensed driver code out of /usr/src/ of [3] and enabled the multitouch
parts of it.

    Thorsten

[1] http://git.cs.fau.de/?p=re06huxa/promethean-activboard
[2] git clone git://git.cs.fau.de/re06huxa/promethean-activboard/
[3] http://activsoftware.co.uk/linux/repos/debian/pool/oss/a/activdriver/activdriver_5.7.23-2~debian~squeeze_amd64.deb

