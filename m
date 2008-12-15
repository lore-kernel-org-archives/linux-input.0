From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] Add support for Wacom W8001 penabled serial
	touchscreen
Date: Mon, 15 Dec 2008 02:06:02 -0500
Message-ID: <20081215070601.GA1454@anvil.corenet.prv>
References: <12274510394135-git-send-email-jayakumar.lkml@gmail.com> <45a44e480812140900i1c7fdfa4odd1d217ad312e4c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:12650 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYLOHGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2008 02:06:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so571991qwe.37
        for <linux-input@vger.kernel.org>; Sun, 14 Dec 2008 23:06:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45a44e480812140900i1c7fdfa4odd1d217ad312e4c0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Dec 15, 2008 at 01:00:26AM +0800, Jaya Kumar wrote:
> On Sun, Nov 23, 2008 at 10:37 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> > Hi Dmitry, linux-input,
> >
> > Thanks for your previous feedback. I've made the improvements to drop the use
> > of cmd mutex, expected packet, cleanup and report tilt events. Let me know
> > your thoughts.
> >
> > Thanks,
> > jaya
> >
> 
> Hi Dmitry,
> 
> Was this patch okay?
> 

Hi Jaya,

The patch is in my 'next' branch, waiting for .29.

-- 
Dmitry
