From: simon@mungewell.org
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Fri, 3 Jun 2011 11:56:38 -0400
Message-ID: <d49388493b61c568c5ce7cd2ae9594e0.squirrel@host171.canaca.com>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
    <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
    <1304644488.16101.28.camel@novo.hadess.net>
    <20110507011412.ba0ad1e9.ospite@studenti.unina.it>
    <1304787442.2427.11.camel@novo.hadess.net>
    <20110603135904.096660bc.ospite@studenti.unina.it>
    <1307114762.2669.125.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:40436 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab1FCP4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 11:56:45 -0400
In-Reply-To: <1307114762.2669.125.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

Just generally on this subject, should the code which performs the USB
'write' be in 'hid-sony.c' rather than the BT core.

It's possible that the Sixaxis or other compatible controllers will be
only USB connected and BT might not even exist on the system.

If/When I manage to do some work on rumble support, we will probably need
to ensure that a 'hid-sonyff.c' is aware of any LED settings otherwise it
might overwrite them when setting the rumble.

Simon.

