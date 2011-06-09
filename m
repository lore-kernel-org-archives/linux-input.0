From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHv3 2/3] Re-add manager_get_default_adapter()
Date: Thu, 09 Jun 2011 15:02:32 +0100
Message-ID: <1307628154.2669.212.camel@novo.hadess.net>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	 <1307538557-9287-3-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46024 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab1FIOCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 10:02:38 -0400
In-Reply-To: <1307538557-9287-3-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> From: Bastien Nocera <hadess@hadess.net>

Sent out a new patch for that which allows the same functionality, but
returns an ID instead (you can then get the btd_adapter through existing
manager functions).

