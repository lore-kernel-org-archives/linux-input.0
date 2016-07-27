From: Jiri Kosina <jikos@kernel.org>
Subject: RE: [PATCH] Improve Alps HID Touchpad code
Date: Wed, 27 Jul 2016 16:12:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607271611050.24757@cbobk.fhfr.pm>
References: <1466568668-22272-1-git-send-email-masaki.ota@jp.alps.com> <20160623001101.GE16965@dtor-ws> <alpine.LNX.2.00.1606230858230.6874@cbobk.fhfr.pm> <OSXPR01MB040858DA208EB99E5AC3CBB2C70A0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42304 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbcG0OMN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2016 10:12:13 -0400
In-Reply-To: <OSXPR01MB040858DA208EB99E5AC3CBB2C70A0@OSXPR01MB0408.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Naoki Saito <naoki.saito@jp.alps.com>

On Fri, 22 Jul 2016, Masaki Ota wrote:

> Hi, Jiri,
> 
> Good day.
> 
> Dell is asking me about this Alps modification's "commit id".
> Do you know about it?

The patches are queued in hid.git repository for 4.8. You can see them 
here:

	https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-4.8/alps

The branch is not rebasing, so the commit ids will be the same once it 
hits Linus' tree.

-- 
Jiri Kosina
SUSE Labs

