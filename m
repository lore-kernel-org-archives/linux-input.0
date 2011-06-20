From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Mon, 20 Jun 2011 15:53:58 +0100
Message-ID: <1308581640.6042.43.camel@novo.hadess.net>
References: <4DE1FA7F.3050308@users.sourceforge.net>
	 <1307116529.2669.130.camel@novo.hadess.net>
	 <4DEC796E.1050307@users.sourceforge.net>
	 <1307382639.2669.147.camel@novo.hadess.net>
	 <20110606194122.0fb8d46c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44035 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1FTOyD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 10:54:03 -0400
In-Reply-To: <20110606194122.0fb8d46c@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alberto Mardegan <mardy@users.sourceforge.net>, linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

On Mon, 2011-06-06 at 19:41 +0100, Alan Cox wrote:
> > When an "change" event is received on an accelerometer,
> > open its device node, and from the value, as well as the previous
> > value of the property, calculate the device's new orientation,
> > and export it as ID_INPUT_ACCELEROMETER_ORIENTATION.
> >     
> > Possible values are:
> > * undefined
> > * normal
> > * bottom-up
> > * left-up
> > * right-up
> 
> For quite a few of the discrete accelerometers not being used in
> 'joystick' mode this would make quite a sensible input interface,
> at least for those that generate inputs for their transitions.
> 
> You need a couple more values though because some devices care if they
> are held up/down/left/right or if they are lying flat on their front or
> on their back.
> 
> Phones for example sometimes go to speakerphone if laid flat on their
> back, and go into silent mode if turned over.

I'm not designing for phones though, and it seems to me this should be a
separate attribute anyway (and so did the people who wrote sensorfw for
MeeGo Handset).

