From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] hid: avoid '\0' in hid debugfs events file
Date: Tue, 16 Mar 2010 18:35:18 +0100
Message-ID: <20100316183518.3b631b73@neptune.home>
References: <20100315190027.752c82ea@neptune.home>
	<alpine.LNX.2.00.1003161354380.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:34720 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938018Ab0CPRgB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Mar 2010 13:36:01 -0400
In-Reply-To: <alpine.LNX.2.00.1003161354380.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 16 March 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 15 Mar 2010, Bruno Pr=C3=A9mont wrote:
> > The ring buffer overflow case (when tail crosses head) seems to be
> > suboptimal at best.
> > Would there be a good way to mark those cases so reader can know wh=
ere
> > data got lost. (though this might not be easy keeping the lockless
> > design)
>=20
> I agree that there might be better implementation. The circular buffe=
r is=20
> merely the same to what we use in other userspace interfaces already =
(see=20
> original hiddev, for example). Plus this is only debugging interface,=
 and=20
> with SIZE being 512, it's very unlikely that events will get lost.

Well, 512 is not that large, considering that a single event may well
fill half of it (e.g. 64byte HID event * 3 for hex dump, adding decoded
event to it). For basic keyboard events it's definitely sufficient.

In my case I was seeing overflow with outbound reports I dumped there
too, where it's pretty common to have more than a single report sent
back to device in a row.
Sure it's just an aid for debugging so loosing data is not an issue,
just having a hard time to understand output when things got lost would
be nice to avoid.

> But I don't think the lockless design is that important here, so if y=
ou=20
> are motivated to rewrite it to something better, I wouldn't object.

The easy way to keep output consistent would be to stop appending new
data when the ring buffer is full. (and maybe adding a single '\0' or
equivalent just before head if more data has to be written than space i=
s
available so there is an overflow marker).
This way reader would not risk reading old data a second time.

Dropping old data looks more complicated to get race-free or it would
have to be a bigger change (with new locking).


The optimal case would be to have a single ring-buffer implementation
for use by anyone needing it (I don't know if such one exists nor
how many ring-buffers are being used around the kernel)...
This is for a later time when I'm happy with my PicoLCD driver!

Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
