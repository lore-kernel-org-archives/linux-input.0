From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Subject: Re: Handling macros with input devices
Date: Wed, 14 Apr 2010 13:08:40 -0600
Message-ID: <858c533f3330c7d6804eaf1162c71a03.squirrel@intranet.cs.nmsu.edu>
References: <054d04d6a47f4ba368c8d75f8d8fb08f.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.cs.nmsu.edu ([128.123.64.3]:41052 "EHLO mail.cs.nmsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab0DNTcZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 15:32:25 -0400
In-Reply-To: <054d04d6a47f4ba368c8d75f8d8fb08f.squirrel@intranet.cs.nmsu.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-input@vger.kernel.org

One of the sticking points I have with the G13 driver is that I'd like it
to have support for macros. The reason I'd like to support macros is that
the G13's raison d'etre is to allow the end user to customize the device
with their own macros.

However, I've been looking around and I can't find any support for macros
within the kernel.

In particular, I have support for getkeycode and setkeycode ioctl's. I was
thinking of supporting at least setkeycode to allow a standard way to set
a one key macro. Supporting getkeycode and setting keybit are more
problematic.

If someone has already brought this issue up I apologize, but I couldn't
find any discussion on the linux-input list relating to macros (at least
other than preprocessor macros).

Any suggestions?

-- 

Rick


