From: Oliver Neukum <oliver@neukum.org>
Subject: Re: lockdep report at resume
Date: Tue, 21 Apr 2009 15:59:41 +0200
Message-ID: <200904211559.43497.oliver@neukum.org>
References: <1234022517.4175.107.camel@johannes.local> <1238578840.5970.178.camel@johannes.local> <alpine.LNX.2.00.0904211550280.13028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45612 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZDUN7p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2009 09:59:45 -0400
In-Reply-To: <alpine.LNX.2.00.0904211550280.13028@wotan.suse.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>

Am Dienstag 21 April 2009 15:51:16 schrieb Jiri Kosina:
> [ thanks for the analysis Johannes ... involving also Oliver here; really
>   seems like a false positive to me ]

I think he's right. But as a matter of principle I'd like to see 
flush_scheduled_work() avoided where possible, hence the patch.

	Regards
		Oliver

