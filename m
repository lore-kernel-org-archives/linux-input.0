From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 16/20] HID: Only dump input if someone is listening
Date: Mon, 10 Sep 2012 21:02:26 +0200
Message-ID: <20120910190226.GA877@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-17-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1209020927130.20709@pobox.suse.cz>
 <20120902085211.GA604@polaris.bitmath.org>
 <alpine.LNX.2.00.1209031515450.20709@pobox.suse.cz>
 <20120906205745.GA419@polaris.bitmath.org>
 <alpine.LNX.2.00.1209071450190.21679@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:50265 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab2IJSza (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 14:55:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1209071450190.21679@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> Dmitry,
> 
> how do you want to handle this? I am fine with all the HID changes. So 
> either I can take it through my tree and add your Sigoff to the Input 
> patches (if you are fine with those), or vice versa (or take this through 
> git branches, i.e. you apply the Input bits, I fetch that branch, and 
> apply the rest on top of it).

I went ahead and pushed the (updated) branch to my for-next, to get
some integration coverage. It is that time. Jiri, I added your
Acked-by on the hid patches for now, hope that is alright.

Thanks,
Henrik
