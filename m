From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: kye: Add support for 3 tablets
Date: Mon, 27 Feb 2012 17:10:06 +0200
Message-ID: <CALu8Fe-eeikboG8EEhjhZXojycD_Wysyo9Vs59hfs94fZ2cCEw@mail.gmail.com>
References: <1329985774-4123-1-git-send-email-spbnick@gmail.com>
	<alpine.LNX.2.00.1202271549000.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34140 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab2B0PKH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Feb 2012 10:10:07 -0500
In-Reply-To: <alpine.LNX.2.00.1202271549000.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>

Hi Jiri,

On Mon, Feb 27, 2012 at 4:54 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> Would you strongly object to dropping all those you have added into
> various hid drivers already? I think the new rdesc + a few words of
> comment why we had to change the descriptor would be enough.

No, I wouldn't object. I think it will make the code clearer. There is some
value in having the original descriptors there, but not that much.

I think I'll post the original descriptors on the emerging DIGImend project
wiki instead.

> So I am not applying this patch now, and I'd like to ask you to respin it
> with the original rdesc comment removed and send a followup patch that
> does the substitution/removal in the other drivers.
>
> Sounds ok?

Sure.

I'll be sending a new version of this patch in about a day and later the
removal patch.

Thanks :)

Sincerely,
Nick
