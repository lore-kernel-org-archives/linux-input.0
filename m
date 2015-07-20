From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Sun, 19 Jul 2015 23:54:46 -0700
Message-ID: <20150720065446.GA13879@dtor-ws>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35951 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbbGTGyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 02:54:51 -0400
Received: by pachj5 with SMTP id hj5so97205308pac.3
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2015 23:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Sun, Jul 19, 2015 at 09:29:26AM -0400, Douglas Christman wrote:
> Hello all,
> 
> Kernel v4.1 introduces a bug for my laptop's (Toshiba Tecra A10)
> touchpad.  Clicking twice only registers as a single click (and three
> clicks are needed to double-click).
> 
> The touchpad shows up as 'AlpsPS/2 ALPS DualPoint' in dmesg.
> Bisecting drivers/input/mouse suggests that commit 92bac83d introduced
> the bug.
> 
> Please let me know if I can provide any other information that would be useful.
> 
> Filed as bug #101701 on bugzilla.

Let's add a few people...

-- 
Dmitry
