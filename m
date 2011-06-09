From: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCHv3 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Thu, 9 Jun 2011 11:30:56 -0400
Message-ID: <BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig@mail.gmail.com>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307538557-9287-4-git-send-email-ospite@studenti.unina.it>
	<20110608175251.GC20343@piper>
	<20110609155731.bd2c5a8b.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42876 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1FIPa6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 11:30:58 -0400
In-Reply-To: <20110609155731.bd2c5a8b.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

Hi,

On Thu, Jun 9, 2011 at 9:57 AM, Antonio Ospite <ospite@studenti.unina.it> wrote:
> Would you mind if I keep these three stdlib ones in? I use this code
> verbatim in another program which does not link against Glib.

But you use e.g. "g_strcmp0()", GIOChannel etc. How is that?

Also remember sed is your friend :)

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
