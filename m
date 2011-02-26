From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] HID: ntrig don't dereference unclaimed hidinput
Date: Sat, 26 Feb 2011 08:36:33 +0100
Message-ID: <20110226073633.GA1753@polaris.bitmath.org>
References: <1298610932-21957-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:50722 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751511Ab1BZHex (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Feb 2011 02:34:53 -0500
Content-Disposition: inline
In-Reply-To: <1298610932-21957-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, chatty@enac.fr, trivial@kernel.org, peter.hutterer@who-t.net

Hi Rafi,

On Fri, Feb 25, 2011 at 12:15:31AM -0500, Rafi Rubin wrote:
> Moved the claimed input check before dereferencing field->hidinput to
> fix a reported invalid deference bug.

How long has this problem been seen? If it is recent, it should
perhaps be fixed in the hid core instead. If it turns out to be an old
problem, please add stable to the Cc.

> Switched to a goto instead of an extra indent for most of the function.

If you put these janitory changes into a separate patch, it will be
much easier to apply the bugfix to stable versions.

Thanks,
Henrik
