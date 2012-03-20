From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH] HID: multitouch: add PID for Fructel product
Date: Tue, 20 Mar 2012 12:25:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203201225080.18356@pobox.suse.cz>
References: <1332168063-24812-1-git-send-email-eas@svep.se> <CAPHpN5Nn1JQtOQML8Y=2iL8Qy5SFjxMbf1uggNDVqoeeeegWCg@mail.gmail.com> <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35758 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab2CTLZc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 07:25:32 -0400
In-Reply-To: <884EB0E38721BD4797EDF5AE1D66333C03F4953A9533@Exchange-1.svep.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Nielsen <eas@svep.se>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@enac.fr" <benjamin.tissoires@enac.fr>, "chatty@enac.fr" <chatty@enac.fr>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Mon, 19 Mar 2012, Andreas Nielsen wrote:

> The multitouch events are emulated by the Gametel device. Each physical 
> button is configured to generate a MT event on a specific coordinate. 
> This seems to be the only way for us to support Android games that 
> doesn't support HID gamepads. It is possible to inject MT events at 
> Android level, but this requires the user to root their phone which 
> isn't realistic for our users.

Andreas,

I will be updating the Changelog message with this bit of explanation 
before comitting the patch, ok?

-- 
Jiri Kosina
SUSE Labs
