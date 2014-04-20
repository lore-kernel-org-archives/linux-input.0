From: simon@mungewell.org
Subject: Re: [PATCH 0/24] Introduce ff-memless-next as an improved
 replacement for ff-memless
Date: Sun, 20 Apr 2014 18:29:23 -0400
Message-ID: <9307026b9160edfb785b894fe6d539b7.squirrel@mungewell.org>
References: <1609685.QRL9N9sQvX@sigyn>
    <c49c4ad2bfabfe75ac065f8ad878d697.squirrel@mungewell.org>
    <CADbOyBSxHj80zA7UNq+yAtmSPgTqCXgOUUsQ30DQQ66cGw9egw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:56181 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaDTW30 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 18:29:26 -0400
In-Reply-To: <CADbOyBSxHj80zA7UNq+yAtmSPgTqCXgOUUsQ30DQQ66cGw9egw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, =?iso-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


> Did the WiiWheel have working FF_CONSTANT before this patchset?
> It would be weird if yes, because lg4ff is also used for MOMO-Black
> which works fine.

Yes, I think that the force requested by fftest was just too weak to
actually move the wheel. ffcfstress (or whatever it is called) works OK.

Simon

