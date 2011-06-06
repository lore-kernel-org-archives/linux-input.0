From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Mon, 06 Jun 2011 18:53:19 +0100
Message-ID: <1307382801.2669.150.camel@novo.hadess.net>
References: <4DE1FA7F.3050308@users.sourceforge.net>
	 <1307116529.2669.130.camel@novo.hadess.net>
	 <BANLkTinz12uYphhORTwGf202j-ofZi2sKJ+KoL7Auuga3NbrEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46769 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1FFRxX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 13:53:23 -0400
In-Reply-To: <BANLkTinz12uYphhORTwGf202j-ofZi2sKJ+KoL7Auuga3NbrEA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Alberto Mardegan <mardy@users.sourceforge.net>, linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

On Sat, 2011-06-04 at 19:13 +0200, Mohamed Ikbel Boulabiar wrote:
> On Fri, Jun 3, 2011 at 5:55 PM, Bastien Nocera <hadess@hadess.net> wrote:
> >
> > As soon as it's seen some testing, I'll be showing the work I did for
> > GNOME support for automatic rotation based on orientation.
> 
> And how you handle these events through X ?

As I mentioned to Alberto, and following on from the upstream push to
udev, the only thing the code does is look for uevents coming from
ID_INPUT_ACCELEROMETER=1 devices, and read the value of
ID_INPUT_ACCELEROMETER_ORIENTATION.

Certainly much easier than my previous attempts at using X to read the
values from a floating device.

