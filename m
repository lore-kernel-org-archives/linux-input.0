From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: NVidia Multitouch driver.
Date: Tue, 11 Jan 2011 06:30:48 +0100
Message-ID: <AANLkTike5xYAMCJKd7Lh0i4op3Z4fRDUMAOx5-s==541@mail.gmail.com>
References: <AANLkTi=KQMrFR7rO=4gY=GX-aHo+sckA8nGrE-1A9rpe@mail.gmail.com> <4D2BE29A.4060400@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f194.google.com ([209.85.213.194]:42023 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1AKFbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 00:31:09 -0500
Received: by yxd5 with SMTP id 5so4418031yxd.1
        for <linux-input@vger.kernel.org>; Mon, 10 Jan 2011 21:31:09 -0800 (PST)
In-Reply-To: <4D2BE29A.4060400@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Varun Wadekar <vwadekar@nvidia.com>
Cc: USB list <linux-input@vger.kernel.org>, Harry Hong <hhong@nvidia.com>, Gary King <gking@nvidia.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Tue, Jan 11, 2011 at 5:54 AM, Varun Wadekar <vwadekar@nvidia.com> wrote:
> Do you mean to say there are certain things missing in the touch driver?
> What do you mean by the last linux kernel?

I have found that patch by chance because I haven't seen it sent to
linux-input ml (which what is the std)
I just want it to get pushed to the mainline linux kernel as it is the
upstream of all linux distributions and for the android linux kernel
tree itself.

I just don't like to see only android getting drivers patches as it
can be seen as an action of forking the main kernel.

You can rebase the patch to the last tree and get help and feedback
from other developers for its integration. Company support of its own
drivers is very appreciated here.


And when analyzing the code I got a question. Does the nvodm hw
supports only 2 fingers or it's only caused by android limitation ?
Can the hw report more than 2 fingers ? (4 for example)

Thanks

i
