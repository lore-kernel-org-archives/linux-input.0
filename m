From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Thu, 24 Sep 2009 11:39:01 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0909241137300.9280@wotan.suse.de>
References: <200908062247.29254.lamarque@gmail.com> <200909152144.37847.lamarque@gmail.com> <alpine.LSU.2.00.0909221733290.10090@wotan.suse.de> <200909221319.45013.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-437161954-1253785142=:9280"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40241 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbZIXJi6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 05:38:58 -0400
In-Reply-To: <200909221319.45013.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-437161954-1253785142=:9280
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 22 Sep 2009, Lamarque Vieira Souza wrote:

> Em Terça-feira 22 Setembro 2009, Jiri Kosina escreveu:
> > Hi,
> > 
> > could you please resend your patch? It has either been lost somewhere on
> > the way, or in the dark depths of my inbox, so I am not really sure which
> > one you are referring to, sorry.
> 
> Marks Acer Bluetooth Optical Rechargeable Mouse from Ferrari 4005 notebook to 
> be ignored by hid core. This change makes hid core to use input session 
> instead of hid session with that mouse. With hid session the mouse cursor 
> moves too laggy, using input session corrects this problem.

Is this wonky behavior of this mouse regression from older kernels, or has 
the mouse been misbehaving in HID mode all the time?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--168427776-437161954-1253785142=:9280--
