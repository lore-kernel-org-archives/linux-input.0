From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 2/4] tty/vt/keyboard: Fix Caps Lock LED on major
 distributions
Date: Fri, 27 Jan 2017 18:25:14 +0100
Message-ID: <20170127172514.GX9511@var.bordeaux.inria.fr>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127171318.2596-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127171318.2596-3-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Benjamin Tissoires, on Fri 27 Jan 2017 18:13:16 +0100, wrote:
> +static bool caps_as_controlllock;

Really, we don't want these.  Userspace could invent using another
modifier, so it's really not the way forward.  Please have a look at
what I suggested.

Samuel
