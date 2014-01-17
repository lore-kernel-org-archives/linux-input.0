From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/4] HID: sony: Map gyroscopes and accelerometers to
 axes
Date: Fri, 17 Jan 2014 20:03:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401171959540.7575@pobox.suse.cz>
References: <alpine.DEB.2.10.1401162137400.15779@franz-virtual-machine> <CANq1E4RqVakRKP9PFpGjAZw-7UfbECxBC67ZAvjLFXgKQE3s2A@mail.gmail.com> <52D965E2.6010907@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42653 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbaAQTED (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 14:04:03 -0500
In-Reply-To: <52D965E2.6010907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>

On Fri, 17 Jan 2014, Frank Praznik wrote:

> Any objections to moving all of the rdesc data to an hid-sony.h header 
> file? 

Please don't. This doesn't really belong in a header file. Header files 
are used to declare things, not to have large data structures there.

There are other drivers which contain annotated descriptor and are 
readable; for example look at hid-waltop.

Thanks,

-- 
Jiri Kosina
SUSE Labs
