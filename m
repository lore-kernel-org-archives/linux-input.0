From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Mon, 21 Nov 2011 15:34:49 -0800
Message-ID: <4ECAE019.4000409@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:48297 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab1KUXev (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 18:34:51 -0500
In-Reply-To: <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On 11/21/2011 03:29 PM, Jiri Kosina wrote:
> So I take it that you are now working on that, is my understanding 
> correct?

Yep, though I'm still trying to see how it all fits together.  For
example, in which function should I check to see if BatteryStrength is
in the table?

Thanks,
    J
