From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Wed, 10 Jun 2009 15:15:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906101514310.7457@wotan.suse.de>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com>  <49E4E7E1.7040109@gmail.com>  <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>  <4A2ED39B.30100@gmail.com>  <alpine.LNX.2.00.0906101020400.7457@wotan.suse.de>
 <alpine.LNX.2.00.0906101053490.7457@wotan.suse.de> <1244639316.5003.8.camel@DellStudio>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-2133507199-1244639758=:7457"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47365 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbZFJNP4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 09:15:56 -0400
In-Reply-To: <1244639316.5003.8.camel@DellStudio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Andr=E9s_Le=F3n_=C1lvarez?= <locoxella@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-2133507199-1244639758=:7457
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Jun 2009, Andrés León Álvarez wrote:

> Off course, I think none of us really know about the other model of 
> mouse, so it might be unresponsible keeping the 0x1000 (I don't know if 
> a mouse can work "fine" with a different ID, for example). But so far, 
> it seems that removing the quirk for the 0x030c will solve the only 
> problem that the 0x1000 rise.

There are two separate issues

- quirk we have for 0x030c is apparently bogus, and will be removed, 
  bringing axes orientation to the expected state
- 0x1000 has a completely different problem -- scrollwheel doesn't work at 
  all, and will need some special handling that has still to be discovered

-- 
Jiri Kosina
SUSE Labs
--168427776-2133507199-1244639758=:7457--
