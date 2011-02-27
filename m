From: Marcin Tolysz <tolysz@gmail.com>
Subject: Re: Rewriting wheels HID descriptor for complete functionality
Date: Sun, 27 Feb 2011 22:45:54 +0000
Message-ID: <AANLkTi=O6b-XymswN+UJt7hFo=x+gDrbt9TEC1EAAurf@mail.gmail.com>
References: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
	<20101201222022.b2e49a1b.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42717 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1B0Wpz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Feb 2011 17:45:55 -0500
Received: by qwd7 with SMTP id 7so2443010qwd.19
        for <linux-input@vger.kernel.org>; Sun, 27 Feb 2011 14:45:54 -0800 (PST)
In-Reply-To: <20101201222022.b2e49a1b.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, All

I had been doing some external stuff regarding editing HID
descriptors, just to prove it could be done fairly easy:

0) read http://code.google.com/p/ghid/wiki/HowTo

1) haskell compiler to aid hid editing:
  a) install haskell-platform
  b) hg clone https://ghid.googlecode.com/hg/ ghid

2) Use the online thing which uses this comiler:
  a) http://gem4.tolysz.co.uk/ghid/
  b) you would need to click outside the texbox to make it work (it's AJAX)

3) There is a CLI script which uses the above compiler from via the
above AJAX interface:
 a) https://code.google.com/p/ghid/source/browse/Docs/eHID.pl

## those 2), 3) are using my low end server, I did only a small
regression test so am not sure if it can not be slashdoted, but my
guess, there is not this many people who wanted to see/edit their hid
descriptors to kill this server.

Regards.

ps.
Just a small apologize for this slightly off-topic.
