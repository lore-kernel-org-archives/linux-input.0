From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/4] tty/vt/keyboard: reset the LEDs state at each
 console change
Date: Fri, 27 Jan 2017 19:18:11 +0100
Message-ID: <20170127181810.GH13244@mail.corp.redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127171318.2596-4-benjamin.tissoires@redhat.com>
 <20170127173150.GZ9511@var.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932519AbdA0SSR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 13:18:17 -0500
Content-Disposition: inline
In-Reply-To: <20170127173150.GZ9511@var.bordeaux.inria.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jan 27 2017 or thereabouts, Samuel Thibault wrote:
> Hello,
> 
> Benjamin Tissoires, on Fri 27 Jan 2017 18:13:17 +0100, wrote:
> > When switching back from Gnome, the VT is not aware of the
> > current state of the LEDs. So if Gnome changes them, the
> > kernel still bellieves they are off, and it won't turn them
> > off when switching to a new TTY.
> 
> I'm not getting that issue, please detail which graphical stack you are
> using (Xorg/Wayland? input-libinput?)

Well, libinput won't have anything to do here, and the issue applies on
Gnome and gdm with both Xorg and Wayland. Given that you don't have the
issue, I had a feeling that it might be logind interfering (given that
it revokes the input file descriptor). So I tested a startx from root,
and indeed the issue is not present in that case.

I'll check with the systemd guys if this is something that comes from
them and if this can be fixable.

Cheers,
Benjamin

> 
> Samuel
