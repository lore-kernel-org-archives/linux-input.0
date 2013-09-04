From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Wed, 4 Sep 2013 15:41:00 +0000 (UTC)
Message-ID: <loom.20130904T174015-472@post.gmane.org>
References: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz> <521F0D5F.7040108@redhat.com> <CAGXu5jKkzWmMZeckmO6BeKnJs-AjrFuZvqWNxDa6Rjb7UzAeyw@mail.gmail.com> <CAN+gG=EvuO4R2d=bj=_9aWo1e96ee_i0sqSDJNd=3h+dVf=oWQ@mail.gmail.com> <CAGXu5jKAob5s1vs5s974QsJWdje2rQgyz=PVACxW3aWiJWiEEA@mail.gmail.com> <CAN+gG=Fx5bjcPndRSBBJTvZFC2GOegigkzL3De8iK7vauiPq1g@mail.gmail.com> <alpine.LNX.2.00.1309041155460.3684@pobox.suse.cz> <loom.20130904T165553-365@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48557 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935145Ab3IDPlX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 11:41:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1VHFCp-0007sE-4f
	for linux-input@vger.kernel.org; Wed, 04 Sep 2013 17:41:19 +0200
Received: from 24-247-107-235.dhcp.aldl.mi.charter.com ([24.247.107.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 17:41:19 +0200
Received: from jwboyer by 24-247-107-235.dhcp.aldl.mi.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 17:41:19 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Josh Boyer <jwboyer <at> fedoraproject.org> writes: 
> So we actually did pick up the entire 14 patch series in Fedora on top of
> 3.10.10 and 3.11 to fix the CVEs.  It's broken things for at least two
> users.  One person's touchpad is now detected as a mouse with the error:
> 
> Sep 04 16:25:14 HP6930p kernel: psmouse serio4: synaptics: 
>                   Unable to query device.

Ignore this part.  The synaptics issue was found to be unrelated.

> The other person reported
> https://bugzilla.redhat.com/show_bug.cgi?id=1003998 wherein they say these
> patches cause an ODEBUG backtrace and that the trackpoint on a USB keyboard
> doesn't work.

This is still an issue as far as we can tell.

josh

