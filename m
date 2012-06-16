From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Sat, 16 Jun 2012 14:44:30 +0200
Message-ID: <CANq1E4QmXjmDEPiGAuN7vq5u8=YS30s4RtZgP=PX0E7YtfD44Q@mail.gmail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMZwxu0uf_YeXt_TnokxeCGUfAAjV7jkgGs37b5Kp3cEmg@mail.gmail.com>
	<CANq1E4SCbURdH+fhoMinTz_R0SN_Y4PEPST5jNZSN6czt=q+DQ@mail.gmail.com>
	<CAAngNMa3GMqrgZUrx=XqaRWfK2MaFMewK6OEQU_=4oPj1FOMNw@mail.gmail.com>
	<CAAngNMYehtuW5405+U7Kkw+dyCFDT0t08gteTDfxH-gbK0Zhug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37899 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2FPMoc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jun 2012 08:44:32 -0400
Received: by wibhn6 with SMTP id hn6so438831wib.1
        for <linux-input@vger.kernel.org>; Sat, 16 Jun 2012 05:44:31 -0700 (PDT)
In-Reply-To: <CAAngNMYehtuW5405+U7Kkw+dyCFDT0t08gteTDfxH-gbK0Zhug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Joao

On Fri, Jun 15, 2012 at 12:05 AM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Mon, Jun 11, 2012 at 11:40 PM, Joao Paulo Rechi Vita
> (sorry, I forgot to cc the list on the original response)
>
> I've tested this new version split in several patches. Input reports
> support works fine, but the event_type value is still broken. This is
> a minor issue IMO, since it just affects output and feature reports
> support, which is not completed implemented in the userspace side of
> HoG yet. I don't see a problem in having the series integrated
> upstream and we fix this problem later on.

I tested the full patchset again to be sure and it works fine here.
Can you describe your problem in more detail? You applied the full
patchset, right? And all the events work except the FEATURE request?
What isn't working exactly here? Do you never receive the feature
request? What does the "type" field say exactly? What do you expect it
to report? Please describe the whole test-case you run as I cannot
follow.

Regards
David

> --
> Jo=E3o Paulo Rechi Vita
> Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
