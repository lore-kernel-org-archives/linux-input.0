From: Todd Showalter <todd@electronjump.com>
Subject: Re: [PATCH 16/26] HID: wiimote: add Classic Controller extension
Date: Mon, 6 May 2013 10:15:52 -0400
Message-ID: <CAFmpkyiiXrh0O1cjXQb+58UyBPPPdaBnCiEHE0YTCtZEof4hQQ@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-17-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhX4vmavY8ZHh-ssLFbKrB_AhUa-kL+euuu+X+Yv2k6UA@mail.gmail.com>
	<CANq1E4TR5UXMWEMt3U1w=F7gUh=y0ed9JOqoNbHYf2dNfa8zRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44466 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3EFOPx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 10:15:53 -0400
Received: by mail-qa0-f46.google.com with SMTP id g10so1310882qah.5
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 07:15:52 -0700 (PDT)
In-Reply-To: <CANq1E4TR5UXMWEMt3U1w=F7gUh=y0ed9JOqoNbHYf2dNfa8zRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, May 6, 2013 at 1:40 AM, David Herrmann <dh.herrmann@gmail.com> wrote:

> I cannot change the mapping here, because it has to be
> backwards-compatible with the old classic-controller mapping.
> Libraries like "xwiimote" depend on it.
> This patch only converts the code into a "wiimod" extension module.

    Ok.  I'll deal with this case in the library, then.

                                          Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
