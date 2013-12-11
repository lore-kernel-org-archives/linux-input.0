From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve
 support
Date: Wed, 11 Dec 2013 16:00:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312111559190.1413@pobox.suse.cz>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org> <10aade622f5593ec49af0256e3c60d83.squirrel@mungewell.org> <CANq1E4QxyKNbYCBAEUQN08dxz4YfYHfZQVHG0+w=cf5Fz1XpkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55512 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab3LKPAr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Dec 2013 10:00:47 -0500
In-Reply-To: <CANq1E4QxyKNbYCBAEUQN08dxz4YfYHfZQVHG0+w=cf5Fz1XpkQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

On Sun, 8 Dec 2013, David Herrmann wrote:

> >> Anyone here want to collaborate?
> >
> > I've decoded the majority of the HID stream including the multi-touch.
> 
> Nice! I already got my hands on one but will probably not find time
> for it until February. However, I will gladly test any patches!

Good work!

> Also, could you write your findings down and maybe put it into
> ./Documentation/hid/? I'm not sure whether we put protocol data there
> (Jiri?) but at least you could share the information on the list or
> github. I would appreciate that a lot!

We've never used Documentation/hid/ for this kind of purpose, especially 
as the driver doesn't exist yet. I am not really sure whether kernel tree 
is a proper collaboration method for this.

What we have for quite a few of the existing drivers is having the 
protocol described in comments directly in the driver, usually at its very 
beginning. Would that work in this case as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs
