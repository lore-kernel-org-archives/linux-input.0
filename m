From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch unification
Date: Fri, 7 Jan 2011 20:12:21 +0100
Message-ID: <AANLkTikxWv+zn1MdXAGFSZU=hNfF4OHnK7pCk6DgdKSg@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52089 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab1AGTMW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 14:12:22 -0500
In-Reply-To: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

I forgot to mention that I keep the flag RFC as I'm waiting for more
tests in the begining of the next week (only Cypress has been tested
with the last release).

Cheers,
Benjamin

On Fri, Jan 7, 2011 at 7:42 PM, Benjamin Tissoires
<benjamin.tissoires@enac.fr> wrote:
> Hi,
>
> here is the v3.
>
> all changes are coming from the mails with Henrik:
>
> - restricted to new drivers only
> - delete mt_buffer struct
> - replace/adapt prev_valid in favor of seen_in_this_frame
> - integrated fuzz
> - introduce MT_QUIRKS
> - other small fixes
>
> Cheers,
> Benjamin
>
>
