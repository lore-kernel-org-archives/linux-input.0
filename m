From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH v2 3/4] input: evdev: Indicate buffer overrun with SYN_DROPPED.
Date: Mon, 4 Apr 2011 14:52:19 -0700
Message-ID: <BANLkTineFm2WvtHi6pL6f3UOhPcpiRdKQA@mail.gmail.com>
References: <1301727259-5185-1-git-send-email-jeffbrown@android.com>
 <1301727259-5185-3-git-send-email-jeffbrown@android.com> <20110404213338.GB984@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43026 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1DDVxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 17:53:00 -0400
In-Reply-To: <20110404213338.GB984@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, djkurtz@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Apr 4, 2011 at 2:33 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Apr 01, 2011 at 11:54:18PM -0700, Jeff Brown wrote:
>> + =A0 =A0 =A0* When the client buffer is full, drain the buffer and =
enqueue a
>> + =A0 =A0 =A0* SYN_DROPPED event to let the client know that events =
were dropped
>> + =A0 =A0 =A0* and the last packet was incomplete. =A0We then consum=
e all remaining
>> + =A0 =A0 =A0* events from the dropped packet until the next packet =
begins.
>
> I do not think we (kernel) should be doing this. Clients should take
> care and not allow overruns but if they happen the pain should be on =
the
> client to restore the context. It has to query the device to get its
> current state and it can drop the events till next sync as well.

That's fine.  We should document SYN_DROPPED and mention that the
client should wait until after the next SYN_REPORT to get back in
sync.

> Therefore I intend to apply the patch in the form below.

Looks good to me.  It's more like my original patch.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
