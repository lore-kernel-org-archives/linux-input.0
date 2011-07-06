From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/3 v2] input : wacom - Cleanup a return value for the
 old Bamboo
Date: Wed, 6 Jul 2011 07:52:09 +0200
Message-ID: <20110706055209.GA30776@polaris.bitmath.org>
References: <1309908360-18866-1-git-send-email-pinglinux@gmail.com>
 <CAGzDe_Ya8sFhr=h04vhtGqisbHKf7OFA+n=XVGuFo_tf2NVkWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:54422 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1GFFuP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 01:50:15 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 5AC18EA9CE
	for <linux-input@vger.kernel.org>; Wed,  6 Jul 2011 07:50:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAGzDe_Ya8sFhr=h04vhtGqisbHKf7OFA+n=XVGuFo_tf2NVkWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, Jul 05, 2011 at 09:34:08PM -0500, Chris Bagwell wrote:
> On Tue, Jul 5, 2011 at 6:26 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > The old code may call input_sync without sending any other events.
> > Although the sync event will be ignored in the userland, eliminating
> > unnecessary kernel events is the right way to go.
> 
> Aligns the code block with previous case statement as well.
> 
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

The sync will not even reach userland, but the patch wont hurt. For
all patches in the set:

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks Ping, thanks Chris.

Henrik
