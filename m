From: Orivej Desh <orivej@gmx.fr>
Subject: Re: [PATCH] HID: gembird: add new driver to fix Gembird
 JPD-DualForce 2
Date: Wed, 12 Aug 2015 16:51:05 +0000
Message-ID: <20150812165105.3bfd4516@orivej.orivej.org>
References: <1439307348-5184-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150812013255.31ea3b7e@orivej.orivej.org>
	<20150812144028.GA31257@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:64672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116AbbHLQvU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Aug 2015 12:51:20 -0400
In-Reply-To: <20150812144028.GA31257@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

-linux-kernel@vger.kernel.org
-jkosina@suse.com

* Benjamin Tissoires
> Hmm... This was actually my first shot, and I noticed that the
> flickering original Z axis was now taking over the correct X axis. So
> that's why I added some complexity to ignore at the HID level this axis.
> I just forgot to update the comment :)

How did you notice that?  Is there a tool in hid-replay?  I did not test
my edition of the patch extensively because I did not expect such a
subtle difference.  Yet I did not observe flickering when joypad was
idle.

I assumed that the commit that hid Rx axis in 3.18 by calling
"map_abs_clear(usage->hid & 0xf);" effectively removed any influence of
repeated axes in report description, but now it seems I am wrong.  Would
you explain what it really did?

> If you think this patch is good enough (you will get flickering X), we
> can carry on this one, but I think the one I submitted (with the comment
> edited) would provide a better experience.

In this case I certainly prefer your original patch.
