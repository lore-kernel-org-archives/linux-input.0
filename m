From: Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH 2/2] input: Add a detailed multi-touch finger data
	report protocol (rev2)
Date: Tue, 06 Jan 2009 13:32:49 -0500
Message-ID: <1231266769.8379.79.camel@jg-vaio>
References: <495804B1.10300@euromail.se>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:60086
	"EHLO QMTA01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbZAFSdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2009 13:33:14 -0500
In-Reply-To: <495804B1.10300@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, jkosina@suse.cz, Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org

There is a remaining question: how/whether to implement this interface
in USB HID.....

On page 9 of the document you'll find at:
http://www.microsoft.com/whdc/device/input/DigitizerDrvs_touch.mspx

Microsoft is claiming in that document of December 8 they are proposing
the interfaces in the document to the USB IF organization, and that
hardware vendors for Windows 7 should follow that spec.

Jiri, Greg:

1) Does anyone know if Microsoft has actually made the proposal to the
USB IF?  Is there anyone in the community watching/commenting on USB IF
proposals?

2) do you want generic USB HID patches or do you want to, for now,
confine these to USB device specific drivers as much as possible?
                          - Jim

-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

