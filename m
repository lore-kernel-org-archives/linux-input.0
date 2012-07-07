From: Cedric Sodhi <manday@gmx.net>
Subject: Re: Regression in hid-multitouch?
Date: Sun, 8 Jul 2012 00:48:42 +0200
Message-ID: <20120707224832.GA2074@slate.Speedport_W723_V_Typ_A_1_00_092>
References: <20120707215541.GB2484@slate.Speedport_W723_V_Typ_A_1_00_092>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:39246 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751256Ab2GGOsi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 10:48:38 -0400
Content-Disposition: inline
In-Reply-To: <20120707215541.GB2484@slate.Speedport_W723_V_Typ_A_1_00_092>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@enac.fr

Sorry, this is not a regression. I just reverted to said commit and I
still have those problems (described in detail, here: 

http://comments.gmane.org/gmane.comp.freedesktop.xorg.devel/31159

- though the touchpoints are correctly recognized).

On Sat, Jul 07, 2012 at 11:55:41PM +0200, Cedric Sodhi wrote:
> What previously seems to have been fixed by 
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=3ac36d15557d1bedfb1151d9911b9587b2d40759
> 
> has again stopped working in 3.5.0-rc5 - at least I get the exact same
> problems I used to have before 3ac36d... although the code from 3ac36d
> is still there.
> 
> regards,
> Cedric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
