From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Wed, 4 Sep 2013 14:59:50 +0000 (UTC)
Message-ID: <loom.20130904T165553-365@post.gmane.org>
References: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz> <521F0D5F.7040108@redhat.com> <CAGXu5jKkzWmMZeckmO6BeKnJs-AjrFuZvqWNxDa6Rjb7UzAeyw@mail.gmail.com> <CAN+gG=EvuO4R2d=bj=_9aWo1e96ee_i0sqSDJNd=3h+dVf=oWQ@mail.gmail.com> <CAGXu5jKAob5s1vs5s974QsJWdje2rQgyz=PVACxW3aWiJWiEEA@mail.gmail.com> <CAN+gG=Fx5bjcPndRSBBJTvZFC2GOegigkzL3De8iK7vauiPq1g@mail.gmail.com> <alpine.LNX.2.00.1309041155460.3684@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53848 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934783Ab3IDPFE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 11:05:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1VHEdi-0006qs-QI
	for linux-input@vger.kernel.org; Wed, 04 Sep 2013 17:05:03 +0200
Received: from 24-247-107-235.dhcp.aldl.mi.charter.com ([24.247.107.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 17:05:02 +0200
Received: from jwboyer by 24-247-107-235.dhcp.aldl.mi.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 17:05:02 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Jiri Kosina <jkosina <at> suse.cz> writes:

> 
> On Mon, 2 Sep 2013, Benjamin Tissoires wrote:
> 
> > > Given the 12 flaws, what do you see as the best way forward?
> > 
> > If Jiri thinks we can wait one more week for some of these patches (I
> > know that the most critical one, 1/14 is already on its way to Linus),
> > then I can handle the v2, but not before Friday. Again, I think the
> > current patch series is perfectly fine for distributions as they can
> > add/remove things more easily than we can do in master.
> 
> I agree.
> 
> 1/14 will go to Linus shortly. The rest is public, and distributions are 
> taking it depending on their requirements, but I'd like to have the 
> patchset polished before pushing it to Linus.

So we actually did pick up the entire 14 patch series in Fedora on top of
3.10.10 and 3.11 to fix the CVEs.  It's broken things for at least two
users.  One person's touchpad is now detected as a mouse with the error:

Sep 04 16:25:14 HP6930p kernel: psmouse serio4: synaptics: 
                  Unable to query device.

The other person reported
https://bugzilla.redhat.com/show_bug.cgi?id=1003998 wherein they say these
patches cause an ODEBUG backtrace and that the trackpoint on a USB keyboard
doesn't work.

> Therefore putting the rest on hold now, and waiting for v2.

Ideas on exactly what might cause these issues would be good to know.

josh



