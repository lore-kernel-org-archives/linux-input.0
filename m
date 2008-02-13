From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid, 2.6.23 - add support for new macbook and apple
 aluminum keyboard "fn" key
Date: Wed, 13 Feb 2008 13:57:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802131355490.30955@jikos.suse.cz>
References: <fosskb$klp$1@ger.gmane.org> <Pine.LNX.4.64.0802122143280.7699@twin.jikos.cz>
 <47B2E614.5090001@twam.info>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-2119194919-1202907436=:30955"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40388 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751641AbYBMM5R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 07:57:17 -0500
In-Reply-To: <47B2E614.5090001@twam.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Cc: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-2119194919-1202907436=:30955
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 Feb 2008, Tobias M=FCller wrote:

> In 2.6.25 hidinput_apple_event is called in hidinput_event_quirks which=
=20
> is called by hidinput_hid_event. But if hidinput_event_quirks sent=20
> events, hidinput_hid_event doesn't know of this and send the events too!=
=20
> So if I press some keys on my keyboard, there are 2 keycodes sent.

Hi Tobias,

yes, this is a bug, for which I already have fix in my tree -- see=20
http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dcommit;h=3D68=
a1f2cc8676f22a6fd49f344f99e326eb7f5117

This restores the previous behavior. I just haven't pushed this to Linus=20
yet.

--=20
Jiri Kosina
SUSE Labs
--336216065-2119194919-1202907436=:30955--
