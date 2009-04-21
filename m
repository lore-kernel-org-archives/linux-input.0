From: Oliver Neukum <oliver@neukum.org>
Subject: Re: lockdep report at resume
Date: Tue, 21 Apr 2009 16:14:56 +0200
Message-ID: <200904211614.57288.oliver@neukum.org>
References: <1234022517.4175.107.camel@johannes.local> <200904211559.43497.oliver@neukum.org> <alpine.LNX.2.00.0904211609220.13028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:58409 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZDUOO7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2009 10:14:59 -0400
In-Reply-To: <alpine.LNX.2.00.0904211609220.13028@wotan.suse.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>

Am Dienstag 21 April 2009 16:11:03 schrieb Jiri Kosina:
> On Tue, 21 Apr 2009, Oliver Neukum wrote:
> > > [ thanks for the analysis Johannes ... involving also Oliver here;
> > > really seems like a false positive to me ]
> >
> > I think he's right. But as a matter of principle I'd like to see
> > flush_scheduled_work() avoided where possible, hence the patch.
>
> I am not entirely sure that this is the same issue as the one from #13136
> of kernel.org bugzilla.

Which flush_scheduled_work() do you think triggers it?

	Regards
		Oliver

