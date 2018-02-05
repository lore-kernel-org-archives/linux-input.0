From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS Trackpoint & pressure
Date: Mon, 5 Feb 2018 14:49:55 -0800
Message-ID: <20180205224955.GB46524@dtor-ws>
References: <20180204150839.b5qm4wb26vic35st@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37412 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWt7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Feb 2018 17:49:59 -0500
Content-Disposition: inline
In-Reply-To: <20180204150839.b5qm4wb26vic35st@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 04:08:39PM +0100, Pali Rohár wrote:
> Hi! Now playing again with trackpoint connected to ALPS rushmore
> touchpad and I'm seeking a nice feature. Via ALPS PS/2 protocol it
> reports pressure of trackpoint. Parser for it is already implemented in
> alps.c and value is assigned to variable "z". When I just move
> trackpoint z is zero, when I push trackpoint while moving, then z is
> number higher, maximally 32. Variable "z" is set, but unused.
> 
> Do we have some input interface which can be used to report this
> pressure of trackpoint to userspace? I can use this feature e.g. as
> additional button...

We could either do the conversion in kernel and emit BTN_LEFT, or
report ABS_PRESSURE and see if userspace will be able to handle
REL_X/REL_Y/ABS_PRESSURE device.

Adding Peter.

-- 
Dmitry
