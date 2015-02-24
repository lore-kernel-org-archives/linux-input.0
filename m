From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Wed, 25 Feb 2015 07:45:48 +1000
Message-ID: <20150224214548.GA6969@jelly.redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
 <54E45A82.7090706@gmail.com>
 <20150218200417.GC5928@mail.corp.redhat.com>
 <54E5CEE9.1050909@gmail.com>
 <20150220053458.GA23069@jelly.redhat.com>
 <54E9CCB1.9000705@gmail.com>
 <20150222232817.GA1645@jelly.redhat.com>
 <20150223223453.GA28675@mail.corp.redhat.com>
 <54EC5EFD.5040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:47974 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbBXVqM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 16:46:12 -0500
Content-Disposition: inline
In-Reply-To: <54EC5EFD.5040505@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Tue, Feb 24, 2015 at 01:22:37PM +0200, Nikolai Kondrashov wrote:
> On 02/24/2015 12:34 AM, Benjamin Tissoires wrote:
> >On Feb 23 2015 or thereabouts, Peter Hutterer wrote:
> >>yeah, but the thing is: those emails are only necessary _once_  per tablet.
> >>if they're not in the database, you'll get those questions for the lifetime
> >>of the tablet :)
> >>
> >>Also note that libwacom_new_from_path() has a fallback option, you can get a
> >>generic tablet from it and then proceed as normal. gnome-settings-daemon
> >>already uses this.
> >>
> >
> >I also expects that the settings configuration tool under wayland will
> >rely on the actual capability of the devices. This way, even if the
> >tablet is not registered in libwacom, we will still be able to show a
> >default configuration UI.
> >
> >I really believe the registering in libwacom will be just to have a
> >prettier interface, not a requirement.
> 
> Well, that sounds awesome! Just what I was looking for :)
> 
> What about X.org though? Last time I tried I couldn't configure a
> Wacom-handled Huion with the Gnome applet.

hard to say, settings-daemon/control-center use the xorg wacom driver
properties, so in theory it should work. Best to file a gnome bug for it
and CC me on it, there's no obvious definitive answer I can think of right
now.

Cheers,
   Peter
