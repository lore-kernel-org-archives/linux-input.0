From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for msi-wmi driver
Date: Fri, 18 Dec 2009 17:52:26 +0100
Message-ID: <4B2BB34A.2020706@suse.de>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>	<1260451099-25620-2-git-send-email-anisse@astier.eu>	<9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>	<20091214105533.6634312b@destiny.ordissimo>	<alpine.LFD.2.00.0912161238290.6089@localhost.localdomain> <20091217112849.561aee8e@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35998 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbZLRQxd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 11:53:33 -0500
In-Reply-To: <20091217112849.561aee8e@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Len Brown <lenb@kernel.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>

On 12/17/2009 11:28 AM, Anisse Astier wrote:
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
> Hi Len,
> 
> I'm willing to take maintainership for this driver, as long as I have access
> to hardware (i.e my current job).

That's great.
I never had a machine (and probably never will) and had to implement
this remotely.

And I already posted the first patch without the maintainer added :)
But it's simple, I just removed the dmi alias, because of wmi
autoloading got added recently.

Thanks,

      Thomas
