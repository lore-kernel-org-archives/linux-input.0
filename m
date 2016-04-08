From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Linux-v4.6-rc2] atkbd serio0: Unknown key pressed (translated
 set 2, code 0xa8 on isa0060/serio0).
Date: Fri, 8 Apr 2016 10:59:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604081059220.27368@cbobk.fhfr.pm>
References: <CA+icZUV0MGYme3EvLwYaW7HaAdKq7KQm6jgbcy58z4Vk3+n7qg@mail.gmail.com> <CA+icZUVZ05ri=Vs6UGWN0ks74_R2Q48u0=xoh2LSFwSLhpfabg@mail.gmail.com> <CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com> <CAKdAkRRT=Vq_X9Un3Zk-an42WR+ECKt-h6JxALK=4MkJkdgnow@mail.gmail.com>
 <alpine.LNX.2.00.1604072210110.27368@cbobk.fhfr.pm> <CA+icZUV69RhvfgKD8a5Bm6PPvFikq6JGUP3_q0kUj9rd=Y+JVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50831 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730AbcDHI7o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Apr 2016 04:59:44 -0400
In-Reply-To: <CA+icZUV69RhvfgKD8a5Bm6PPvFikq6JGUP3_q0kUj9rd=Y+JVQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>

On Fri, 8 Apr 2016, Sedat Dilek wrote:

> Hmm, I could not reproduce it again.
> Cursor up/down (pageup/pagedown) works again - unsure if the dmesg
> outputs are related to this.
> ( And I have some (rfc) locking patches from PeterZ on top. )

Ok, I'll not let this block for-4.6/upstream-fixes going to Linus then.

-- 
Jiri Kosina
SUSE Labs

