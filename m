From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] INPUT: mainstone-wm97xx, fix condition in pen_up
Date: Wed, 15 Apr 2009 08:35:59 -0700
Message-ID: <20090415153559.GA17335@dtor-d630.eng.vmware.com>
References: <1239777830-17826-1-git-send-email-jirislaby@gmail.com> <20090415120032.GC9311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:12441 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZDOPgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 11:36:12 -0400
Content-Disposition: inline
In-Reply-To: <20090415120032.GC9311@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Apr 15, 2009 at 01:00:32PM +0100, Mark Brown wrote
> On Wed, Apr 15, 2009 at 08:43:50AM +0200, Jiri Slaby wrote:
> > The loop body was never executed, because the condition is
> > always false. Convert to for with more obvious condition.
> 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied, thanks Jiri.

-- 
Dmitry
