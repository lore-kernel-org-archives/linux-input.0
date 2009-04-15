From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] INPUT: mainstone-wm97xx, fix condition in pen_up
Date: Wed, 15 Apr 2009 13:00:32 +0100
Message-ID: <20090415120032.GC9311@sirena.org.uk>
References: <1239777830-17826-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46842 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZDOMAd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 08:00:33 -0400
Content-Disposition: inline
In-Reply-To: <1239777830-17826-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Apr 15, 2009 at 08:43:50AM +0200, Jiri Slaby wrote:
> The loop body was never executed, because the condition is
> always false. Convert to for with more obvious condition.

> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
