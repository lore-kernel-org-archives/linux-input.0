From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 3/4] tty/vt/keyboard: reset the LEDs state at each
 console change
Date: Fri, 27 Jan 2017 18:31:50 +0100
Message-ID: <20170127173150.GZ9511@var.bordeaux.inria.fr>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127171318.2596-4-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127171318.2596-4-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

Benjamin Tissoires, on Fri 27 Jan 2017 18:13:17 +0100, wrote:
> When switching back from Gnome, the VT is not aware of the
> current state of the LEDs. So if Gnome changes them, the
> kernel still bellieves they are off, and it won't turn them
> off when switching to a new TTY.

I'm not getting that issue, please detail which graphical stack you are
using (Xorg/Wayland? input-libinput?)

Samuel
