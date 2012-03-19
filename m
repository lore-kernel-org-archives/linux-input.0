From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: User space raw hid support
Date: Mon, 19 Mar 2012 15:18:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203191517130.18356@pobox.suse.cz>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44E9F3@DNCE02.ent.ti.com> <CANq1E4ScdbDCTBa4H-b-yEwOEnhrX4hKV-a3TxFaOJsyYiAurA@mail.gmail.com> <CAKT1EBfEtKXAcpZ7qz1Z3RSGXR-U8aTai=CuoZ45YHBHYNUqsw@mail.gmail.com> <CAAngNMZ=9V1cAiHbZMWGiqLxro9mFHieWSBRYdZxM6d=MXyxRw@mail.gmail.com>
 <CANq1E4SsRH=aui4NmswNn1CT05ERZZiCV9LX9K3uAh_q3B14iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53408 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030838Ab2CSOSz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 10:18:55 -0400
In-Reply-To: <CANq1E4SsRH=aui4NmswNn1CT05ERZZiCV9LX9K3uAh_q3B14iw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>, Claudio Takahasi <claudio.takahasi@openbossa.org>, "Ganir, Chen" <chen.ganir@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 15 Mar 2012, David Herrmann wrote:

> Jiri, maybe you can comment on this. We are trying to provide
> hid_ll_drivers from user-space
> to implement BT-HIDP for BT-low-energy. My idea is to write an
> uinput-like interface which allows
> to register hid_ll_drivers from userspace. Do you have any objections here?

After reading the followup discussion, I don't think I have any 
fundamental objections to the overall principle proposal.

Thanks,

-- 
Jiri Kosina
SUSE Labs
