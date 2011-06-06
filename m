From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Mon, 6 Jun 2011 19:41:22 +0100
Message-ID: <20110606194122.0fb8d46c@lxorguk.ukuu.org.uk>
References: <4DE1FA7F.3050308@users.sourceforge.net>
	<1307116529.2669.130.camel@novo.hadess.net>
	<4DEC796E.1050307@users.sourceforge.net>
	<1307382639.2669.147.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40803 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752104Ab1FFSjs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 14:39:48 -0400
In-Reply-To: <1307382639.2669.147.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Alberto Mardegan <mardy@users.sourceforge.net>, linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

> When an "change" event is received on an accelerometer,
> open its device node, and from the value, as well as the previous
> value of the property, calculate the device's new orientation,
> and export it as ID_INPUT_ACCELEROMETER_ORIENTATION.
>     
> Possible values are:
> * undefined
> * normal
> * bottom-up
> * left-up
> * right-up

For quite a few of the discrete accelerometers not being used in
'joystick' mode this would make quite a sensible input interface,
at least for those that generate inputs for their transitions.

You need a couple more values though because some devices care if they
are held up/down/left/right or if they are lying flat on their front or
on their back.

Phones for example sometimes go to speakerphone if laid flat on their
back, and go into silent mode if turned over.

Alan
