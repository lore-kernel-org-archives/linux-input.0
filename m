From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [Patch-V2 0/6] HID: Support for the Logitech G920 Wheel
Date: Thu, 19 Nov 2015 12:23:11 +0100
Message-ID: <20151119112311.GH19344@mail.corp.redhat.com>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
 <alpine.LNX.2.00.1511191103140.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758270AbbKSLXT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 06:23:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1511191103140.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, Michal =?utf-8?B?TWFsw70=?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

On Nov 19 2015 or thereabouts, Jiri Kosina wrote:
> On Thu, 12 Nov 2015, Simon Wood wrote:
> 
> > Patch-V2 tweaked as per Benjamin's requests.
> 
> Looking at the patches, I am happy with them, but still would like to have 
> Benjamin's Ack/Reviewed-by before merging them.
> 
> Benjamin ... ?

Sorry, I thought my previous review was enough and that I already gave
the rev-by.

I re-read the patches and found one small left over of a rebase. Maybe
you can just fix it locally if it's not too much to ask.

The series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I'll add to my TODO list the testing of this series with the HW coming
in the move I should receive tomorrow. I don't expect much to be found,
given that I must have tested the preliminary versions of the series.
So I'd be glad if you can pull this. I'll just send a fix if there is a
need to have one.

Cheers,
Benjamin
